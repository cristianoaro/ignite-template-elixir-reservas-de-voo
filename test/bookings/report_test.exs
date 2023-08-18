# Este teste é opcional, mas vale a pena tentar e se desafiar 😉

defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: true

  alias Flightex.Bookings.Report

  describe "generate/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when called, return the content" do
      params = %{
        complete_date: ~N[2001-05-07 12:00:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900",
        id: UUID.uuid4()
      }

      content = "12345678900, Brasilia, Bananeiras, 2001-5-7 12:00:00"

      Flightex.create_or_update_booking(params)
      Report.generate("report-test.csv")
      {:ok, file} = File.read("report-test.csv")

      assert file =~ content
    end
  end

  describe "generate_report/2" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when called, return the content" do
      params1 = %{
        complete_date: ~N[2001-05-07 12:00:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900",
        id: UUID.uuid4()
      }

      params2 = %{
        complete_date: ~N[2001-05-08 12:00:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900",
        id: UUID.uuid4()
      }

      params3 = %{
        complete_date: ~N[2001-05-09 12:00:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900",
        id: UUID.uuid4()
      }

      content =
        "12345678900,Brasilia,Bananeiras,2001-05-08 12:00:00\n12345678900,Brasilia,Bananeiras,2001-05-09 12:00:00\n"

      Flightex.create_or_update_booking(params3)
      Flightex.create_or_update_booking(params1)
      Flightex.create_or_update_booking(params2)

      Report.generate_report(~N[2001-05-07 12:00:00], ~N[2001-05-08 12:00:00])
      {:ok, file} = File.read("report-filtered.csv")

      assert file =~ content
    end
  end
end
