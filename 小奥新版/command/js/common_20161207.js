$(function(){

    function getIcon (div){
        var $toolbox = $("#toolbox");
        var $category = $toolbox.find("category");
        var $obj1 = {},$obj2 = {},$obj3 = {};
        for ( var i = 0 ; i < $category.length ; i++ ) {
            var $name = $category[i].getAttribute("name");
            var $icon = $category[i].getAttribute("icon");
            if ( $name && $name != null && $icon ){
                $obj1[i] = $name;
            }
        }

        var $row = $(div).find(".blocklyTreeRow");
        for ( var j = 0 ; j < $row.length ; j++ ) {
            var $text = $row[j].children[2].innerHTML;
            if ( $text && $text != null && $text.length > 0){
                $obj2[j] = $text ;
            }
        }
        for( var p in $obj1 ){
            for ( var o in $obj2) {
                if ( $obj1[p] == $obj2[o] ) {
                    var $_icon = $category[p].getAttribute("icon");
                    $row[o].children[1].setAttribute("style","background-image:url(" + $_icon + ")!important;display:inline-block;");
                }
            }
        }

    }

    setTimeout(function(){
        var $boxDiv = $(".blocklyToolboxDiv")[0];
        getIcon($boxDiv);
        $(".blocklyTreeRow").each(function(i){
            $(".blocklyTreeRow:eq(" + i + ")").click(function(){
                var that = this ;
                var $div = $(that).parent().children()[1];
                getIcon($div);
            });
        });
    },1);
})