@RestResource(urlMapping='/CalendarificAPI/*')
global with sharing class CalendarificRestAPI {
    @HttpGet
    global static List<String >  doGet() {
        //24c5e86734eb44dc4a962826324a5546e74dc42f  when i'm using this the show me 
        /*"meta": {
        "code": 426,
        "error_type": "too many requests",
        "error_detail": "API Limit Exceeded. Please upgrade your account. See https://calendarific.com/ for details."
    },
    "response": []
}*/
        String Endpointurl='https://calendarific.com/api/v2/holidays?&api_key=544f56b5b4945e44b6f334efebd6958eb4e50dab&country=ZA&year=2023';
        http p = new http();
        httprequest req = new httprequest();
        req.getBody();
        req.setEndpoint(Endpointurl);
        req.setmethod('GET');
        
        httpresponse res = p.send(req);
        string jsonparsing = res.getbody();
        Map<String, Object> dataMap = (Map<String, Object>) JSON.deserializeUntyped(jsonparsing);
        List<String> dateLstToholiday = new List<String>();
        Map<String, Object> responsemap = (Map<String, Object>) dataMap.get('response');
        List<Object> holidaysLst= (List<Object>)responsemap.get('holidays');
        List<String > NameOFHoliday = new List<String >();
        if(holidaysLst.size() > 0){
            for(Object obj :holidaysLst){
                Map<String, Object> innerdataMap = (Map<String, Object>)obj;
                string datevalue =String.valueof(innerdataMap.get('date'));
                string namevalue='';
                  namevalue=String.valueof(innerdataMap.get('name'));
                    system.debug('namevalue  '+namevalue);
                    NameOFHoliday.add(namevalue);
                    system.debug('NameOFHoliday  size' +NameOFHoliday.size());
                //List<Object> AccountLst= (List<Object>)innerdataMap.get('date');
                //system.debug('AccountLst  ' +AccountLst);
                /*for(Object myobj :innerdataMap.values()){
                    Map<String, Object> datedataMap = (Map<String, Object>)myobj;
                    system.debug('obj innerdataMap ' +innerdataMap);
                    
                   
                    
                }*/
            }
        }
        
        return NameOFHoliday;
    }
}