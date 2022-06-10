/**
 * Please refactor this!!!!!!!!!!!!
 * =================== TIP - START ====================
 * open the terminal and run this to install a prettier plugin in your VSCode:
  npm install --save-dev --save-exact prettier prettier-plugin-apex
  the .prettierrc file must have:
    "tabWidth": 4
    "printWidth": 160
* ==================== TIP - END ========================
 * keep in mind that it doesn't exists a perfect code and we can always improve it
 * so, free your mind and feel free to use Salesforce resources as custom metadatas, custom settings, etc
 * you can create other triggers/classes/etc as well
 * if, at some point, you have that feeling of "WHAT THE FUCK?" .. no worries, you probably is right...
 * just trust in yourself... I wrote a TERRIBLE code :)
 * 
 * if you have any questions , send me a message
 */

trigger AccountTrigger on Account (before insert,before update) {
    /**
     * For this scenario the trigger is necessary to run only in before statements
     * do not have reason to run after, delete or undelte. 
     * 
     * The check for prevent some industries was changed for one validation rule.
     * Have some inconsistencies into that check. That rule prevents only the first
     * account on the trigger.new. How the list of blocked industries is short,
     *  I think is a better ideia to tranpose it in one validation rule ( easy to modify,
     *  easy to disable, easy to delegate to admin, do not needs create Apex code to count
     *  against org limits )
     */

    if(Trigger.isInsert){
        AccountTriggerHandler.verifyHotAccounts((List< Account >) Trigger.new);
    }

    if(Trigger.isUpdate){
        AccountTriggerHandler.verifyHotAccounts((List< Account >) Trigger.new);

        AccountTriggerHandler.verifyAccountNameChanged(
            (List< Account >) Trigger.new,
            (Map< Id, Account >) Trigger.oldMap
        );
    }
}