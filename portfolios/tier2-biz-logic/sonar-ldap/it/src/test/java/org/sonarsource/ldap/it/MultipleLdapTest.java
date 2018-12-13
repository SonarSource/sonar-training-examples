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
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.sonarsource.ldap.server.ApacheDS;

import static org.sonarsource.ldap.it.utils.ItUtils.ldapPluginLocation;
import static org.sonarsource.ldap.it.utils.ItUtils.verifyAuthenticationIsNotOk;
import static org.sonarsource.ldap.it.utils.ItUtils.verifyAuthenticationIsOk;

public class MultipleLdapTest {

  private static final String BASE_DN1 = "dc=example,dc=org";
  private static final String BASE_DN2 = "dc=infosupport,dc=com";

  private ApacheDS ldapServer1;
  private ApacheDS ldapServer2;
  private Orchestrator orchestrator;

  @Before
  public void start() {
    OrchestratorBuilder orchestratorBuilder = Orchestrator.builderEnv()
      .addPlugin(ldapPluginLocation());

    // Start LDAP server
    try {
      ldapServer1 = ApacheDS.start("sonarsource.com", BASE_DN1, "target/ldap1-work");
      ldapServer2 = ApacheDS.start("sonarsource.com", BASE_DN2, "target/ldap2-work");
    } catch (Exception e) {
      throw new RuntimeException("Unable to start LDAP server", e);
    }
    importLdif(ldapServer1, "users.example.org");
    importLdif(ldapServer2, "users.infosupport.com");

    // Start Sonar with LDAP plugin
    orchestratorBuilder.setServerProperty("sonar.security.savePassword", "true")
      // enable ldap
      .setServerProperty("sonar.security.realm", "LDAP")
      .setServerProperty("ldap.servers", "example,infosupport")
      .setServerProperty("ldap.example.url", ldapServer1.getUrl())
      .setServerProperty("ldap.infosupport.url", ldapServer2.getUrl())
      // users mapping
      .setServerProperty("ldap.example.user.baseDn", "ou=users," + BASE_DN1)
      .setServerProperty("ldap.infosupport.user.baseDn", "ou=users," + BASE_DN2)
      // groups mapping
      .setServerProperty("ldap.example.group.baseDn", "ou=groups," + BASE_DN1)
      .setServerProperty("ldap.infosupport.group.baseDn", "ou=groups," + BASE_DN2)
      .build();

    orchestrator = orchestratorBuilder.build();
    orchestrator.start();
  }

  @After
  public void stop() {
    if (orchestrator != null) {
      orchestrator.stop();
      orchestrator = null;
    }
    if (ldapServer1 != null) {
      try {
        ldapServer1.stop();
      } catch (Exception e) {
        throw new RuntimeException("Unable to stop LDAP server", e);
      } finally {
        ldapServer1 = null;
        if (ldapServer2 != null) {
          try {
            ldapServer2.stop();
          } catch (Exception e) {
            throw new RuntimeException("Unable to stop LDAP server", e);
          }
          ldapServer2 = null;
        }
      }
    }
  }

  /**
   * SONARPLUGINS-2793
   */
  @Test
  public void testLoginOnMultipleServers() throws Exception {
    verifyAuthenticationIsOk(orchestrator, "godin", "secret1");
    verifyAuthenticationIsOk(orchestrator, "robby", "secret1");
    // Same user with different password in server 2
    verifyAuthenticationIsOk(orchestrator, "godin", "secret2");

    verifyAuthenticationIsNotOk(orchestrator, "godin", "12345");
    verifyAuthenticationIsNotOk(orchestrator, "foo", "12345");
  }

  private static void importLdif(ApacheDS server, String ldifName) {
    String resourceName = "/ldif/" + ldifName + ".ldif";
    try {
      server.importLdif(MultipleLdapTest.class.getResourceAsStream(resourceName));
    } catch (Exception e) {
      throw new RuntimeException("Unable to import LDIF(" + resourceName + "): " + e.getMessage(), e);
    }
  }

}
