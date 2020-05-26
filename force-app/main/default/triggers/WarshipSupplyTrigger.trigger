trigger WarshipSupplyTrigger on WarshipSupplyJunction__c (before insert, before update) {

    for(WarshipSupplyJunction__c wsNew: Trigger.New){
        if(Trigger.isInsert || wsNew.Name != Trigger.oldMap.get(wsNew.Id).Name){
            
            for(WarshipSupplyJunction__c wsExisting: [
                SELECT Id, Name, Supply__c
                FROM WarshipSupplyJunction__c 
                WHERE Warship__c = :wsNew.Warship__c]
               ){
               
                // Check if exist another resource with same name
                if(wsExisting.Supply__c == wsNew.Supply__c){
                    
                    List<Supply__c> listSupply = new List<Supply__c>();
                    listSupply = [SELECT Name FROM Supply__c WHERE Id = :wsExisting.Supply__c];
                    
                    wsNew.addError('This warship already has a ' + listSupply[0].Name);
                }

            }  
        }
    }
}