public with sharing class AccountTriggerHandler {
    public static void avoidDuplicate() {
        List<Account> accList = new List<Account>([SELECT Name, (SELECT Name, Email FROM Contacts) FROM Account]);
    	map<String,Account> accMap = new map<String,Account>();
    	for(Account acc : accList){
            for(Contact con : acc.Contacts)
        		accMap.put(con.Email, acc);
    	}
        
    	//For Insert Operation
    	if(Trigger.isInsert){
        	for(Account acc : (List<Account>) Trigger.new){
                for(Contact con : acc.Contacts){
                    if(accMap.get(con.Email) != null){
                        acc.adderror('This email already exists, choose another one!');
                    }
                }
        	}
    	}
        
    	//For Update Operation
    	if(Trigger.isUpdate){
        	for(Account acc : (List<Account>) Trigger.new){
                for(Contact con : acc.Contacts){
                    if((accMap.get(con.Email) != null)&&(accMap.get(con.Email) != acc)){
                        acc.adderror('Email already exists');
                    }
                }
        	}
    	}
    }
}