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
defmodule HyperAuthTest do
  use ExUnit.Case, async: true

  doctest HyperAuth
  doctest HyperAuth.Authenticator.Dummy
  doctest HyperAuth.Authenticator.LDAP

  test "Add NAS-Identifier" do
    credentials = HyperAuth.add_common_credentials_attributes(%{})
    assert Map.has_key?(credentials, "NAS-Identifier")
  end
end
