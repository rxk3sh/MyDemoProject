public class AccoountTriggerHandler {
    public void CreateAccounts(list<account> acc){
        for(account a:acc)
            a.shippingstate=a.billingstate;
    }

}