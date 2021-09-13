@isTest
public class TestEmployeeTrigger {
    public static List<Employee__c> createEmployeeData(Integer numEmp) {
        List<Employee__c> emp = new List<Employee__c>();
        for(Integer i = 1; i <= numEmp; i++) {
            Employee__c e = new Employee__c(Name = 'Employee'+i, Employee_Title__c = 'kajxbfc');
            e.Email__c = '';
            emp.add(e);
        }
        
        insert emp;
        
        return emp;
    }
    
    @isTest static void SingleEmployeeEmailUpdate() {
        Employee__c[] employee = createEmployeeData(1);
        
        Test.startTest();
        	Database.SaveResult result = Database.update(employee[0], false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        
    }
    
    @isTest static void bulkEmployeeEmailUpdate() {
        Employee__c[] employee = createEmployeeData(200);
        
        Test.startTest();
        	Database.SaveResult[] results = Database.update(employee, false);
        Test.stopTest();
        
        for(Database.SaveResult sr : results) {
        	System.assert(!sr.isSuccess());
        	System.assert(sr.getErrors().size() > 0);
        }
    }
}