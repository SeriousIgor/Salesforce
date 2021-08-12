@isTest
public class TestDataFactory {
    public static List<Employee__c> createEmployeeWithOrders(Integer numEmpl, Integer numOrd){
        Datetime minDate = Datetime.newInstance(2020,1,1,12,0,0);
        List<Employee__C> employeeList = new List<Employee__c>();
        for(Integer i = 0; i < numEmpl; i++){
            Employee__c e = new Employee__c(
                Full_name__c = 'Test name ' + String.valueOf(i),
                Last_Order__c = minDate.addDays(Integer.valueOf(Math.random()*350))
            );
            employeeList.add(e);
        }
        insert employeeList;
        
        List<Order__c> orderList = new List<Order__c>();
        for(Integer i = 0; i < numEmpl; i++){
            Employee__C empl = employeeList[i];
            for(Integer j = 0; j < numOrd; j++){
                Order__c o = new Order__c(
                    Price__c = Integer.valueOf(Math.random()*10),
                    Order_date__c = minDate.addDays(Integer.valueOf(Math.random()*350)),
                    Employee__C = empl.Id
                );
                orderList.add(o);
            }
        }
        insert orderList;

        return employeeList;
    }

    public static List<Employee__c> getEmployee(Integer numEmpl){
        List<Employee__C> employeeList = new List<Employee__c>();
        for(Integer i = 0; i < numEmpl; i++){
            Employee__c e = new Employee__c(
                Full_name__c = 'Test name ' + String.valueOf(i),
                Salary__c = Integer.valueOf(Math.random()*500)
            );
            employeeList.add(e);
        }
        return employeeList;
    }

    public static List<Order__c> getOrder(Integer numOrd){
        Datetime minDate = Datetime.newInstance(2020,1,1,12,0,0);
        List<Order__c> orderList = new List<Order__c>();
        for(Integer j = 0; j < numOrd; j++){
            Order__c o = new Order__c(
                Price__c = Integer.valueOf(Math.random()*10),
                Order_date__c = minDate.addDays(Integer.valueOf(Math.random()*350))
            );
            orderList.add(o);
        }
        return orderList;
    }

    public static List<Animal__c> getAnimal(Integer numAnim){
        List<Animal__c> animalList = new List<Animal__c>();
        for(integer i = 0; i < numAnim; i++){
            Animal__c animal = new Animal__c(
                Name = 'Test name',
                Eats__c = 'Test food',
                Says__c = 'Test word',
                ExternalId__c = '9',
                Flag__c = true
            );
            animalList.add(animal);
        }
        return animalList;
    }
}