public with sharing class AccountTriggerHandler {

    /**
     * Method responsible to determine if one account is 'Hot'
     * @param: accounts -> list with the new accounts
     */
    public static void verifyHotAccounts( List< Account > accounts ){
        for(Account acc : accounts ){
            if (acc.AnnualRevenue > 1000){
                acc.Rating = 'Hot';
            }
        }
    }

    /**
     * Method responsible to verify if the account's name change.
     * @param: accounts-> list with the changed accounts.
     * @param: oldAccounts-> Map with the old account values.
     */
    public static void verifyAccountNameChanged(
            List< Account > accounts, Map< Id, Account > oldAccounts ){

        for( Account acc : accounts ){
            if( oldAccounts.containsKey(acc.Id ) 
                    && oldAccounts.get(acc.Id).Name != acc.Name ){
                
                acc.Name += ' - Updated';
            }
        }
    }
}
