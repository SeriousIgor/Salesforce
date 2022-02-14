public class ContactControllerTest {
    public Integer numbr;
    public String str;
    public Integer numbr2;
    public String str2;
    public Integer numbr3;
    public String str3;

	public ContactControllerTest(Integer numbr, String str){
        this.numbr = numbr;
        this.str = str;
	}


    @AuraEnabled(cacheable = true)
    public static List<Contact> getContacts(){
        List<Contact> contactList = [
            SELECT
                FirstName,
                LastName,
                Email
            FROM
                Contact
            WITH
                SECURITY_ENFORCED
            ORDER BY
                LastName
        ];
        if(true){
            throw new AuraHandledException('Exception throwed');
        }
        return contactList;
    }
}