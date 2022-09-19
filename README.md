# ElixirTechChallenge

An Elixir Application that takes a text file that contains this text based on SVQ: 
```
BASED: SVQ

RESERVATION
SEGMENT: Hotel BCN 2023-01-05 -> 2023-01-10

RESERVATION
SEGMENT: Flight SVQ 2023-01-05 20:40 -> BCN 22:10
SEGMENT: Flight BCN 2023-01-10 10:30 -> SVQ 11:50

RESERVATION
SEGMENT: Train SVQ 2023-02-15 09:30 -> MAD 11:00
SEGMENT: Train MAD 2023-02-17 17:00 -> SVQ 19:30

RESERVATION
SEGMENT: Hotel MAD 2023-02-15 -> 2023-02-17
```
and formats it to a user friendly format which looks like this:

```
TRIP to BCN
Flight from SVQ to BCN at 2023-01-05 20:40 to 22:10
Hotel at BCN on 2023-01-05 to 2023-01-10
Flight from BCN to SVQ at 2023-01-10 10:30 to 11:50

TRIP to MAD
Train from SVQ to MAD at 2023-02-15 09:30 to 11:00
Hotel at MAD on 2023-02-15 to 2023-02-17
Train from MAD to SVQ at 2020-02-17 17:00 to 19:30

```
To start the application:
Open Elixir's  REPL, IEX and run the appplicatin with ```iex -S mix```
To execute the function that formats our text file, run the command: ``` ElixirTechChallenge.get_all_reservation``` and hit the enter button until the new line symbol ```\n``` gets displayed. That shouuld make the end of new output displaying.


