@IsTest
public class AnimalJSONtoAPEXTest {
	static testMethod void testParse() {
		String json = '{\"animal\":{\"id\":1,\"name\":\"chicken\",\"eats\":\"chicken food\",\"says\":\"cluck cluck\"}}';
		AnimalJSONtoAPEX obj = AnimalJSONtoAPEX.parse(json);
		System.assert(obj != null);
        System.assertEquals(1, obj.animal.id);
        System.assertEquals('chiken', obj.animal.name);
        System.assertEquals('chicken food', obj.animal.eats);
        System.assertEquals('cluck cluck', obj.animal.says);
	}
}