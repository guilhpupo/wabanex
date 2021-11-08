defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns an user", %{conn: conn} do
      params = %{name: "Test Name", email: "test@test.com", password: "test123"}

      {:ok, %User{id: user_id}} =
        params
        |> Create.call()

      query = """
        query {
          getUser(id: "#{user_id}"){
            id
            email
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "getUser" => %{
                   "email" => "test@test.com",
                   "id" => _id,
                   "name" => "Test Name"
                 }
               }
             } = response
    end

    test "when an invalid id is given, returns an error", %{conn: conn} do
      query = """
        query {
          getUser(id: "invalid_id"){
            id
            email
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "errors" => [
                 %{
                   "message" => "Argument \"id\" has invalid value \"invalid_id\"."
                 }
               ]
             } = response
    end
  end

  describe "users mutations" do
    test "when all params are valid, create and returns an user", %{conn: conn} do
      mutation = """
        mutation{
          createUser(input: {name: "Test Name", email: "test@test.com", password: "test123"}){
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "email" => "test@test.com",
                   "id" => _id,
                   "name" => "Test Name"
                 }
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      mutation = """
        mutation{
          createUser(input: {name: "J", email: "Invalid email"}){
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "errors" => [
                 %{
                   "message" =>
                     "Argument \"input\" has invalid value {name: \"J\", email: \"Invalid email\"}.\nIn field \"password\": Expected type \"String!\", found null."
                 }
               ]
             } = response
    end
  end
end
