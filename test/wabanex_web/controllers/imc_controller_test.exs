defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, returns the imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "result" => %{
          "Alice" => 22.49134948096886,
          "Allex" => 28.83315305570579,
          "Guilherme" => 27.901234567901234,
          "Rodrigo" => 18.368892816563566
        }
      }

      assert response == expected_response
    end

    test "when there ar invalid params, returns an error", %{conn: conn} do
      params = %{"filename" => "wrong_filename.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = %{"result" => "Error while opening file"}

      assert response == expected_response
    end
  end
end
