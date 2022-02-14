public class ContactController {
    public Integer numb;
    public String str;

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