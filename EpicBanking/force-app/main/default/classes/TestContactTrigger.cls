@isTest
public class TestContactTrigger {
    public static List<Contact> createContactData(Integer numCons, Boolean isNull) {
        List<Contact> cons = new List<Contact>();
        
        for(Integer i = 1; i <= numCons; i++) {
            Contact c = new Contact(lastName = 'Contact' + i);
            if(isNull)
            	c.accountId = null;
            cons.add(c);
        }
        insert cons;
        
        return cons;
    }
    
    @isTest static void singleContactDeletionPrevention() {
        Contact[] contact = createContactData(1, true);
        
        Test.startTest();
        	Database.DeleteResult result = Database.delete(contact[0], false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('You cannot delete this contact. It is not associated with an existing account!',
                             result.getErrors()[0].getMessage());
    }
    
    @isTest static void singleNoContactDeletionPrevention() {
        Contact[] contact = createContactData(1, false);
        
        Test.startTest();
        	Database.DeleteResult result = Database.delete(contact[0], false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('You cannot delete this contact. It is not associated with an existing account!',
                             result.getErrors()[0].getMessage());
    }
    
    @isTest static void bulkContactDeletionPrevention() {
        Contact[] contact = createContactData(200, true);
        
        Test.startTest();
        	Database.DeleteResult[] results = Database.delete(contact, false);
        Test.stopTest();
        
        for(Database.DeleteResult dr : results) {
            System.assert(!dr.isSuccess());
            System.assert(dr.getErrors().size() > 0);
            System.assertEquals('You cannot delete this contact. It is not associated with an existing account!',
                                 dr.getErrors()[0].getMessage());
        }
    }
    
    @isTest static void BulkNoContactDeletionPrevention() {
        Contact[] contact = createContactData(200, false);
        
        Test.startTest();
        	Database.DeleteResult[] results = Database.delete(contact, false);
        Test.stopTest();
        
        for(Database.DeleteResult dr : results) {
        	System.assert(!dr.isSuccess());
        }
    }
}