({
    getListHelper : function(component, event) {
        var action = component.get("c.getListValue");
        action.setCallback(this, function(a){
            var rtnValue = a.getReturnValue();
            component.set("v.values",rtnValue);
    
            var options = [];
            if(rtnValue.length>0){
                    for(var i=0;i< rtnValue.length;i++){
                        options.push({ label: rtnValue[i].Name,value: rtnValue[i].Name});
                    }

                    console.log('options'+options.length);
                    component.set("v.options",options);
            }           

        })
    }
})

        