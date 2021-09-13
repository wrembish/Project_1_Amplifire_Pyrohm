@isTest
public class TestAccountTrigger {
    public static Map<String,Contact> createAccountData(Integer numAcct) {
        Map<String, Contact> account_contact = new Map<String,Contact>();
        for(Integer i = 1; i <= numAcct; i++) {
            Contact c = new Contact(Email='Employee'+i+'@banking.org');
            Account a = new Account(Name='Employee'+i);
            account_contact.put(a.Name, c);
        }
        
        insert account_contact.values();
        
        return account_contact;
    }
}