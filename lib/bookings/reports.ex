defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(filename \\ "report.csv") do
    booking_list = build_booking_list()

    File.write(filename, booking_list)
  end

  def generate_report(from_date, to_date) do
    booking_list = build_booking_list_filtered(from_date, to_date)

    File.write("report-filtered.csv", booking_list)

    {:ok, "Report generated successfully"}
  end

  defp build_booking_list do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp build_booking_list_filtered(from_date, to_date) do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.sort()
    |> Enum.map(fn booking ->
      if from_date <= booking.complete_date and booking.complete_date >= to_date do
        booking_string(booking)
      else
        ""
      end
    end)

    # |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         complete_date: complete_date,
         local_origin: local_origin,
         local_destination: local_destination,
         user_id: user_id
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
