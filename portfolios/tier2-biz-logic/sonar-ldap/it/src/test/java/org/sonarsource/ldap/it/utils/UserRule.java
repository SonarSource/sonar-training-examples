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

import com.google.common.base.Predicate;
import com.sonar.orchestrator.Orchestrator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import org.junit.rules.ExternalResource;
import org.sonarqube.ws.client.GetRequest;
import org.sonarqube.ws.client.PostRequest;
import org.sonarqube.ws.client.WsClient;
import org.sonarqube.ws.client.WsResponse;

import static com.google.common.base.Strings.emptyToNull;
import static java.util.Objects.requireNonNull;
import static org.assertj.core.api.Assertions.assertThat;
import static org.sonarsource.ldap.it.utils.ItUtils.newAdminWsClient;

public class UserRule extends ExternalResource {

  private final Orchestrator orchestrator;

  private WsClient adminWsClient;

  private UserRule(Orchestrator orchestrator) {
    this.orchestrator = orchestrator;
  }

  public static UserRule from(Orchestrator orchestrator) {
    return new UserRule(requireNonNull(orchestrator, "Orchestrator instance can not be null"));
  }

  // *****************
  // Users
  // *****************

  public void verifyUserExists(String login, String name, @Nullable String email, boolean local) {
    Users.User user = verifyUserExists(login, name, email);
    assertThat(user.isLocal()).isEqualTo(local);
  }

  private Users.User verifyUserExists(String login, String name, @Nullable String email) {
    Optional<Users.User> user = getUserByLogin(login);
    assertThat(user.isPresent()).as("User with login '%s' hasn't been found", login).isTrue();
    assertThat(user.get().getLogin()).isEqualTo(login);
    assertThat(user.get().getName()).isEqualTo(name);
    assertThat(emptyToNull(user.get().getEmail())).isEqualTo(email);
    return user.get();
  }

  public void createUser(String login, String name, @Nullable String email, String password) {
    adminWsClient().wsConnector().call(
      new PostRequest("api/users/create")
        .setParam("login", login)
        .setParam("name", name)
        .setParam("email", email)
        .setParam("password", password));
  }

  private Optional<Users.User> getUserByLogin(String login) {
    return getUsers().getUsers()
      .stream()
      .filter(user -> login.equals(user.getLogin()) && user.isActive()).findFirst();
  }

  public Users getUsers() {
    WsResponse response = adminWsClient().wsConnector().call(
      new GetRequest("api/users/search"));
    assertThat(response.code()).isEqualTo(200);
    return Users.parse(response.content());
  }

  // *****************
  // User groups
  // *****************

  public List<String> getGroups() {
    WsResponse response = adminWsClient().wsConnector().call(
      new GetRequest("api/user_groups/search"));
    assertThat(response.code()).isEqualTo(200);
    return Groups.parse(response.content()).getGroups().stream().map(Groups.Group::getName).collect(Collectors.toList());
  }

  public void verifyUserGroupMembership(String userLogin, String... groups) {
    List<String> userGroups = getUserGroups(userLogin);
    assertThat(userGroups).containsOnly(groups);
  }

  private List<String> getUserGroups(String userLogin) {
    WsResponse response = adminWsClient().wsConnector().call(
      new GetRequest("api/users/groups")
        .setParam("login", userLogin)
        .setParam("selected", "selected"));
    assertThat(response.code()).isEqualTo(200);
    return Groups.parse(response.content()).getGroups().stream().map(Groups.Group::getName).collect(Collectors.toList());
  }

  private WsClient adminWsClient() {
    if (adminWsClient == null) {
      adminWsClient = newAdminWsClient(orchestrator);
    }
    return adminWsClient;
  }

  private class MatchUserLogin implements Predicate<Users.User> {
    private final String login;

    private MatchUserLogin(String login) {
      this.login = login;
    }

    @Override
    public boolean apply(@Nonnull Users.User user) {
      String login = user.getLogin();
      return login != null && login.equals(this.login) && user.isActive();
    }
  }

}
