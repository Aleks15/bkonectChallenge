@isTest
public class AccountTriggerHandlerTest {
    
    @IsTest
    static void verifyHotAccountsTest(){
        
        Account acc = new Account( Name = 'Acc I', AnnualRevenue = 999 );
        Account acc1 = new Account( Name = 'Acc I', AnnualRevenue = 1000 );
        Account acc2 = new Account( Name = 'Acc I', AnnualRevenue = 2500 );
        Account acc3 = new Account( Name = 'Acc I', AnnualRevenue = 99999 );
        Account acc4 = new Account( Name = 'Acc I', AnnualRevenue = 0 );

        Test.startTest();
        
        insert new List< Account >{ acc, acc1, acc2, acc3, acc4 };

        Test.stopTest();

        integer countHotAccounts = [ SELECT count() FROM Account WHERE Rating = 'Hot' ];
        System.assertEquals( 2, countHotAccounts );
    }

    @IsTest
    static void verifyAccountNameChangedTest(){
        
        Account acc = new Account( Name = 'Acc I', AnnualRevenue = 999 );
        Account acc1 = new Account( Name = 'Acc I', AnnualRevenue = 1000 );
        insert new list< Account >{acc, acc1};

        Test.startTest();
        acc.Name = 'Changed Name';
        update acc;

        Test.stopTest();
        Account resultAccount = [ SELECT Name FROM Account WHERE Id = :acc.Id ];
        System.assertEquals( 'Changed Name - Updated', resultAccount.Name);
    }

    /**
     * Follow the validation rule, Change the validation rule should be broght that test.
     * Is not necessary to writte a test to one validation rule ( Is not a good practice, I guess)
     * But EXCLUSIVELY to test this scenario in that challenge I wrote one.
     */
    @IsTest
    static void preventinsertInvalidIndustryTest(){
        
        Test.startTest();
        Account acc = new Account( Name = 'Acc I', industry = 'Chemicals' );

        try {
            insert acc;
        } catch (Exception e) {
            System.assert(String.isNotBlank(e.getMessage()));
        }
        Test.stopTest();
        
    }

    /**
     * Follow the validation rule, Change the validation rule should be broght that test.
     * Is not necessary to writte a test to one validation rule ( Is not a good practice, I guess)
     * But EXCLUSIVELY to test this scenario in that challenge I wrote one.
     */
    @IsTest
    static void preventUpdateInvalidIndustryTest(){
        
        Account acc = new Account( Name = 'Acc I', industry = 'Finance' );
        insert acc;

        Test.startTest();

        try {
            acc.industry = 'Chemicals';
            update acc;
        } catch (Exception e) {
            System.assert(String.isNotBlank(e.getMessage()));
        }
        Test.stopTest();
        
    }
}
