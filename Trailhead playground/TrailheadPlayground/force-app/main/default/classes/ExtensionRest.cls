@RestResource(urlMapping='/Account/*')
global with sharing class ExtensionRest {
	@HttpGet 
	global static Account doGet() {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		String RestResponse = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		return null;
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