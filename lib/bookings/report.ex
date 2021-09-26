defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(filename \\ "report.csv") do
    booking_list = build_bookings_list()

    File.write(filename, booking_list)
  end

  defp build_bookings_list() do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(fn order -> booking_string(order) end)
    |> IO.inspect()
  end

  defp booking_string(%Booking{
         complete_date: complete_date,
         local_origin: local_origin,
         local_destination: local_destination,
         user_id: user_id
       }) do
    formated_date = format_date(complete_date)

    "#{user_id}, #{local_origin}, #{local_destination},#{formated_date}"
  end

  defp format_date(date) do
    year = date.year
    month = date.month
    day = date.day
    time = Calendar.strftime(date, "%X")

    "#{year}-#{month}-#{day} #{time}"
  end
end
