defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate, as: BookingCreateOrUpdate
  alias Flightex.Bookings.Report
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: UserCreateOrUpdate

  def start_agents do
    BookingAgent.start_link(%{})
    UserAgent.start_link(%{})
  end

  defdelegate create_or_update_booking(params), to: BookingCreateOrUpdate, as: :call

  defdelegate create_or_update_user(params), to: UserCreateOrUpdate, as: :call

  defdelegate generate_report(from_date, to_date), to: Report, as: :generate_report

  defdelegate get_booking(params), to: BookingAgent, as: :get
end
