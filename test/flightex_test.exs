defmodule FlightexTest do
  use ExUnit.Case

  alias Flightex.Bookings.Agent, as: BookingAgent

  import Flightex.Factory

  describe "test create_user/1" do
    test "when all params are valid, create and returns the user" do
      {:ok, response} =
        Flightex.create_user(%{
          name: "Jp",
          email: "jp@banana.com",
          cpf: "12345678900"
        })

      expected_response = build(:users, id: response.id)

      assert response == expected_response
    end
  end

  describe "test create_booking/1" do
    setup do
      BookingAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, create a booking" do
      params = %{
        complete_date: ~N[2001-05-07 03:05:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "e9f7d281-b9f2-467f-9b34-1b284ed58f9e"
      }

      {:ok, uuid} = Flightex.create_booking(params)

      {:ok, response} = Flightex.get_booking(uuid)

      expected_response = %Flightex.Bookings.Booking{
        id: response.id,
        complete_date: ~N[2001-05-07 03:05:00],
        local_destination: "Bananeiras",
        local_origin: "Brasilia",
        user_id: "e9f7d281-b9f2-467f-9b34-1b284ed58f9e"
      }

      assert response == expected_response
    end
  end
end
