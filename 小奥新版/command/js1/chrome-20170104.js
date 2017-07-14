var exId = "gginmgpcjenjhlcmcfngifklahepmfbk"; // 上传
//var exId = "nofffkgkehekpnlgaioncpafafplellm"; // 笔记本
var sIndex = 0;
var port = chrome.runtime.connect(exId,{name: "knockknock"});
var devices = [];

chrome.runtime.sendMessage(exId, {query: "hasExtension"},
    function(response) {
        //console.log("response" + response);
        if(response != true){
            var appBg = document.getElementById("appBg");
            var appTips = document.getElementById("applicationTips");// 安装步骤
            appTips.style.display = "block";
            appBg.style.display = "block";
            console.log("123");
            console.log(msg);
           /* setTimeout(function(){
                alertPrompt.style.display = "none";
            },3000);*/
            //open("http://www.baidu.com");
        } else {
            port.postMessage({cmd:"getDevices"}); //获取设备，然后遍历
        }

    });
port.onMessage.addListener(function(msg) {
    console.log("监听执行！");
    console.log(msg);
    console.log(typeof msg.device);
    if (msg.device instanceof Array && msg.device.length > 0) {
        var devices = msg.device;
        var len = devices.length;
        console.log( msg.device );
        console.log(len);
        var equipment = document.getElementById("equipment"); // select
        equipment.innerHTML = " ";
        for ( var i = 0; i < len ; i++ ) {
            var option = document.createElement("option");
            option.innerHTML = devices[i];
            equipment.appendChild(option);
        }
        equipment.selectedIndex = sIndex ;
    };
    var runTips = document.getElementById("runTips"); // 执行框
    var h1 = runTips.getElementsByTagName("h1")[0];
    var runBack = document.getElementsByClassName("runBack");//返回


    //console.log(msg.status);
    if ( msg.status == "ok" ) {
        //console.log(msg.status);
        //console.log("连接正常");
        runTips.style.display = "block";
		h1.style.display = "block";
        h1.innerHTML = "指令发送中";
        var textArea = document.getElementById("contentRun"); //文本域
        var val = textArea.innerHTML;
        console.log("代码是：" + val );
        port.postMessage({code:val});
    } else if ( msg.status == "error" ) {
        runTips.style.display = "none";
		h1.style.display = "none";

        //h1.innerHTML = "设备没有连接到";
        //runBack.style.display = "block";

        ShowDevice() ;
    }
    if(msg.status == "off"){
        //console.log("发送完成");
        h1.innerHTML = "指令发送成功";
        setTimeout(function(){
            var paraBg = document.getElementById("paraBg");
            var runTips = document.getElementById("runTips");
            runTips.style.display = "none";
            paraBg.style.display = "none";
            paraBg.setAttribute("onclick","ideParameter()");
        },3000);
    }

    if ( msg.status == "over" ) {
		h1.style.display = "block" ;
        h1.innerHTML = "指令执行中" ;
    }

});

//点击执行
document.getElementById("tabRun").onclick = function(){
    var runTips = document.getElementById("runTips"); // 执行框
    var alertPrompt = document.getElementsByClassName("alertPrompt")[0]; //弹出框
    var tabRun = document.getElementById("tabRun");  //执行按钮
    var paraBg = document.getElementById("paraBg"); // 背景
    var h1 = runTips.getElementsByTagName("h1")[0];
    var equipment = document.getElementById("equipment"); // select
    var index = equipment.selectedIndex; //获取被选中的索引
    var options= equipment.getElementsByTagName("option");
    var txt = options[index];

    if ( txt == undefined ) {
        var appBg = document.getElementById("appBg");
        var appTips = document.getElementById("applicationTips");// 安装步骤
        appTips.style.display = "block";
        appBg.style.display = "block";
        return false;
    };

    sIndex = equipment.selectedIndex;
    h1.style.display = "none";
    //showCode();
    var textArea = document.getElementById("contentRun"); //文本域
    var val = textArea.innerHTML;
    console.log("代码是：" + val );
    paraBg.setAttribute("onclick","hideRun()");
    //console.log(alertPrompt);
    if( alertPrompt.style.display == "none") {
        runTips.style.display = "block";
        port.postMessage({choice:txt.innerHTML}); //发送设备  返回"status : ok
    }
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