'use strict';

goog.provide('Blockly.JavaScript.command');

goog.require('Blockly.JavaScript');

/*-------------------------------开始-----------------------------*/

/*初始化*/
Blockly.JavaScript['base_setup'] = function(block) {
  var statements_name = Blockly.JavaScript.statementToCode(block, 'NAME');
  var code = 'START ';
  return code;
};

/*延时*/
Blockly.JavaScript['base_delay'] = function(block) {
  var number_num = block.getFieldValue('NUM');
  var code = 'ys ' + number_num + ' ';
  return code;
};

/*重复*/
Blockly.JavaScript['base_repeat'] = function(block) {
  var repeat_num = block.getFieldValue('NUM');
  var code = 'rp ' + repeat_num + ' ';
  return code;
};
/*重复结束*/
Blockly.JavaScript['base_repeat_end'] = function(block) {
  var code = 'rpd ';
  return code;
};

/*暂停*/
Blockly.JavaScript['base_pause'] = function(block) {
  var code = 'st ';
  return code;
};

/*if*/
Blockly.JavaScript['controls_if'] = function(block) {
  var code = (block.getFieldValue('BOOL') == 'TRUE') ? 'true' : 'false';
  return [code, Blockly.JavaScript.ORDER_ATOMIC];
};

/*重复 1-10-100*/
Blockly.JavaScript['controls_for'] = function(block) {
  var code = (block.getFieldValue('BOOL') == 'TRUE') ? 'true' : 'false';
  return [code, Blockly.JavaScript.ORDER_ATOMIC];
};


/*重复*/
Blockly.JavaScript['controls_whileUntil'] = function(block) {
  var code = (block.getFieldValue('BOOL') == 'TRUE') ? 'true' : 'false';
  return [code, Blockly.JavaScript.ORDER_ATOMIC];
};

/*中断*/
Blockly.JavaScript['controls_flow_statements'] = function(block) {
  var code = (block.getFieldValue('BOOL') == 'TRUE') ? 'true' : 'false';
  return [code, Blockly.JavaScript.ORDER_ATOMIC];
};

/*-------------------------------结束-----------------------------*/

/*-------------------------------行驶开始-----------------------------*/

/*向前*/
Blockly.JavaScript['run_forward'] = function(block) {
  var number_num = block.getFieldValue('NUM');
  var code = 'rf ' + number_num + ' ';
  return code;
};

/*向后*/
Blockly.JavaScript['run_backwards'] = function(block) {
  var number_num = block.getFieldValue('NUM');
  var code = 'rb ' + number_num + ' ';
  return code;
};

/*向左*/
Blockly.JavaScript['run_left'] = function(block) {
  var number_num = block.getFieldValue('NUM');
  var code = 'rl ' + number_num + ' ';
  return code;
};

/*向右*/
Blockly.JavaScript['run_right'] = function(block) {
  var number_num = block.getFieldValue('NUM');
  var code = 'rr ' + number_num + ' ';
  return code;
};

/*-------------------------------行驶结束-----------------------------*/

/*-------------------------------看开始-----------------------------*/
/*看左*/
Blockly.JavaScript['look_left'] = function(block) {
  var code = 'kl ';
  return code;
};

/*看右*/
Blockly.JavaScript['look_right'] = function(block) {
  var code = 'kr ';
  return code;
};

/*看向说话的人*/
Blockly.JavaScript['look_people'] = function(block) {
  var code = 'kp ';
  return code;
};


/*-------------------------------看结束-----------------------------*/

/*-------------------------------灯光开始-----------------------------*/

/*左灯*/
Blockly.JavaScript['light_left'] = function(block) {
  var code = "ll ";
  return [code];
};

/*右灯*/
Blockly.JavaScript['light_right'] = function(block) {
  var code = "lr ";
  return [code];
};

/*前灯*/
Blockly.JavaScript['light_front'] = function(block) {
  var code = "lf ";
  return [code];
};

/*后灯*/
Blockly.JavaScript['light_behind'] = function(block) {
  var code = "lb ";
  return [code];
};

/*所有灯*/
Blockly.JavaScript['light_all'] = function(block) {
  var code = "la ";
  return [code];
};

