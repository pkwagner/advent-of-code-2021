-module(dive).

-export([part1/0, part2/0]).

-define(INPUT_FILE, "input.txt").
-define(INPUT_REGEX, <<"^(forward|down|up) (\\d+)$">>).

part1() -> 
    Commands = read_commands(),
    {X, Depth} = lists:foldl(fun reduce/2, {0, 0}, Commands),
    X * Depth.

part2() -> 
    Commands = read_commands(),
    {X, Depth, _} = lists:foldl(fun reduce_with_aim/2, {0, 0, 0}, Commands),
    X * Depth.

reduce({forward, N}, {X, Depth}) -> {X + N, Depth};
reduce({down, N}, {X, Depth}) -> {X, Depth + N};
reduce({up, N}, {X, Depth}) -> {X, Depth - N}.

reduce_with_aim({forward, N}, {X, Depth, Aim}) -> {X + N, Depth + Aim * N, Aim};
reduce_with_aim({down, N}, {X, Depth, Aim}) -> {X, Depth, Aim + N};
reduce_with_aim({up, N}, {X, Depth, Aim}) -> {X, Depth, Aim - N}.

read_commands() ->
    {ok, Content} = file:read_file([?INPUT_FILE]),
    {match, Commands} = re:run(Content, [?INPUT_REGEX], [global, multiline, {capture, all_but_first, binary}]),
    lists:map(fun([Command, N]) -> {binary_to_atom(Command), binary_to_integer(N)} end, Commands).
