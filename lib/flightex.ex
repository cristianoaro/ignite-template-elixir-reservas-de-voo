defmodule Flightex do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUsers

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBookings

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_user(params), to: CreateOrUpdateUsers, as: :call

  defdelegate create_booking(params), to: CreateOrUpdateBookings, as: :call
  defdelegate create_or_update_booking(params), to: CreateOrUpdateBookings, as: :call

  defdelegate get_booking(params), to: BookingAgent, as: :get
end
