-module(lesson3_task02).
-export([words/1]).

words(BinText) ->
    split_words(BinText, []).

split_words(<<>>, Acc) -> lists:reverse(Acc);
split_words(BinText, Acc) ->
    FirstSpace = binary:match(BinText, <<" ">>),
    case FirstSpace of
        {Pos, _} ->
            Word = binary:part(BinText, 0, Pos),
            Rest = binary:part(BinText, Pos + 1, byte_size(BinText) - Pos - 1),
            split_words(Rest, [Word | Acc]);
        nomatch ->
            lists:reverse([BinText | Acc])
    end.
