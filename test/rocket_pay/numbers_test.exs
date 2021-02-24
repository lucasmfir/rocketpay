defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "when there is a file return the sum" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "when there isnt a file return the sum" do
      response = Numbers.sum_from_file("invalid_name")

      expected_response = {:error, %{message: "Invalid File"}}

      assert response == expected_response
    end
  end
end
