%% @author Shabnam


-module(customer).
-import(bank, [request_bank/2]).
-import(lists,[nth/2]).
-import(lists,[last/1]).
-import(lists,[delete/2]).
-export([request_customer/4]).


request_customer(Cust_name, 0, B_Map, B_size) ->
	io:fwrite("~w has reached the objective!!!WOOHOOO ~n", [Cust_name]);

request_customer(Cust_name, Total_amount, [], 0) ->
	io:fwrite("~w need ~w more !!!BOOHOO~n", [Cust_name, Total_amount]);

request_customer(Cust_name, Total_amount, B_Map, B_size) ->
	Rand_amt = rand:uniform(5),
 	Rand_b = rand:uniform(B_size),
	Rand_Bank = nth(Rand_b , B_Map),
	timer:sleep(100),
   	Rand_Bank ! {Cust_name, Rand_Bank , Rand_amt, self()},
	io:fwrite("~w requests a loan of ~p dollars from ~w~n",[Cust_name, Rand_amt, Rand_Bank]),
	receive 
		success ->
%% 			io:fwrite("~w has approved ~p for ~w~n",[rbc, [Rand], Cust_name]),
			request_customer(Cust_name,amount_checker(Total_amount,Rand_amt), B_Map, B_size);
		failure ->
%% 			io:fwrite("~w has not approved ~p for ~w~n",[rbc, [Rand], Cust_name]),
			request_customer(Cust_name, Total_amount, delete(Rand_Bank,B_Map), B_size-1)
	end.

amount_checker(Total_amount, Rand_amt) ->
	New_Camt = Total_amount-Rand_amt,
			if 
				New_Camt =< 0 ->
					0;
			true ->
				New_Camt
			end.