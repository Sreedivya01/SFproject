public class calculateWorkingDaysBetweenTwoDates {
    Public string southafricaId{get;set;}
    Public STATIC string myoutputString{get;set;}
    Public STATIC string myoutputBirthdayString{get;set;}
    public Boolean hidebutton{get;set;}
    public Boolean right{get;set;}
    public Boolean wrong{get;set;}
    public List<String> DataString{get;set;}
     Public String DateOfBirths{get; set;}
    Public string Gender{get;set;}
    Public string SAcitizen{get;set;}
    Public string ValidId{get;set;}
    Public Integer Count{get;set;}
    Public Integer CountSearch{get;set;}
    Public List<String> HolidayList{get;set;}
    
    public calculateWorkingDaysBetweenTwoDates(){
        hidebutton = false;
        
    }
    
    public Boolean enableButton(){
        system.debug('hidebutton  hidebutton  '+hidebutton);
        hidebutton = true;
        return hidebutton;
    }
    public void SouthAfricaId(){
        right= false;
        //wrong= false;
        Count = 0;
        if(southafricaId.length()>=13){
            HolidayList=CalendarificRestAPI.doGet();
        }
        List<Holiday> holidays=[Select h.StartTimeInMinutes, h.Name, h.ActivityDate 
                                From Holiday h];
        Map<Date, String> MapOfHoliday = new Map<Date, String>();
        List<Account> Acc = [Select id ,Count_Search__c, South_Africa_Id__c 
                       from account where South_Africa_Id__c =: southafricaId Limit 1]; 
        system.debug('Acc.sizE()  ===   '+Acc.sizE());
        for(Holiday Hl :holidays ){
            MapOfHoliday.put(Hl.ActivityDate,Hl.name);
        }
        if(Acc.sizE()>0 && southafricaId.length()>=13){
            Count++;
            List<Contact> conlist= new List<Contact>([Select id , Birthdate,name 
                                                      from contact  where accountid =: Acc[0].id 
                                                      and Birthdate!= null]);
            system.debug('conlist.sizE()  ===   '+conlist.sizE());
            for(Contact con : conlist){
                if(con.Birthdate!= null){
                    if(MapOfHoliday.containskey(con.Birthdate)){
                        myoutputString= 'You Birthday is South Africa at Public holiday ';
                        right=  false;
                        wrong= true;
                    }
                    else{
                        myoutputString= 'You Birthday is South Africa not public holiday ';
                        
                        right= true;
                        wrong= false;
                    }
                }
            } 
            Acc[0].Count_Search__c +=Count;
            CountSearch = integer.valueOf(Acc[0].Count_Search__c);
            update acc;
        }
        else{
            myoutputString = 'No South Africe Id is exit with any Account';
            DateOfBirths ='';
            Gender ='';
            SAcitizen ='';
            ValidId ='';    
            CountSearch =0;
            HolidayList = new List<String>();
            right=  false;
            wrong= true;
        }
        system.debug('myoutputString ===   '+myoutputString);
        if(southafricaId.length()>=13){
            DataString= DecodeSouthAfricaID.DecodeSAId(southafricaId);
            DateOfBirths=DecodeSouthAfricaID.DateOfBirths;
            Gender=DecodeSouthAfricaID.Gender;
            SAcitizen=DecodeSouthAfricaID.SAcitizen; 
            ValidId=DecodeSouthAfricaID.ValidId;
        }
        
    }
    

}