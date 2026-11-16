-module(sudoku).

-export([
    main/0,
    initial_board/0,
    get_row/2,
    get_column/2,
    get_box/3,
    find_empty/1,
    find_index/2,
    find_index/3,
    find_nested_index/3,
    is_valid/4,
    solve/1,
    try_candidates/4
]).

main() ->
    io:format("~p~n", [solve(initial_board())]).

initial_board() -> [
    [5,3,0,0,7,0,0,0,0],
    [6,0,0,1,9,5,0,0,0],
    [0,9,8,0,0,0,0,6,0],
    [8,0,0,0,6,0,0,0,3],
    [4,0,0,8,0,3,0,0,1],
    [7,0,0,0,2,0,0,0,6],
    [0,6,0,0,0,0,2,8,0],
    [0,0,0,4,1,9,0,0,5],
    [0,0,0,0,8,0,0,7,9]
].

%% Main Solve Recursive function
solve(Board) ->
    case find_empty(Board) of
        not_found ->
            Board;
        {Row, Col} ->
            Candidates = lists:filter(
                fun(Value) -> is_valid(Board, Row, Col, Value) end,
                lists:seq(1, 9)
            ),
            try_candidates(Board, Row, Col, Candidates)
    end.

try_candidates(_Board, _Row, _Col, []) ->
    false;

try_candidates(Board, Row, Col, [Value | Remaining]) ->
    NewBoard = set_cell(Board, Row, Col, Value),
    case solve(NewBoard) of
        false ->
            try_candidates(Board, Row, Col, Remaining);
        SolvedBoard ->
            SolvedBoard
    end.

%% Query helper functions
get_row(Board, Row) -> 
    lists:nth(Row, Board).

get_column([], _Col) ->
    [];

get_column([Row | Rest], Col) ->
    [lists:nth(Col, Row) | get_column(Rest, Col)].

get_box(Row, Col, Board) ->
    StartRow = 3 * ((Row - 1) div 3) + 1,
    StartCol = 3 * ((Col - 1) div 3) + 1, 
    lists:sublist(lists:nth(StartRow, Board), StartCol, 3)
    ++ lists:sublist(lists:nth(StartRow + 1, Board), StartCol, 3)
    ++ lists:sublist(lists:nth(StartRow + 2, Board), StartCol, 3).


%% Finding the next empty value to solve
find_empty(Board) ->
    find_nested_index(0, Board, 1).

find_index(Item, List) ->
    find_index(Item, List, 1).

find_index(_, [], _) ->
    not_found;

find_index(Item, [Item | _], Index) ->
    Index;

find_index(Item, [_ | Rest], Index) ->
    find_index(Item, Rest, Index + 1).

find_nested_index(_, [], _) ->
    not_found;

find_nested_index(Item, [Inner | Rest], OuterIndex) ->
    case find_index(Item, Inner) of
        not_found ->
            find_nested_index(Item, Rest, OuterIndex + 1);
        ColumnIndex ->
            {OuterIndex, ColumnIndex}
    end.

%% Validates a cell value selection
is_valid(Board, Row, Col, Value) -> 
    RowSample = get_row(Board, Row),
    ColSample = get_column(Board, Col),
    BoxSample = get_box(Row, Col, Board),
    not (
        lists:member(Value, RowSample) or 
        lists:member(Value, ColSample) or 
        lists:member(Value, BoxSample)
    ).

%% create a new board with the specified value assignment
set_cell(Board, Row, Col, Value) ->
    OldRow = get_row(Board, Row),
    NewRow =
        lists:sublist(OldRow, Col - 1)
        ++ [Value]
        ++ lists:nthtail(Col, OldRow),
    lists:sublist(Board, Row - 1)
        ++ [NewRow]
        ++ lists:nthtail(Row, Board).