defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, return a valid changeset" do
      params = %{name: "José", email: "jose@email.com", password: "senha123"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{name: "José", email: "jose@email.com", password: "senha123"},
               errors: []
             } = response
    end

    test "when there are invalid params, return an invalid changeset" do
      params = %{name: "J", email: "jose"}

      response = User.changeset(params)

      expected_errors = %{
        email: ["has invalid format"],
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_errors
    end
  end
end
