var exId = "gginmgpcjenjhlcmcfngifklahepmfbk"; // 上传
//var exId = "nofffkgkehekpnlgaioncpafafplellm"; // 笔记本
var sIndex = 0;
var port = chrome.runtime.connect(exId,{name: "knockknock"});
var devices = [];

var runTips = document.getElementById("runTips"); // 执行框
var runBg = document.getElementById("runBg"); // 执行框
var h1 = runTips.getElementsByTagName("h1")[0];//内容提示
var runBack = document.getElementsByClassName("runBack")[0]; // 返回
var runCon = document.getElementsByClassName("runCon")[0]; // 获取当前显示内容
var tabRun = document.getElementById("tabRun");  //执行按钮
var equipment = document.getElementById("equipment"); // select
var tipYes = document.getElementById("tipYes"); // 点击确认按钮
var contentRun = document.getElementById("contentRun"); //文本域
var deviceYes = document.getElementById("deviceYes"); // 点击侧边栏时出现的确定按钮
var appBg = document.getElementById("appBg");
var appTips = document.getElementById("applicationTips");// 安装步骤

chrome.runtime.sendMessage(exId, {query: "hasExtension"},
    function(response) {
        console.log("response" + response);
        if(response != true){
            appTips.style.display = "block";
            appBg.style.display = "block";
            console.log("123");
            console.log(msg);
        } else {
            port.postMessage({cmd:"getDevices"}); //获取设备，然后遍历
        }
    });

port.onMessage.addListener(function(msg) {
    console.log("监听执行！");
    console.log(msg);
    console.log(typeof msg.device);

    if (msg.device instanceof Array && msg.device.length > 0) {
        devices = msg.device;
        var len = devices.length;
        console.log("msg is ");
        console.log( msg.device );
        console.log("device length is " + len);
        var equipment = document.getElementById("equipment"); // select
        equipment .innerHTML = " ";
        for ( var i = 0; i < len ; i++ ) {
            var option = document.createElement("option");
            option.innerHTML = devices[i];
            equipment .appendChild(option);
        }
        equipment.selectedIndex = sIndex ;
    };
    console.log(msg.status);
    if ( msg.status == "ok" ) {
        console.log(msg.status);
        console.log("连接正常");
        h1.innerHTML = "发送成功";
        runBack.style.display = "none" ;
        var val = contentRun.innerHTML;
        console.log("val is " + val );
        port.postMessage({code:val});
        setTimeout(function(){
            runTips.style.display = "none";
            runBg.style.display = "none";
        },3000);
    } else if ( msg.status == "error" ) {
        h1.innerHTML = "设备没有连接到";
        runBack.style.display = "block";
        return false;
    }

    if ( msg.status == "over" ) {
        h1.innerHTML = "指令执行中";
    }

});

//点击执行
tabRun.onclick = function(){
    var options= equipment.getElementsByTagName("option");
    var txt = devices[sIndex];
    if ( txt == undefined ) {
        appTips.style.display = "block";
        appBg.style.display = "block";
        return false;
    } else {
        ShowDevice();  //设备显示
         deviceYes.style.display = "none" ;
         tipYes.style.display = "block" ;
    };
};

// 点击确认
tipYes.onclick = function(){
    //代码发送结束
    sIndex  = equipment.selectedIndex;
    var options = equipment.getElementsByTagName("option");
    var txt = devices[sIndex];
    HideDevice();
    port.postMessage({choice:txt});
    runTips.style.display = "block";
    runBg.style.display = "block";
    h1.style.display = "block";

};

/*点击返回*/
runBack.onclick = function(){
    runTips.style.display = "none";
    runBg.style.display = "none";
    runBack.style.display = "none";
    h1.style.display = "none";
    ShowDevice();
    deviceYes.style.display = "none" ;
    tipYes.style.display = "block" ;
};


function hideRun(){
    runTips.style.display = "none";
    runBg.style.display = "none";
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
    var options = equipment.getElementsByTagName("option");
    var txt = options[sIndex];
    HideDevice();
};

function deviceDidChange(info){
    sIndex = info.selectedIndex ;
}