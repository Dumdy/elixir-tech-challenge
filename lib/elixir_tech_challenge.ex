defmodule ElixirTechChallenge do
  @moduledoc """
  This module contains functions which processes a text file containing travel reservation information based on SVQ and formats it to a human readable format

  """
  @input_file "./input.txt"

  @doc """
  Returns reservation informmation in human readable format.
  Users are expected to hit the enter key on their keyboards to get the output in it's entirety
  This is because we used "IO.get/1" to display the information. using IO.get/1 requires user input.

  ## Examples
  You are expected to hit the enter key consistently until all output is displayed

      iex> get_all_reservations()

        TRIP to BCN
        Flight from SVQ to BCN at 2023-01-05 20:40 to  22:10
        Hotel at BCN on 2023-01-05 to 2023-01-10
        Flight from BCN to SVQ at 2023-01-10 10:30 to  11:50

        TRIP to MAD
        Train from SVQ to MAD at 2023-02-15 09:30 to  11:00
        Hotel at MAD on 2023-02-15 to 2023-02-17
        Train from MAD to 2023-02-17 17:00 to SVQ 19:30
  """
  def get_all_reservations() do
    read_and_format_bcn_reservations()

    read_and_format_mad_reservations()
  end

  # After reading the input file and processing it's content we had to seperate
  # the MAD reservationns from the other reservations and format it for readability
  def read_and_format_mad_reservations() do
    mad_reservations = get_mad_reservations()

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

  # After reading the input file and processing it's content we had
  # We had to take filter for only "BCN" reservations and format it for readability
  defp read_and_format_bcn_reservations() do
    bcn_reservations = get_bcn_reservations_from_file()

    first_reservation =
      if is_list(bcn_reservations) == true do
        bcn_reservations
        |> Enum.fetch!(1)
        |> String.replace("SEGMENT:", "")
        |> String.replace("->", "to")
        |> String.replace("BCN", "")
        |> String.replace("Flight SVQ", "Flight from SVQ to BCN at")
        |> String.trim()
      else
        "Sorry input file not found"
      end

    second_reservation =
      if is_list(bcn_reservations) == true do
        bcn_reservations
        |> Enum.fetch!(0)
        |> String.replace("SEGMENT:", "")
        |> String.replace("->", "to")
        |> String.replace("Hotel BCN", "Hotel at BCN on")
        |> String.trim()
      else
        "Sorry input file not found"
      end

    third_reservation =
      if is_list(bcn_reservations) do
        bcn_reservations
        |> Enum.fetch!(2)
        |> String.replace("SEGMENT:", "")
        |> String.replace("->", "to")
        |> String.replace("SVQ", "")
        |> String.replace("Flight BCN", "Flight from BCN to SVQ at")
        |> String.trim()
      else
        "Sorry input file not found"
      end

    concat_reservations =
      first_reservation <> "\n" <> second_reservation <> "\n" <> third_reservation <> "\n"

    IO.puts("TRIP to BCN")
    IO.gets(concat_reservations)
  end

  # This function reads reservations content from the input file,
  # splits the content across new line characters,
  # sorts the content in descending order, takes out the words "RESERVATION"
  # in the list, and outputs only "MAD" reservations.
  def read_file() do
    reservations =
      case File.open(@input_file, [:read, :write], fn file ->
             IO.read(file, :all)
           end) do
        {:ok, reservations} -> reservations
        {:error, _reason} -> "File could not be read"
      end

    processed_file =
      if reservations do
        reservations
        |> String.split("\n", trim: true)
        |> Enum.sort_by(& &1, :desc)
        |> Enum.take_while(fn value -> value != "RESERVATION" end)
      else
        "Something went wrong"
      end

    processed_file
  end

  defp get_mad_reservations do
    file = read_file()

    mad_reservations =
      if is_list(file) == true and Enum.empty?(file) == false do
        file
        |> Enum.take_while(fn value -> String.contains?(value, "MAD") == true end)
      else
        "could not read file"
      end

    mad_reservations
  end

  # This function reads the content of the input file,
  # splits the content across new line characters,
  # sorts the content in descending order, and takes out the words "RESERVATION"
  # get all BCN reservations by subtracting the list of MAD reservations from the list of all reservations,
  # the result will be the list of only BCN reservations
  defp get_bcn_reservations_from_file() do
    file = read_file()

    bcn_reservations =
      if is_list(file) == true and Enum.empty?(file) == false do
        file -- get_mad_reservations()
      else
        "Could not read file"
      end

    bcn_reservations
  end
end
