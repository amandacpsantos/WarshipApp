trigger WarshipResourceTrigger on WarshipResourceJunction__c (before insert, before update) {

    for(WarshipResourceJunction__c wrNew: Trigger.New){
        if(Trigger.isInsert || wrNew.Name != Trigger.oldMap.get(wrNew.Id).Name){
            
            for(WarshipResourceJunction__c wrExisting: [
                SELECT Id, Name, Resource__c
                FROM WarshipResourceJunction__c 
                WHERE Warship__c = :wrNew.Warship__c]
               ){
               
                // Check if exist another resource with same name
                if(wrExisting.Resource__c == wrNew.Resource__c){
                    
                    List<Resource__c> listResource = new List<Resource__c>();
                    listResource = [SELECT Name FROM Resource__c WHERE Id = :wrExisting.Resource__c];
                    
                    wrNew.addError('This warship already has a ' + listResource[0].Name);
                }
            }  
        }
    }
}