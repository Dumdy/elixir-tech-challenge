defmodule ElixirTechChallenge do
  @moduledoc """
  This module contains functions which processes a text file containing travel reservation information based on SVQ and formats it to a human readable format

  """
  @input_file "./input.txt"

  
  def get_all_reservations() do
    read_and_format_bcn_reservations()

    read_and_format_mad_reservations()
  end

  defp read_and_format_mad_reservations() do
    mad_reservations = get_mad_reservation_from_file()

    first_reservation =
      mad_reservations
      |> Enum.fetch!(0)
      |> String.replace("SEGMENT:", "")
      |> String.replace("->", "to")
      |> String.replace("MAD", "")
      |> String.replace("Train SVQ", "Train from SVQ to MAD at")
      |> String.trim()

    second_reservation =
      mad_reservations
      |> Enum.fetch!(2)
      |> String.replace("SEGMENT:", "")
      |> String.replace("->", "to")
      |> String.replace("Hotel MAD", "Hotel at MAD on")
      |> String.trim()

    third_reservation =
      mad_reservations
      |> Enum.fetch!(1)
      |> String.replace("SEGMENT:", "")
      |> String.replace("->", "to")
      |> String.replace("Train MAD", "Train from MAD to")
      |> String.trim()

    concat_reservations =
      first_reservation <> "\n" <> second_reservation <> "\n" <> third_reservation <> "\n"

    IO.puts("TRIP to MAD")
    IO.gets(concat_reservations)
  end

  defp read_and_format_bcn_reservations() do
    bcn_reservations = get_bcn_reservations_from_file()

    first_reservation =
      bcn_reservations
      |> Enum.fetch!(1)
      |> String.replace("SEGMENT:", "")
      |> String.replace("->", "to")
      |> String.replace("BCN", "")
      |> String.replace("Flight SVQ", "Flight from SVQ to BCN at")
      |> String.trim()

    second_reservation =
      bcn_reservations
      |> Enum.fetch!(0)
      |> String.replace("SEGMENT:", "")
      |> String.replace("->", "to")
      |> String.replace("Hotel BCN", "Hotel at BCN on")
      |> String.trim()

    third_reservation =
      bcn_reservations
      |> Enum.fetch!(2)
      |> String.replace("SEGMENT:", "")
      |> String.replace("->", "to")
      |> String.replace("SVQ", "")
      |> String.replace("Flight BCN", "Flight from BCN to SVQ at")
      |> String.trim()

    concat_reservations =
      first_reservation <> "\n" <> second_reservation <> "\n" <> third_reservation <> "\n"

    IO.puts("TRIP to BCN")
    IO.gets(concat_reservations)
  end

  defp get_mad_reservation_from_file() do
    {:ok, reservations} =
      File.open(@input_file, [:read, :write], fn file ->
        IO.read(file, :all)
      end)

    reservations
    |> String.split("\n", trim: true)
    |> Enum.sort_by(& &1, :desc)
    |> Enum.take_while(fn value -> value != "RESERVATION" end)
    |> Enum.take_while(fn value -> String.contains?(value, "MAD") == true end)
  end

  defp get_bcn_reservations_from_file() do
    {:ok, reservations} =
      File.open(@input_file, [:read, :write], fn file ->
        IO.read(file, :all)
      end)

    all_reservations =
      reservations
      |> String.split("\n", trim: true)
      |> Enum.sort_by(& &1, :desc)
      |> Enum.take_while(fn value -> value != "RESERVATION" end)

    bcn_reservations = all_reservations -- get_mad_reservation_from_file()

    bcn_reservations
  end
end
