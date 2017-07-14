
/*仅支持google 浏览器*/
function getBrowserInfo()
{
    var agent = navigator.userAgent.toLowerCase() ;
    var regStr_chrome = /chrome\/[\d.]+/gi ;
//Chrome
    if(agent.indexOf("chrome") > 0)
    {}else{
        var oBody=document.body;
        var browserBg=document.createElement("div");
        browserBg.className="browserBg";
        oBody.appendChild(browserBg);
        var browserWrap=document.createElement("div");
        browserWrap.className="browserWrap";
        browserWrap.innerHTML="<h1>对不起，您的浏览器版本太低了</h1><h1>请您更换成谷歌浏览器访问</h1><div class='chromePng'><img src='img/chrome.png'/></div>";
        oBody.appendChild(browserWrap);
    }
}
getBrowserInfo();
/*重新定义jquery中的$*/
var JQ = jQuery.noConflict();
var index_user = document.getElementById("index_user");
function loadLogin(){
    hasBg();
    hasLogin();
};
function loadRegister(){
    hasBg();
    hasRegister();
}
//隐藏登录框、注册框、背景
function userHide(){
    JQ("#user_bg").hide();
    JQ("#login").hide();
    JQ("#register").hide();
};
//判断是否有背景
function hasBg(){
    var bg = document.getElementById("user_bg");
    if(bg == null){
        var div = document.createElement("div");
        div.setAttribute("id","user_bg");
        div.setAttribute("onclick","userHide()");
        JQ("#index_user").append(div);
    }else{
        JQ("#user_bg").show();
    }
}
function hasLogin(){
    var login = document.getElementById("login");
    if( login == null ){
        JQ.ajax({
            url: "login.html",
            global: false,
            type: "GET",
            dataType: "html",
            async: false,
            success: function(msg) {
                JQ("#index_user").append(msg);
            }
        })
    }else{
        JQ("#login").show();
    }
}
function hasRegister(){
    var login = document.getElementById("register");
    if( login == null ){
        JQ.ajax({
            url: "register.html",
            global: false,
            type: "GET",
            dataType: "html",
            async: false,
            success: function(msg) {
                JQ("#index_user").append(msg);
            }
        })
    }else{
        JQ("#register").show();
    }
}

/*function ModularRun(){
 JQ(".alertPrompt").show();
 setInterval(function(){
 JQ(".alertPrompt").hide();
 },3000);
 }*/

// 执行

JQ(function(){

    function getIcon (div){
        var $toolbox = JQ("#toolbox");
        var $category = $toolbox.find("category");
        var $obj1 = {},$obj2 = {},$obj3 = {};
        for ( var i = 0 ; i < $category.length ; i++ ) {
            var $name = $category[i].getAttribute("name");
            var $icon = $category[i].getAttribute("icon");
            if ( $name && $name != null && $icon ){
                $obj1[i] = $name;
            }
        }

        var $row = JQ(div).find(".blocklyTreeRow");
        for ( var j = 0 ; j < $row.length ; j++ ) {
            var $text = $row[j].children[2].innerHTML;
            if ( $text && $text != null && $text.length > 0){
                $obj2[j] = $text ;
            } else {
                $row[j].style.display = "none";
            }
        }
        /*for( var p in $obj1 ){
            for ( var o in $obj2) {
                if ( $obj1[p] == $obj2[o] ) {
                    var $_icon = $category[p].getAttribute("icon");
                    $row[o].children[1].setAttribute("style","background-image:url(" + $_icon + ")!important;display:inline-block;");
                }
            }
        }*/

    }

    setTimeout(function(){
        var $boxDiv = JQ(".blocklyToolboxDiv")[0];
        getIcon($boxDiv);
        JQ(".blocklyTreeRow").each(function(i){
            JQ(".blocklyTreeRow:eq(" + i + ")").click(function(){
                var that = this ;
                var $div = JQ(that).parent().children()[1];
                getIcon($div);
            });
        });
    },1);

    JQ(".versionNum").click(function(){

        var $version = document.getElementById("version");
        if ( $version == null ) {
            var div = '<div id="version"><div class="versionTitle"><h1>版本更新说明</h1><div class="versionClose" onclick="hideVersion()"></div></div>' +
                '<div class="versionCon">' +
                '<p class="vTitle">2.1.0</p>' +
                '<p>整体风格重构</p>' +
                '<p>增加“小奥版”和“小车版”指令版本</p>' +
                '<p>执行按钮位置规划</p>' +
                '<p class="vTitle">2.0.0</p>' +
                '<p>指令编程第二版上线了</p>' +
                '<p>增加版本更新说明</p>' +
                '<p>增加帮助说明</p>' +
                '<p class="vTitle">1.1.0版 ：</p>' +
                '<p>增加各分类的功能块</p>' +
                '<p class="vTitle">1.0.0版 ：</p>' +
                '<p>指令编程上线了</p>' +
                '</div>' +
                '</div><div id="versionBg" style="display: block;" onclick="hideVersion()"></div>' ;
            JQ("body").append(div);
            JQ("#version").css({'opacity':'1'});
            setTimeout(function(){
                JQ("#version").css('transform',' scale(1)');
            },10);
        } else {
            JQ("#version").removeAttr("style");
            JQ("#version").css({'opacity':'1','transform':' scale(1)'});
            JQ("#versionBg").show();
        };
    });

});

