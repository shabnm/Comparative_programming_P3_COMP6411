%% @author shabnam


-module(bank).
-export([request_bank/2]).


request_bank(Bank_name, Total_amount) ->
	receive
		{Cust_name, B_name, Requested_amount, CID} ->
			if
				Total_amount >= Requested_amount ->
					CID ! success,
					io:fwrite("~w has approved ~p dollar for ~w~n", [B_name, Requested_amount, Cust_name]),
					New_amt = Total_amount - Requested_amount,
					request_bank(B_name, New_amt);
			true ->
				CID ! failure,
				io:fwrite("~w has not approved ~p dollar for ~w~n", [B_name, Requested_amount, Cust_name]),
				request_bank(B_name, Total_amount)
			end
		end.