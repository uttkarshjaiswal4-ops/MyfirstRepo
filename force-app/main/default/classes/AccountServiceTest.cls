@isTest
public class AccountServiceTest {
    @isTest
    static void testGetAccounts() {
        List<Account> testAccounts = new List<Account>();
        for(Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;
        
        Test.startTest();
        List<Account> result = AccountService.getAccounts(3);
        Test.stopTest();
        
        System.assertEquals(3, result.size(), 'Should return 3 accounts');
    }
    
    @isTest
    static void testCreateAccount() {
        Test.startTest();
        Account acc = AccountService.createAccount('Test Corp', 'Technology');
        Test.stopTest();
        
        Account inserted = [SELECT Id, Name, Industry FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Test Corp', inserted.Name);
        System.assertEquals('Technology', inserted.Industry);
    }
}