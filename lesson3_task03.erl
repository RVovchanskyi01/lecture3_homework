-module(lesson3_task03).
-export([split/2]).

split(BinText, Separator) ->
    split_parts(BinText, Separator, []).

split_parts(<<>>, _Separator, Acc) -> lists:reverse(Acc);
split_parts(BinText, Separator, Acc) ->
    case binary:match(BinText, Separator) of
        {Pos, _} ->
            Part = binary:part(BinText, 0, Pos),
            Rest = binary:part(BinText, Pos + byte_size(Separator), byte_size(BinText) - Pos - byte_size(Separator)),
            split_parts(Rest, Separator, [Part | Acc]);
        nomatch ->
            lists:reverse([BinText | Acc])
    end.
