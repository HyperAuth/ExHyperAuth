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
defmodule HyperAuth do
  @moduledoc """
  Authentication.
  """

  @doc """
  Authenticate the credentials.
  """
  def authenticate(credentials, opts) do
    # Call the configured authenticator module
    authenticator_module = opts[:authenticator]
    if is_nil authenticator_module do
      nil
    else
      credentials = add_common_credentials_attributes(credentials)
      user = authenticator_module.authenticate credentials, opts
      # All user map need an UID
      if is_nil user["uid"] do
        nil
      else
        user
      end
    end
  end

  @doc """
  Add to credentials common values (for example: "NAS-Identifier").
  """
  def add_common_credentials_attributes(credentials) do
    nas_identifier = Atom.to_string(node())
    Map.put(credentials, "NAS-Identifier", nas_identifier)
  end
end
