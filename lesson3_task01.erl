-module(lesson3_task01).
-export([first_word/0]).

first_word() ->
    BinText = <<"Some text">>,
    FirstSpace = binary:match(BinText, <<" ">>),
    case FirstSpace of
        {Pos, _} -> binary:part(BinText, 0, Pos);
        nomatch -> BinText
    end.
