%% @author Shabnam

-module(money).
-import(customer, [request_customer/4]).
-import(bank, [request_bank/2]).
-import(lists,[nth/2]).
-export([start/0, thread/3]).
-import(string,[concat/2]).
-export([print/2]).

start() ->
	{ok, B} = file:consult("banks.txt"),
	B_map = maps:from_list(B),
	B_name = maps:keys(B_map),
	B_size = map_size(B_map),
	io:fwrite("** Banks and financial resources **~n"),
	print(map_size(B_map),B),
	
	{ok, C} = file:consult("consumer.txt"),
	C_map = maps:from_list(C),
	C_name = maps:keys(C_map),
	io:fwrite("** Customer and loan objectives **~n"),
	print(map_size(C_map),C),
	thread(C, B_name, B_size),
	thread(B, [], B_size).
%% 	lists:foreach(fun({Holder,Total_amt}) ->
%% 		register(Holder, spawn(customer, request_customer, [Holder, Total_amt, B_name]))
%% 		end, C),
%% 	
%% 	lists:foreach(fun({Bank,BTotal_amt}) ->
%% 		register(Bank, spawn(customer, request_customer, [Bank, BTotal_amt]))
%% 		end, B).
	

thread([],_,_)->
	true;
thread([First|Rest],Flag, B_size) ->
	{Holder, Total_amt} = First,
	if
		Flag == [] ->
			register(Holder, spawn(bank, request_bank, [Holder, Total_amt]));
		true ->
			register(Holder, spawn(customer, request_customer, [Holder, Total_amt,Flag,B_size]))
	end,
	thread(Rest, Flag, B_size).

print(0,_) ->
	ok;
print(Size, Map) ->
	io:fwrite("~w~n", [nth(Size, Map)]),
	print(Size-1, Map).