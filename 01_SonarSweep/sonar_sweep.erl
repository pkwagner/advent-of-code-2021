-module(sonar_sweep).

-export([part1/0, part2/0]).

-define(INPUT_FILE, "input.txt").

part1() -> solve(1).
part2() -> solve(3).

solve(Offset) ->
    Input = read_input(),
    count_greater(lists:sublist(Input, length(Input) - Offset), lists:nthtail(Offset, Input)).

count_greater([X | A], [Y | B]) when Y > X -> count_greater(A, B) + 1;
count_greater([_ | A], [_ | B]) -> count_greater(A, B);
count_greater([], []) -> 0.

read_input() ->
    {ok, File} = file:open([?INPUT_FILE], [read]),
    try read_int_file(File) after file:close(File) end.

read_int_file(File) ->
    case io:get_line(File, []) of
        eof -> [];
        Line ->
            {Num, "\n"} = string:to_integer(Line),
            [Num | read_int_file(File)]
    end.
