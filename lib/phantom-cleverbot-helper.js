var system = require('system');
var chatInput = "";
system.args.forEach(function (arg, i) {
	if(i > 0) chatInput += arg + " ";
});

var page = require('webpage').create();

page.onError = function(msg, trace) {
    var msgStack = ['ERROR: ' + msg];
    if (trace && trace.length) {
        msgStack.push('TRACE:');
        trace.forEach(function(t) {
            msgStack.push(' -> ' + t.file + ': ' + t.line + (t.function ? ' (in function "' + t.function + '")' : ''));
        });
    }
    // uncomment to log into the console 
    // console.error(msgStack.join('\n'));
};

page.open('http://www.cleverbot.com', function(status) {
	if (status !== 'success') {
		console.log('No response');
	} else {
		page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
			page.evaluate(function(chatInput) {
				$(".stimulus").val(chatInput);
			}, chatInput);
			page.evaluate(function(){
				$("[name=thinkaboutitbutton]").trigger("click");
			});
			
			var lengths = [-1, -1, -1, -1];
			var li = 0;
			
			var interval = setInterval(function(){
				var d = page.evaluate(function(){
					return $("#line1 .bot").text();
				});
				
				var cont = false;
				
				if(d != null && d.hasOwnProperty("length") && d.length > 0){
					if(li == 4 && d.length == lengths[3]){
						cont = true;
					} else if (d.length < 2){
						li = 0;
					} else if (li == 0){
						lengths[0] = d.length;
						li++;
					} else if(d.length == lengths[li - 1]){
						lengths[li] = d.length;
						li++;
					} else {
						li = 0;
						lengths = [-1, -1, -1, -1];
					}
				}
				
				if(cont){
					clearInterval(interval);
					setTimeout(function(){
						var resp = page.evaluate(function(){
							return $("#line1 .bot").text();
						});
						console.log(resp);
						phantom.exit();
					}, 2000);
				}
			}, 500);
		});
	}
});
