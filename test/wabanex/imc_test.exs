defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, return data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
         %{
           "Alice" => 22.49134948096886,
           "Allex" => 28.83315305570579,
           "Guilherme" => 27.901234567901234,
           "Rodrigo" => 18.368892816563566
         }}

      assert response == expected_response
    end

    test "when the file doesnt exists, return an error" do
      params = %{"filename" => "wrong_filename.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error while opening file"}

      assert response == expected_response
    end
  end
end
