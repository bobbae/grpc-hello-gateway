const {GreeterClient} = require('../helloworld/helloworld_grpc_web_pb');
const {HelloRequest, HelloReply} = require('../helloworld/helloworld_pb');

var greeterService = new GreeterClient('http://localhost:8880')

function sayHello() {
	let name = document.getElementById("name").value;
	request = new HelloRequest();
	request.setName(name);

	greeterService.sayHello(request, {}, function(err, response) {
		if (err) {
			console.log('error:', err);
			return;
		} 
		var reply = document.getElementById("reply");
		reply.textContent = response.getMessage();
	
		console.log("response:", response);
	});
}

const btn = document.getElementById('sendBtn');

btn.addEventListener('click', function() {
	sayHello();
});
