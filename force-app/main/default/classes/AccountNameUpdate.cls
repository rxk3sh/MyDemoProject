global class AccountNameUpdate implements Database.batchable<sobject> {
    global database.querylocator start(Database.batchablecontext bc){
        return database.getquerylocator('SELECT name from Account');
    }
    global void execute(database.batchablecontext bc,list<account> acclist){
        for(Account ac : acclist){
            ac.name=ac.name+' ABSYZ';
        }
        update acclist;
    }
    global void finish(database.batchablecontext bc){
        system.debug('FINISH');
    	}

}