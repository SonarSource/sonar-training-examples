/*
 * SonarQube LDAP Plugin :: Integration Tests
 * Copyright (C) 2009-2017 SonarSource SA
 * mailto:info AT sonarsource DOT com
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
package org.sonarsource.ldap.it;

import com.sonar.orchestrator.Orchestrator;
import com.sonar.orchestrator.OrchestratorBuilder;
import com.sonar.orchestrator.version.Version;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import org.junit.After;
import org.junit.Test;
import org.sonarsource.ldap.server.ApacheDS;

import static org.apache.commons.io.FileUtils.readFileToString;
import static org.assertj.core.api.Assertions.assertThat;
import static org.sonarsource.ldap.it.utils.ItUtils.checkAuthenticationWithWebService;
import static org.sonarsource.ldap.it.utils.ItUtils.ldapPluginLocation;

public class ReferralLdapTest {

  private static final String BASE_DN = "dc=sonarsource,dc=com";

  private Orchestrator orchestrator;
  private List<ApacheDS> ldapServers = new ArrayList<>();

  @After
  public void stop() {
    if (orchestrator != null) {
      orchestrator.stop();
      orchestrator = null;
    }
    for (ApacheDS ldapServer : ldapServers) {
      try {
        ldapServer.stop();
      } catch (Exception e) {
        throw new RuntimeException("Unable to stop LDAP server", e);
      }
    }
  }

  @Test
  public void by_default_referral_is_followed() throws Exception {
    ApacheDS refServer = startLDAPServer(1026, "ref-remote");
    ApacheDS baseServer = startLDAPServer(1025, "ref-base");
    startOrchestrator("ldap.url", baseServer.getUrl());

    checkAuthenticationWithWebService(orchestrator, "godin", "12345");

    assertThat(readFileToString(getLogs()))
      .contains("java.naming.referral=follow")
      .contains("cn=Evgeny Mandrikov,ou=people,dc=sonarsource,dc=com");
  }

  @Test
  public void fail_when_referral_server_is_invalid() throws Exception {
    ApacheDS refServer = startLDAPServer(9999, "ref-remote");
    // Base server is linked to a ref server on port 1026
    ApacheDS baseServer = startLDAPServer(1025, "ref-base");
    startOrchestrator("ldap.url", baseServer.getUrl());

    checkAuthenticationWithWebService(orchestrator, "godin", "12345");

    assertThat(readFileToString(getLogs()))
      .contains("java.naming.referral=follow")
      .contains("javax.naming.CommunicationException: localhost:1026")
      .contains("User godin not found in <default>")
      .doesNotContain("cn=Evgeny Mandrikov,ou=people,dc=sonarsource,dc=com");
  }

  @Test
  public void ignore_referral_server_when_referral_is_set_to_ignore() throws Exception {
    ApacheDS refServer = startLDAPServer(9999, "ref-remote");
    // Base server is linked to a ref server on port 1026
    ApacheDS baseServer = startLDAPServer(1025, "ref-base");
    startOrchestrator("ldap.url", baseServer.getUrl(), "ldap.followReferrals", "ignore");

    checkAuthenticationWithWebService(orchestrator, "godin", "12345");

    assertThat(readFileToString(getLogs()))
      .contains("java.naming.referral=ignore")
      .contains("User godin not found in <default>")
      .doesNotContain("cn=Evgeny Mandrikov,ou=people,dc=sonarsource,dc=com")
      .doesNotContain("javax.naming.CommunicationException: localhost:1026");
  }

  private ApacheDS startLDAPServer(int port, String ldifName) {
    try {
      ApacheDS ldapServer = ApacheDS.start("sonarsource.com", BASE_DN, "target/ldap-work-" + port, port);
      importLdif(ldapServer, ldifName);
      ldapServers.add(ldapServer);
      return ldapServer;
    } catch (Exception e) {
      throw new RuntimeException("Unable to start LDAP server", e);
    }
  }

  private static void importLdif(ApacheDS server, String ldifName) {
    String resourceName = "/ldif/" + ldifName + ".ldif";
    try {
      server.importLdif(ReferralLdapTest.class.getResourceAsStream(resourceName));
    } catch (Exception e) {
      throw new RuntimeException("Unable to import LDIF(" + resourceName + "): " + e.getMessage(), e);
    }
  }

  private void startOrchestrator(String... properties) {
    OrchestratorBuilder orchestratorBuilder = Orchestrator.builderEnv()
      .addPlugin(ldapPluginLocation())
      // enable ldap
      // .setServerProperty("ldap.followReferrals", "false")
      .setServerProperty("sonar.log.level", "DEBUG")
      .setServerProperty("sonar.security.realm", "LDAP")
      // users mapping
      .setServerProperty("ldap.user.baseDn", "ou=people," + BASE_DN);
    for (int i = 0; i < properties.length; i += 2) {
      orchestratorBuilder.setServerProperty(properties[i], properties[i + 1]);
    }
    orchestrator = orchestratorBuilder.build();
    orchestrator.start();
  }

  private File getLogs() {
    Version version = orchestrator.getDistribution().version().orElseThrow(() -> new IllegalStateException("Version is not available"));
    if (version.isGreaterThanOrEquals("6.2")) {
      return orchestrator.getServer().getWebLogs();
    }
    // TODO remove it when LDAP will be no more compatible with SonarQube 6.1
    return orchestrator.getServer().getLogs();
  }

}
