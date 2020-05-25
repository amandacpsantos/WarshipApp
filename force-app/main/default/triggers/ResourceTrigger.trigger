trigger ResourceTrigger on Resource__c (before insert, before update) {

    for(Resource__c rNew: Trigger.New){
        if(Trigger.isInsert || rNew.Name != Trigger.oldMap.get(rNew.Id).Name){

            
            for(Resource__c rExisting: [SELECT Id, Name FROM Resource__c WHERE Warship__c = :rNew.Warship__c]){
                
                // Check if exist another resource with same name
                if(rExisting.Name == rNew.Name){
                    rNew.addError('This warship already has a ' + rNew.Name);
                }

            }
            
        }
    }

}