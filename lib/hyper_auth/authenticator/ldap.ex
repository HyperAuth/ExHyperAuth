# This file is part of HyperAuth.
# Copyright (C) 2017  Jesús Hernández Gormaz
#
# HyperAuth is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# HyperAuth is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
defmodule HyperAuth.Authenticator.LDAP do
  @behaviour HyperAuth.Authenticator
  @moduledoc """
  LDAP authenticator.

  It will verify the credentials of authentications
  based in password with a LDAP server. It requires the
  optional dependencie [Exldap](https://hex.pm/packages/exldap).
  """

  @doc """
  LDAP authentication.

  It can use an LDAP base search with the option `:ldap_base`.
  """
  def authenticate(credentials, opts) do
    username = credentials["Username"]
    password = credentials["Password"]
    if is_binary(username) and is_binary(password) do
      verify_ldap_credentials username, password, opts[:ldap_base]
    else
      nil
    end
  end

  defp verify_ldap_credentials(username, password, ldap_base) do
    case Exldap.open(2000) do
      {:ok, connection} ->
        ldap_search = if is_binary(ldap_base) do
          "CN="<>username<>","<>ldap_base
        else
          "CN="<>username
        end
        case Exldap.verify_credentials(connection, ldap_search, password) do
          :ok ->
            %{
              "uid" => username
            }
          _ ->
            nil
        end
      _ ->
        nil
    end
  end
end
