var exId = "gginmgpcjenjhlcmcfngifklahepmfbk"; // 上传
var port = chrome.runtime.connect(exId,{name: "knockknock"});
var devices = [];
var sIndex = 0;
//port.postMessage({query:"hasExtension"});  //插件是否存在



port.onMessage.addListener(function(msg) {
    console.log("监听执行！");
    console.log(msg);
    console.log(typeof msg.device);

    if (msg.device instanceof Array && msg.device.length > 0) {
        var devices = msg.device;
        var len = devices.length;
        console.log( msg.device );
        console.log(len);
        var equimpment = document.getElementById("equipment"); // select
        equimpment.innerHTML = " ";
        for ( var i = 0; i < len ; i++ ) {
            var option = document.createElement("option");
            option.innerHTML = devices[i];
            equimpment.appendChild(option);
        }
    };
    var runTips = document.getElementById("runTips"); // 执行框
    var h1 = runTips.getElementsByTagName("h1")[0];
    var runBack = document.getElementsByClassName("runBack");//返回

    h1.innerHTML = "设备连接中...";
    h1.style.display = "block";
    console.log(msg.status);
    if ( msg.status == "ok" ) {
        console.log(msg.status);
        console.log("连接正常");
        runCon.style.display = "none";
        h1.innerHTML = "指令发送中";

        var textArea = document.getElementById("textarea");
        var value = textArea.value;
        port.postMessage({code:value});


    } else if ( msg.status == "error" ) {
        h1.innerHTML = "设备没有连接到";
        runBack.style.display = "block";
    }
    if(msg.status == "off"){
        console.log("发送完成");
        var runCon = document.getElementsByClassName("runCon")[0]; //获取当前显示内容
        runCon.style.display = "none";
        setTimeout(function(){
            var paraBg = document.getElementById("paraBg");
            var runTips = document.getElementById("runTips");
            runTips.style.display = "none";
            paraBg.style.display = "none";
            paraBg.setAttribute("onclick","ideParameter()");
        },3000);

    }

    if ( msg.status == "over" ) {
        h1.innerHTML = "指令执行中";
        var runCon = document.getElementsByClassName("runCon")[0]; //获取当前显示内容
        runCon.style.display = "none";
    }

});

//点击执行
document.getElementById("tabRun").onclick = function(){

    chrome.runtime.sendMessage(exId, {query: "hasExtension"},
        function(response) {
            console.log("response" + response);

            if(response != true){
                var appBg = document.getElementById("appBg");
                var appTips = document.getElementById("applicationTips");// 安装步骤
                appTips.style.display = "block";
                appBg.style.display = "block";
            }else{
                var runTips = document.getElementById("runTips"); // 执行框
                var alertPrompt = document.getElementsByClassName("alertPrompt")[0]; //弹出框
                var mRun = document.getElementById("mRun");  //执行按钮
                var paraBg = document.getElementById("paraBg"); // 背景
                var equimpment = document.getElementById("equipment"); // select
                var tipYes = document.getElementById("tipYes"); // 点击确认按钮
                var runCon = document.getElementsByClassName("runCon")[0]; //获取当前显示内容
                var runBack = document.getElementsByClassName("runBack");//返回
                console.log("点击了执行！");
                showCode();
                var textArea = document.getElementById("contentRun"); //文本域
                var val = textArea.innerHTML;
                console.log("代码是：" + val );
                paraBg.setAttribute("onclick","hideRun()");
                console.log(alertPrompt);
                var h1 = runTips.getElementsByTagName("h1")[0];
                h1.style.display = "none";
                if( alertPrompt.style.display == "none") {
                    runTips.style.display = "block";
                    port.postMessage({cmd:"getDevices"}); //获取设备，然后遍历
                }
            }

        });



};
// 点击确认
document.getElementById("tipYes").onclick = function(){
    var alertPrompt = document.getElementsByClassName("alertPrompt")[0]; //弹出框
    var mRun = document.getElementById("mRun");  //执行按钮
    var paraBg = document.getElementById("paraBg"); // 背景
    var runTips = document.getElementById("runTips"); // 执行框
    var equimpment = document.getElementById("equipment"); // select
    var tipYes = document.getElementById("tipYes"); // 点击确认按钮
    var textArea = document.getElementById("textarea"); //文本域
    var runCon = document.getElementsByClassName("runCon")[0]; //获取当前显示内容
    var runBack = document.getElementsByClassName("runBack");//返回
    var index = equimpment.selectedIndex; //获取被选中的索引
    var options= equimpment.getElementsByTagName("option");
    var txt = options[index];
    var value =textArea.value;
    port.postMessage({choice:txt.innerHTML}); //发送设备  返回"status : ok
    port.postMessage({msg:value}); //发送代码
    runCon.style.display = "none";
    var h1 = runTips.getElementsByTagName("h1")[0];
    h1.innerHTML = "设备连接中...";
    h1.style.display = "block";
    //代码发送结束
};

/* 返回 */
document.getElementsByClassName("runCon")[0].onclick = function(){
    var runTips = document.getElementById("runTips"); // 执行框
    var h1 = runTips.getElementsByTagName("h1")[0];
    var runBack = document.getElementsByClassName("runBack")[0]; // 返回
    var runCon = document.getElementsByClassName("runCon")[0]; // 获取当前显示内容
    runTips.style.display = "block";
    runBack.style.display = "none";
    h1.style.display = "none";
    runCon.style.display = "block";
};


function hideRun(){
    var runTips = document.getElementById("runTips"); // 执行框
    var alertPrompt = document.getElementsByClassName("alertPrompt")[0]; //弹出框
    var paraBg = document.getElementById("paraBg"); // 背景
    runTips.style.display = "none";
    paraBg.style.display = "none";
    paraBg.setAttribute("onclick","ideParameter()");

}

function hideApp(){
    var appBg = document.getElementById("appBg");
    var appTips = document.getElementById("applicationTips");// 安装步骤
    appTips.style.display = "none";
    appBg.style.display = "none";
}
/*设备确定*/
function deviceTrue() {
    var equipment = document.getElementById("equipment");
    sIndex  = equipment.selectedIndex;
    HideDevice();
    var runTips = document.getElementById("runTips"); // 执行框
    var h1 = runTips.getElementsByTagName("h1")[0];
    runTips.style.display = "block";
    h1.style.display = "block";
}

function deviceDidChange(info){
    sIndex = info.selectedIndex ;
}