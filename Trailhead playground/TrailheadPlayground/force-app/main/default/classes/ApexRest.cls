@RestResource(urlMapping='/a/*')
global with sharing class ApexRest {
	@HttpGet 
	global static String doGet() {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		String RestResponse = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		return 'result';
	}

	@HttpPost 
	global static String doPost(String name) {
		return 'result';
	}

	@HttpDelete 
	global static void doDelete() {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		String urlId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
	}


}