package final_project_java;

import java.util.HashMap;

public class banks {
	static HashMap<String, Integer> bank = new HashMap<String, Integer>()
	{{
	     put("bmo", 7);
	     put("rbc", 80);
	     put("ing", 2);
	     put("Jill",10);    
		 put("joe",15);    
		 put("bob",100);
		 put("sue",12);
	}};
	
	synchronized boolean loanChecker(int amount, String bank_name, String cust) {
		int total_amt = banks.bank.get(bank_name);
		int cust_amount = banks.bank.get(cust);
		if(cust_amount <= 0) {
			System.out.println(cust +" has reached the objective. Woo Hoo");
			return true;
		}
		if(total_amt <= 0) {
			System.out.println(bank_name +" has "+ total_amt+ " dollars remaining.");
			return true;
		}
		if (total_amt >= amount & amount <= cust_amount) {
			int avail_amt = total_amt-amount;
			int cust_avail = cust_amount-amount;
			System.out.println(bank_name +" approves a loan of "+ amount + " for " +cust);
			banks.bank.put(bank_name, avail_amt);
			banks.bank.put(cust, cust_avail);
			return true;
		}
		System.out.println(bank_name +" does not approves a loan of "+ amount + " for " +cust);
		return false;
		
	}
	
}
