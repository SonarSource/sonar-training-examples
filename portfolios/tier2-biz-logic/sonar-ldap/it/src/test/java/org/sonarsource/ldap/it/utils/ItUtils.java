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
package org.sonarsource.ldap.it.utils;

import com.sonar.orchestrator.Orchestrator;
import com.sonar.orchestrator.container.Server;
import com.sonar.orchestrator.locator.FileLocation;
import com.sonar.orchestrator.locator.Location;
import java.io.File;
import javax.annotation.Nullable;
import org.sonarqube.ws.client.GetRequest;
import org.sonarqube.ws.client.HttpConnector;
import org.sonarqube.ws.client.WsClient;
import org.sonarqube.ws.client.WsClientFactories;
import org.sonarqube.ws.client.WsResponse;

import static com.sonar.orchestrator.container.Server.ADMIN_LOGIN;
import static com.sonar.orchestrator.container.Server.ADMIN_PASSWORD;
import static java.net.HttpURLConnection.HTTP_OK;
import static java.net.HttpURLConnection.HTTP_UNAUTHORIZED;
import static org.assertj.core.api.Assertions.assertThat;

public class ItUtils {

  public static Location ldapPluginLocation() {
    return FileLocation.byWildcardMavenFilename(new File("../sonar-ldap-plugin/target/"), "sonar-ldap-plugin-*.jar");
  }

  public static String AUTHORIZED = "authorized";
  public static String NOT_AUTHORIZED = "not authorized";

  private ItUtils() {
  }

  public static WsClient newAdminWsClient(Orchestrator orchestrator) {
    return newUserWsClient(orchestrator, ADMIN_LOGIN, ADMIN_PASSWORD);
  }

  public static WsClient newUserWsClient(Orchestrator orchestrator, @Nullable String login, @Nullable String password) {
    Server server = orchestrator.getServer();
    return WsClientFactories.getDefault().newClient(HttpConnector.newBuilder()
      .url(server.getUrl())
      .credentials(login, password)
      .build());
  }

  public static void verifyAuthenticationIsOk(Orchestrator orchestrator, String login, String password) {
    assertThat(checkAuthenticationWithWebService(orchestrator, login, password).code()).isEqualTo(HTTP_OK);
  }

  public static void verifyAuthenticationIsNotOk(Orchestrator orchestrator, String login, String password) {
    assertThat(checkAuthenticationWithWebService(orchestrator, login, password).code()).isEqualTo(HTTP_UNAUTHORIZED);
  }

  public static WsResponse checkAuthenticationWithWebService(Orchestrator orchestrator, String login, String password) {
    WsClient wsClient = newUserWsClient(orchestrator, login, password);
    // Call any WS
    return wsClient.wsConnector().call(new GetRequest("api/rules/search"));
  }
}
