trigger SupplyTrigger on Supply__c (before insert, before update) {
    
    for(Supply__c sNew: Trigger.New){
        if(Trigger.isInsert || sNew.Name != Trigger.oldMap.get(sNew.Id).Name){

            
            for(Supply__c sExisting: [SELECT Id, Name FROM Supply__c WHERE Warship__c = :sNew.Warship__c]){
                
                // Check if exist another supply with same name
                if(sExisting.Name == sNew.Name){
                    sNew.addError('This warship already has a ' + sNew.Name);
                }

            }
            
        }
    }

}