/*-------------------------------灯光结束-----------------------------*/

/*-------------------------------声音开始-----------------------------*/

/*说话*/
Blockly.JavaScript['sound_only'] = function(block) {
  var code = "sh ";
  return [code];
};

/*说*/
Blockly.JavaScript['sound_say'] = function(block) {
  var dropdown_say = block.getFieldValue('say');
  var code = 'ss ' + dropdown_say + ' ';
  return code;
};

/*动物*/
Blockly.JavaScript['sound_animal'] = function(block) {
  var dropdown_animal = block.getFieldValue('animal');
  var code = 'sa ' + dropdown_animal + ' ';
  return code;
};

/*奇怪*/
Blockly.JavaScript['sound_strange'] = function(block) {
  var dropdown_strange = block.getFieldValue('strange');
  var code = 'sst ' + dropdown_strange + ' ';
  return code;
};

/*交通工具*/
Blockly.JavaScript['sound_vehicle'] = function(block) {
  var dropdown_vehicle = block.getFieldValue('vehicle');
  var code = 'sv ' + dropdown_strange + ' ';
  return code;
};

/*-------------------------------声音结束-----------------------------*/

/*-------------------------------动画开始-----------------------------*/

/*跳舞*/
Blockly.JavaScript['animation_only'] = function(block) {
  var code = "ds ";
  return [code];
};

/*问候*/
Blockly.JavaScript['animation_greet'] = function(block) {
  var dropdown_greet = block.getFieldValue('greet');
  var code = 'ag ' + dropdown_greet + ' ';
};

/*跳舞*/
Blockly.JavaScript['animation_dance'] = function(block) {
  var dropdown_dance = block.getFieldValue('dance');
  var code = 'ad ' + dropdown_dance + ' ';
};

/*表情*/
Blockly.JavaScript['animation_expression'] = function(block) {
  var dropdown_expression = block.getFieldValue('expression');
  var code = 'ae ' + dropdown_expression + ' ';
};

/*比赛*/
Blockly.JavaScript['animation_match'] = function(block) {
  var dropdown_match = block.getFieldValue('match');
  var code = 'am ' + dropdown_match + ' ';
};

/*回答*/
Blockly.JavaScript['animation_answer'] = function(block) {
  var dropdown_answer = block.getFieldValue('answer');
  var code = 'aa ' + dropdown_answer + ' ';
};

/*播放*/
Blockly.JavaScript['animation_play'] = function(block) {
  var dropdown_play = block.getFieldValue('play');
  var code = 'ap ' + dropdown_play + ' ';
};

/*-------------------------------动画结束-----------------------------*/


/*-------------------------------功能开始-----------------------------*/
/*寻线*/
Blockly.JavaScript['fun_line'] = function(block) {
  var code = "xx ";
  return [code];
};

/*探测障碍物距离*/
Blockly.JavaScript['fun_distance'] = function(block) {
  var code = "zaw ";
  return [code];
};

/*探测光线强度*/
Blockly.JavaScript['fun_light'] = function(block) {
  var code = "gx ";
  return [code];
};

/*探测声音强度*/
Blockly.JavaScript['fun_sound'] = function(block) {
  var code = "sy ";
  return [code];
};

/*探测温湿度传感器*/
Blockly.JavaScript['fun_temp_hum'] = function(block) {
  var code = "wsd ";
  return [code];
};

/*探测温度值*/
Blockly.JavaScript['fun_temp'] = function(block) {
  var code = "wd ";
  return [code];
};

/*读取电子罗盘*/
Blockly.JavaScript['fun_compass'] = function(block) {
  var code = "dzlp ";
  return [code];
};

/*读取电子罗盘*/
Blockly.JavaScript['fun_compass'] = function(block) {
  var code = "dwq ";
  return [code];
};

/*读取电位器的值*/
Blockly.JavaScript['fun_pot'] = function(block) {
  var code = "dwq ";
  return [code];
};

/*读取人体红外传感器的状态值*/
Blockly.JavaScript['fun_red'] = function(block) {
  var code = "hw ";
  return [code];
};

/*-------------------------------功能结束-----------------------------*/
