defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(%{
        user_id: user_id,
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination
      }) do
    with {:ok, response} <- Booking.build(complete_date, local_origin, local_destination, user_id) do
      BookingAgent.save(response)
    end
  end
end
