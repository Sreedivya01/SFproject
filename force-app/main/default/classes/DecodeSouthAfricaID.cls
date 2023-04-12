public class DecodeSouthAfricaID {
    Public static DateTime DateOfBirth{get; set;}
    Public static String DateOfBirths{get; set;}
    Public static string Gender{get;set;}
    Public static string SAcitizen{get;set;}
    Public static string ValidId{get;set;}
    
    Public static List<String> DecodeSAId(String SouthAfricaID ){
         List<String> mydataList= new  List<String> ();
        if(SouthAfricaID.length()>=13){
            integer length = SouthAfricaID.length();
            String DOB= SouthAfricaID.substring(0, 5);
            String Gen= SouthAfricaID.substring(6, 10);
            String SACity= SouthAfricaID.substring(10, length - 2);
            String SAvalids= SouthAfricaID.substring(12, length - 0);
            
            if(DOB.length()>0){
                String year= SouthAfricaID.substring(0, 2);
                String month= SouthAfricaID.substring(2, 4);
                String day= SouthAfricaID.substring(4, 6);
                String myyear;
                if (year.startsWith('9')||year.startsWith('8')||year.startsWith('7')||year.startsWith('6') ){
                    myyear='19'+year;
                }else{
                    myyear='20'+year;
                }
                DateOfBirth = Date.newInstance(integer.valueOf(myyear),integer.valueOf(month),integer.valueOf(day));
                String newFormat = DateOfBirth.day() + '-' + DateOfBirth.month()+ '-' + DateOfBirth.year() ;
                DateOfBirths= day+ '-' + month+ '-' + myyear; //DateOfBirth.format('dd-MM-yyyy');
                mydataList.add(DateOfBirths);
            }
            
            if(Gen.length()>0){
                Integer Genderfind =integer.valueOf(Gen);
                if(Genderfind>= 00000 && Genderfind <= 4999){
                    Gender = 'Female';
                }
                else if(Genderfind>= 5000 && Genderfind <= 9999){
                    Gender = 'Male';
                }
                mydataList.add(Gender);
            }
            if(SACity.length()>0){
                Integer FindCitizen =integer.valueOf(SACity);
                if(FindCitizen== 0){
                    SAcitizen='SA citizen';
                }
                else if(FindCitizen== 1){
                    SAcitizen='Permanent Resident.';
                }
                mydataList.add(SAcitizen);
            }
            if(SAvalids.length()>0){
                integer i= integer.valueOf(SAvalids);
                
                if(math.mod(i, 2) == 0){
                    ValidId ='Valid';
                }else{
                    ValidId ='Not Valid';
                }
                mydataList.add(ValidId);
                // boolean SATrue=  CCValidation(SouthAfricaID);
                // system.debug('SATrue ' +SATrue);
            }
        }
        system.debug('DateOfBirth ' +DateOfBirth);
        system.debug('Gender ' +Gender);
        system.debug('SAcitizen ' +SAcitizen);
        system.debug('ValidId ' +ValidId);
        system.debug('DateOfBirths ' +DateOfBirths);
        return mydataList;
    }
    public static boolean CCValidation(String CCNumber){
        Integer sum = 0;
        Integer len = CCNumber.length();
        for(Integer i=len-1;i>=0;i--){
            Integer num = Integer.ValueOf(CCNumber.substring(i,i+1));
            if ( math.mod(i , 2) == math.mod(len, 2) )
            {
                Integer n = num * 2;
                sum += (n / 10) + ( math.mod(n, 10));
            }
            else{
                sum += num;
            }
        }
        return ( math.mod( sum, 10) == 0 );
    }
}