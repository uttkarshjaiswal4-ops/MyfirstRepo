public with sharing class AccountService {
    public static List<Account> getAccounts(Integer limitCount) {
        return [SELECT Id, Name, Industry FROM Account LIMIT :limitCount];
    }
    
    public static Account createAccount(String name, String industry) {
        Account acc = new Account(Name = name, Industry = industry);
        insert acc;
        return acc;
    }
}