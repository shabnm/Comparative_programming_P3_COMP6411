package final_project_java;
import java.util.Random;
import java.util.*;

class Multithreading extends Thread
{ 
	String b;
	int amount;
	String cust;
	Thread t;
	public Multithreading(String cust, int amount, String b) {
		this.amount = amount;this.cust = cust;this.b =b;}
	public void run() 
	{ 
		try{ 
			banks bnk = new banks();
			bnk.loanChecker(amount, b, cust);
		} 
		catch (Exception e) 
		{
			System.out.println ("Exception is caught"); 
		} 
	} 
} 

//Main Class 
public class money 
{ 
	public static void main(String[] args) 
	{ 
		System.out.println("Customet and bank details used : (\"bmo\", 7);" + 
				"	     (\"rbc\", 80);\r\n" + 
				"	     (\"ing\", 2);\r\n" + 
				"	     (\"Jill\",10);    \r\n" + 
				"		 (\"joe\",15);    \r\n" + 
				"		 (\"bob\",100);\r\n" + 
				"		 (\"sue\",12);");
		 HashMap<String,Integer> customer=new HashMap<String,Integer>();      
		 customer.put("Jill",10);    
		 customer.put("joe",15);    
		 customer.put("bob",100);
		 customer.put("sue",12);
		 Random rand = new Random();
		 String bank_list[] = {"rbc","bmo","ing"};
		 int val = rand.nextInt(3);
		 int amt = banks.bank.get(bank_list[val]);
		 while(amt > 0) {
			for ( String key : customer.keySet() ) {
				int value = rand.nextInt(50);
				if(value> 0) {
				System.out.println(key + " requests a loan of " + value +" from " + bank_list[val]);
				Multithreading object = new Multithreading(key, value, bank_list[val]); 
	            object.start();
	            amt = banks.bank.get(bank_list[val]);}
			}
		 }
	}
}


