defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.{Repo, User}
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Anderson",
        nickname: "anderson",
        email: "anderson@email.com",
        age: 32,
        password: "123456"
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Anderson", age: 32, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Anderson",
        nickname: "anderson",
        email: "anderson@email.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert expected_response == errors_on(changeset)
    end
  end
end
