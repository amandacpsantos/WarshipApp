public with sharing class ManagingWarshipController {
    
    private id wId;
    public Warship__c warship {get; set;}
    public List<Resource__c> newResources {get; set;}
    public List<Supply__c> newSupplies {get; set;}
   
    public ManagingWarshipController(Apexpages.StandardController controller) {
        wId = controller.getId();
        getResourceSupply();
    }

    private void getResourceSupply(){
        warship = [SELECT 
                    Id, Name, 
                    (SELECT Id, Name, Quantity__c, Utilization__c FROM Resources__r),
                    (SELECT Id, Name, Quantity__c, Unit_Cost__c, Total_Cost__c FROM Supplies__r)
                  FROM Warship__c WHERE Id = :wId];
        
        newResources = new List<Resource__c>();
        newSupplies = new List<Supply__c>();
    }

    public void addResource(){
        //Add line to create resource
        newResources.add(new Resource__c(Warship__c = warship.Id));
    }

    public void addSupply(){
        //Add line to create supply
        newSupplies.add(new Supply__c(Warship__c = warship.Id));
    }

    public void saveResources(){
        //Add and update list
        insert newResources;
        getResourceSupply();
    }

    public void saveSupplies(){
        //Add and update list
        insert newSupplies;
        getResourceSupply();
    }

}