/*版本提示消失*/
function hideVersion(){
    JQ("#versionBg").hide();
    JQ("#version").css({'opacity':'0'});
    setTimeout(function(){
        JQ("#version").removeAttr("style");
        JQ("#version").css({'z-index':'-1000'});
    },300);
};

/*优化侧边栏*/
function sideShowHide(ary){
    /*
     * 第二版 数组对象
     * 每个数组包含n个对象，对象包括 id , width , display , right , color , background
     * display 显示
     * color文字颜色
     * background 背景
     * width宽度
     * right
     * */
    for ( i in ary ) {
        var o = ary[i] ;
        var id = document.getElementById(o.id);
        if ( o.display != null || o.display != undefined || o.display) {
            id.style.display = o.display ;
        }
        if ( o.color != null || o.color != undefined || o.color ) {
            id.style.color = o.color ;
        }
        if ( o.background != null || o.background != undefined || o.background ) {
            id.style.background = o.background ;
        }
        if ( o.width != null || o.width != undefined || o.width ) {
            id.style.width = o.width ;
        }
        if ( o.right != null || o.right != undefined || o.right ) {
            id.style.right = o.right ;
        }
    }
}


/**
 * 点击侧边显示帮助按钮
 */
var sideHelpDisplay = false;
var sideSetDisplay = false;

/*帮助按钮*/
function sideHelpClick(){
    if(sideHelpDisplay){
        sideShowHide([
            {id:'helpTab', right:'0', color:'#eee',background:'rgba(36, 36, 36,0.4)'},
            {id:'helpList',width:'0',display:'none'},
            {id:'mid_td',display:'none'},
            {id:'setTab', right:'0', color:'#eee',background:'rgba(36, 36, 36,0.4)'},
        ]);
        sideHelpDisplay=false;
        sideSetDisplay = false;
    } else {
        sideShowHide([
            {id:'helpTab', right:'25%', color:'#fff',background:'#242424'},
            {id:'helpList',width:'25%',display:''},
            {id:'mid_td',display:''},
            {id:'setTab', right:'25%', color:'#eee',background:'rgba(36, 36, 36,0.4)'}
        ]);
        sideHelpDisplay=true;
        sideSetDisplay = false;
    }
    Code.helpInit();
}

/*设置按钮*/
function sideSetClick(){
    if(sideSetDisplay){
        sideShowHide([
            {id:'helpTab', right:'0', color:'#eee',background:'rgba(36, 36, 36,0.4)'},
            {id:'helpList',width:'0',display:'none'},
            {id:'mid_td',display:'none'},
            {id:'deviceBg',display:'none'},
            {id:'deviceContent',display:'none'},
            {id:'setTab', right:'0', color:'#eee',background:'rgba(36, 36, 36,0.4)'}
        ]);
        sideSetDisplay = false;
        sideHelpDisplay=false;
    } else {
        sideShowHide([
            {id:'helpTab', right:'0', color:'#eee',background:'rgba(36, 36, 36,0.4)'},
            {id:'helpList',width:'0',display:'none'},
            {id:'mid_td',display:'none'},
            {id:'deviceBg',display:'block'},
            {id:'deviceContent',display:'block'},
            {id:'setTab', right:'0', color:'#fff',background:'rgb(255, 114, 91)'}
        ]);
        sideSetDisplay = true;
        sideHelpDisplay=false;
        var runTips = document.getElementById("runTips"); // 执行框
        var h1 = runTips.getElementsByTagName("h1")[0];
        runTips.style.display = "none";
        h1.style.display = "none";
        JQ("#tipYes").hide();
        JQ("#deviceYes").show();
    }
    Code.helpInit();
}


/*设置显示*/
function ShowDevice(){
    $("#deviceBg").show();
    $("#deviceContent").show();
    console.log("show device") ;
}
function HideDevice(){
    $("#deviceBg").hide();
    $("#deviceContent").hide();
    sideShowHide([
        {id:'helpTab', right:'0', color:'#eee',background:'rgba(86, 93, 115,0.6)'},
        {id:'helpList',width:'0',display:'none'},
        {id:'mid_td',display:'none'},
        {id:'deviceBg',display:'none'},
        {id:'deviceContent',display:'none'},
        {id:'setTab', right:'0', color:'#eee',background:'rgba(86, 93, 115,0.6)'}
    ]);
    sideSetDisplay=false;
    var equipment = document.getElementById("equipment");
    equipment.selectedIndex = sIndex;
}


var helpTab = document.getElementById("helpTab");
/*helpTab.addEventListener('click', Code.init);*/
QA();
function QA(){
    var ch=document.documentElement.clientHeight || document.body.clientHeight;
    var h=ch-187-15;
    var QAwrap=document.getElementsByClassName("QAwrap")[0];
    QAwrap.style.height=h+"px";
};



