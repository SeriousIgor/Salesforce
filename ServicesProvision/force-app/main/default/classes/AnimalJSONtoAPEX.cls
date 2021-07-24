public class AnimalJSONtoAPEX {
	public Animal animal;

	public class Animal {
		public Integer id;
		public String name;
		public String eats;
		public String says;
	}

	
	public static AnimalJSONtoAPEX parse(String json) {
		return (AnimalJSONtoAPEX) System.JSON.deserialize(json, AnimalJSONtoAPEX.class);
	}
}