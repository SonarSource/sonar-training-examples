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
import org.junit.Test;
import org.sonarsource.ldap.it.utils.UserRule;
import org.sonarsource.ldap.server.ApacheDS;

import static java.lang.String.format;
import static org.sonarsource.ldap.it.utils.ItUtils.ldapPluginLocation;
import static org.sonarsource.ldap.it.utils.ItUtils.verifyAuthenticationIsNotOk;
import static org.sonarsource.ldap.it.utils.ItUtils.verifyAuthenticationIsOk;

public class LdapTest {

  private static final String BASE_DN = "dc=sonarsource,dc=com";

  private static ApacheDS ldapServer;
  private static Orchestrator orchestrator;
  private static UserRule userRule;

  private static void start(boolean syncGroups) {
    // Start LDAP server
    try {
      ldapServer = ApacheDS.start("sonarsource.com", BASE_DN, "target/ldap-work", null);
    } catch (Exception e) {
      throw new RuntimeException("Unable to start LDAP server", e);
    }
    importLdif("init");

    // Start Sonar with LDAP plugin
    OrchestratorBuilder orchestratorBuilder = Orchestrator.builderEnv()
      .addPlugin(ldapPluginLocation())
      // enable ldap
      .setServerProperty("sonar.security.realm", "LDAP")
      .setServerProperty("ldap.url", ldapServer.getUrl())
      // users mapping
      .setServerProperty("ldap.user.baseDn", "ou=people," + BASE_DN);

    if (syncGroups) {
      orchestratorBuilder
        // groups mapping
        .setServerProperty("ldap.group.baseDn", "ou=groups," + BASE_DN)
        .setServerProperty("ldap.group.memberFormat", "uid=$username,ou=people," + BASE_DN)
        .build();
    }

    orchestrator = orchestratorBuilder.build();
    orchestrator.start();
    userRule = UserRule.from(orchestrator);
  }

  @After
  public void stop() {
    if (orchestrator != null) {
      orchestrator.stop();
      orchestrator = null;
      userRule = null;
    }
    if (ldapServer != null) {
      try {
        ldapServer.stop();
      } catch (Exception e) {
        throw new RuntimeException("Unable to stop LDAP server", e);
      }
      ldapServer = null;
    }
  }

  /**
   * SONARPLUGINS-895, SONARPLUGINS-1311
   */
  @Test
  public void test() throws Exception {
    start(true);

    // When user exists in Sonar, but not in LDAP (technical account)
    // Then can login because admin is technical account by default
    checkAdminUserIsAvailable();

    // orchestrator.getServer().adminWsClient().userClient().create(UserParameters.create().login("admin2").name("Admin2").password("foobar").passwordConfirmation("foobar"));
    userRule.createUser("admin2", "Admin2", null, "foobar");
    verifyAuthenticationIsOk(orchestrator, "admin2", "foobar");

    // When user not exists in Sonar and in LDAP
    // Then can not login
    verifyAuthenticationIsNotOk(orchestrator, "godin", "12345");

    // Verify that we can't login with blank password (SONARPLUGINS-2493)
    verifyAuthenticationIsNotOk(orchestrator, "godin", "");

    // When user created in LDAP
    importLdif("add-user");
    // Then user created in Sonar with details from LDAP
    verifyAuthenticationIsOk(orchestrator, "godin", "12345");
    checkUserDetails();

    // When new password set in LDAP
    importLdif("change-password");
    // Then new password works in Sonar, but not old password
    verifyAuthenticationIsOk(orchestrator, "godin", "54321");
    verifyAuthenticationIsNotOk(orchestrator, "godin", "12345");
    checkUserDetails();
  }

  /**
   * SONARPLUGINS-2493
   */
  @Test
  public void blank_passwords_are_forbidden() throws Exception {
    start(true);

    importLdif("add-user-without-password");

    verifyAuthenticationIsNotOk(orchestrator, "gerard", "");
  }

  /**
   * SONARPLUGINS-895, SONARPLUGINS-1311
   */
  @Test
  public void test2() throws Exception {
    start(true);

    // When user exists in Sonar, but not in LDAP
    // Then can login
    checkAdminUserIsAvailable();

    // When user not exists in Sonar and in LDAP
    // Then can not login
    verifyAuthenticationIsNotOk(orchestrator, "godin", "12345");

    // When user created in LDAP
    importLdif("add-user");
    // Then user created in Sonar with details from LDAP
    verifyAuthenticationIsOk(orchestrator, "godin", "12345");
    checkUserDetails();

    // When new password set in LDAP
    importLdif("change-password");
    // Then new password works in Sonar, but not old password
    verifyAuthenticationIsOk(orchestrator, "godin", "54321");
    verifyAuthenticationIsNotOk(orchestrator, "godin", "12345");
    checkUserDetails();
  }

  /**
   * SONARPLUGINS-1845
   */
  @Test
  public void deactivate_group_synchronization() {
    start(false);

    // When user created in LDAP
    importLdif("add-user");
    // Then user created in Sonar with details from LDAP
    verifyAuthenticationIsOk(orchestrator, "godin", "12345");
    userRule.verifyUserExists("godin", "Evgeny Mandrikov", "test@example.org", false);
    // But without synchronization of groups
    userRule.verifyUserGroupMembership("godin", "sonar-users");
  }

  private static void importLdif(String ldifName) {
    String resourceName = format("/ldif/%s.ldif", ldifName);
    try {
      ldapServer.importLdif(LdapTest.class.getResourceAsStream(resourceName));
    } catch (Exception e) {
      throw new RuntimeException("Unable to import LDIF(" + resourceName + "): " + e.getMessage(), e);
    }
  }

  private void checkAdminUserIsAvailable() {
    verifyAuthenticationIsOk(orchestrator, "admin", "admin");
    userRule.verifyUserExists("admin", "Administrator", null, true);
    userRule.verifyUserGroupMembership("admin", "sonar-administrators", "sonar-users");
  }

  private void checkUserDetails() {
    userRule.verifyUserExists("godin", "Evgeny Mandrikov", "test@example.org", false);
    userRule.verifyUserGroupMembership("godin", "sonar-administrators", "sonar-users");
  }

}
