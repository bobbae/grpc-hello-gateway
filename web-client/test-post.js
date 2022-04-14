
function sayHello  ()  {
	let data = { 'name': document.getElementById("name").value};
	let xhr = new XMLHttpRequest();
	xhr.open("POST","http://localhost:8090/v1/example/echo");
	xhr.setRequestHeader("Accept","application/json");
	xhr.setRequestHeader("Content-Type", "application/json");
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			console.log(xhr.status);
			console.log(xhr.responseText);
			document.getElementById("reply").innerHTML = "<div>Response: "+xhr.responseText +"</>";
		}
	}
	xhr.send(JSON.stringify(data));
};

const btn = document.getElementById('sendBtn');

btn.addEventListener('click', function() {
	sayHello();
});
