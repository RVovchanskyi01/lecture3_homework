-module(lesson3_task04).
-export([decode/2]).

decode(Json, proplist) ->
    case decode_json(Json) of
        {ok, JsonObject} ->
            proplist_format(JsonObject);
        _ -> 
            error
    end;

decode(Json, map) ->
    case decode_json(Json) of
        {ok, JsonObject} ->
            map_format(JsonObject);
        _ -> 
            error
    end.

% Функція для декодування JSON
decode_json(Json) ->
    decode_json_recursive(Json, []).

% Рекурсивний парсер JSON
decode_json_recursive(<<>>, Acc) -> {ok, lists:reverse(Acc)};
decode_json_recursive(<<34, Rest/binary>>, Acc) -> decode_json_recursive(Rest, Acc);  % Пропускаємо "
decode_json_recursive(<<X, Rest/binary>>, Acc) when X == $} orelse X == $] orelse X == $: orelse X == $, orelse X == $\s orelse X == $\n orelse X == $\t ->
    decode_json_recursive(Rest, Acc);  % Пропускаємо інші роздільники
decode_json_recursive(<<X, Rest/binary>>, Acc) -> 
    decode_json_recursive(Rest, [{X} | Acc]).

% Форматування в proplist
proplist_format(JsonObject) ->
    JsonObject.

% Форматування в map
map_format(JsonObject) ->
    map_from_list(JsonObject).

% Перетворення у мапу
map_from_list([]) -> #{};
map_from_list([{Key, Value} | Tail]) -> 
    maps:put(Key, Value, map_from_list(Tail)).
