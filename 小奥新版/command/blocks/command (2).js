'use strict';
Blockly.Blocks.command={};

goog.provide('Blockly.Blocks.command');

goog.require('Blockly.Blocks');

Blockly.Blocks.c1 = "#8bb636";
Blockly.Blocks.mathColor = "#FF1164";
Blockly.Blocks.c2 = "#f07d00";
Blockly.Blocks.c3 = "#ba4db9";
Blockly.Blocks.c4 = "#ea6f6b";
Blockly.Blocks.c5 = "#3cc9ce";
Blockly.Blocks.c6 = "#20a4e4";
Blockly.Blocks.c7 = "#4b63b2";

Blockly.Blocks['base_setup'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c1);
    this.appendDummyInput()
        .appendField(Blockly.ALS_SETUP);
    this.appendStatementInput('DO')
        .appendField('');
    this.setTooltip(Blockly.ALS_SETUP_TIP);
  }
};

Blockly.Blocks['base_delay'] = {
  init: function() {
    var UNIT = [[Blockly.AlsDelayMs, 'delay'],[Blockly.AlsDelayUs, 'delayMicroseconds']];
    this.jsonInit({
      "message0": Blockly.AlsDelay,
      "args0": [
        {
          "type": "input_value",
          "name": "TIMES",
          "check": "Number"
        }
      ],
      "inputsInline": true,
      "previousStatement": true,
      "nextStatement": true,
      "colour": Blockly.Blocks.c1,
      "tooltip": Blockly.AlsDelayTip,
      "helpUrl": Blockly.Msg.LISTS_REPEAT_HELPURL
    });
    this.appendValueInput()
        .appendField(new Blockly.FieldDropdown(UNIT), 'UNIT')
        .setCheck(Number);
  }
};



Blockly.Blocks['controls_if'] = {
  init: function() {
    this.setHelpUrl(Blockly.Msg.CONTROLS_IF_HELPURL);
    this.setColour(Blockly.Blocks.c1);
    this.appendValueInput('IF0')
        .setCheck('Boolean')
        .appendField(Blockly.Msg.CONTROLS_IF_MSG_IF);
    this.appendStatementInput('DO0')
        .appendField(Blockly.Msg.CONTROLS_IF_MSG_THEN);
    this.setPreviousStatement(true);
    this.setNextStatement(true);
    this.setMutator(new Blockly.Mutator(['controls_if_elseif',
      'controls_if_else']));
    // Assign 'this' to a variable for use in the tooltip closure below.
    var thisBlock = this;
    this.setTooltip(function() {
      if (!thisBlock.elseifCount_ && !thisBlock.elseCount_) {
        return Blockly.Msg.CONTROLS_IF_TOOLTIP_1;
      } else if (!thisBlock.elseifCount_ && thisBlock.elseCount_) {
        return Blockly.Msg.CONTROLS_IF_TOOLTIP_2;
      } else if (thisBlock.elseifCount_ && !thisBlock.elseCount_) {
        return Blockly.Msg.CONTROLS_IF_TOOLTIP_3;
      } else if (thisBlock.elseifCount_ && thisBlock.elseCount_) {
        return Blockly.Msg.CONTROLS_IF_TOOLTIP_4;
      }
      return '';
    });
    this.elseifCount_ = 0;
    this.elseCount_ = 0;
  },
  mutationToDom: function() {
    if (!this.elseifCount_ && !this.elseCount_) {
      return null;
    }
    var container = document.createElement('mutation');
    if (this.elseifCount_) {
      container.setAttribute('elseif', this.elseifCount_);
    }
    if (this.elseCount_) {
      container.setAttribute('else', 1);
    }
    return container;
  },
  domToMutation: function(xmlElement) {
    this.elseifCount_ = parseInt(xmlElement.getAttribute('elseif'), 10) || 0;
    this.elseCount_ = parseInt(xmlElement.getAttribute('else'), 10) || 0;
    this.updateShape_();
  },
  decompose: function(workspace) {
    var containerBlock = workspace.newBlock('controls_if_if');
    containerBlock.initSvg();
    var connection = containerBlock.nextConnection;
    for (var i = 1; i <= this.elseifCount_; i++) {
      var elseifBlock = workspace.newBlock('controls_if_elseif');
      elseifBlock.initSvg();
      connection.connect(elseifBlock.previousConnection);
      connection = elseifBlock.nextConnection;
    }
    if (this.elseCount_) {
      var elseBlock = workspace.newBlock('controls_if_else');
      elseBlock.initSvg();
      connection.connect(elseBlock.previousConnection);
    }
    return containerBlock;
  },
  compose: function(containerBlock) {
    var clauseBlock = containerBlock.nextConnection.targetBlock();
    // Count number of inputs.
    this.elseifCount_ = 0;
    this.elseCount_ = 0;
    var valueConnections = [null];
    var statementConnections = [null];
    var elseStatementConnection = null;
    while (clauseBlock) {
      switch (clauseBlock.type) {
        case 'controls_if_elseif':
          this.elseifCount_++;
          valueConnections.push(clauseBlock.valueConnection_);
          statementConnections.push(clauseBlock.statementConnection_);
          break;
        case 'controls_if_else':
          this.elseCount_++;
          elseStatementConnection = clauseBlock.statementConnection_;
          break;
        default:
          throw 'Unknown block type.';
      }
      clauseBlock = clauseBlock.nextConnection &&
          clauseBlock.nextConnection.targetBlock();
    }
    this.updateShape_();
    // Reconnect any child blocks.
    for (var i = 1; i <= this.elseifCount_; i++) {
      Blockly.Mutator.reconnect(valueConnections[i], this, 'IF' + i);
      Blockly.Mutator.reconnect(statementConnections[i], this, 'DO' + i);
    }
    Blockly.Mutator.reconnect(elseStatementConnection, this, 'ELSE');
  },
  saveConnections: function(containerBlock) {
    var clauseBlock = containerBlock.nextConnection.targetBlock();
    var i = 1;
    while (clauseBlock) {
      switch (clauseBlock.type) {
        case 'controls_if_elseif':
          var inputIf = this.getInput('IF' + i);
          var inputDo = this.getInput('DO' + i);
          clauseBlock.valueConnection_ =
              inputIf && inputIf.connection.targetConnection;
          clauseBlock.statementConnection_ =
              inputDo && inputDo.connection.targetConnection;
          i++;
          break;
        case 'controls_if_else':
          var inputDo = this.getInput('ELSE');
          clauseBlock.statementConnection_ =
              inputDo && inputDo.connection.targetConnection;
          break;
        default:
          throw 'Unknown block type.';
      }
      clauseBlock = clauseBlock.nextConnection &&
          clauseBlock.nextConnection.targetBlock();
    }
  },
  updateShape_: function() {
    if (this.getInput('ELSE')) {
      this.removeInput('ELSE');
    }
    var i = 1;
    while (this.getInput('IF' + i)) {
      this.removeInput('IF' + i);
      this.removeInput('DO' + i);
      i++;
    }
    for (var i = 1; i <= this.elseifCount_; i++) {
      this.appendValueInput('IF' + i)
          .setCheck('Boolean')
          .appendField(Blockly.Msg.CONTROLS_IF_MSG_ELSEIF);
      this.appendStatementInput('DO' + i)
          .appendField(Blockly.Msg.CONTROLS_IF_MSG_THEN);
    }
    if (this.elseCount_) {
      this.appendStatementInput('ELSE')
          .appendField(Blockly.Msg.CONTROLS_IF_MSG_ELSE);
    }
  }
};

Blockly.Blocks['controls_if_if'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c1);
    this.appendDummyInput()
        .appendField(Blockly.Msg.CONTROLS_IF_IF_TITLE_IF);
    this.setNextStatement(true);
    this.setTooltip(Blockly.Msg.CONTROLS_IF_IF_TOOLTIP);
    this.contextMenu = false;
  }
};

Blockly.Blocks['controls_if_elseif'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c1);
    this.appendDummyInput()
        .appendField(Blockly.Msg.CONTROLS_IF_ELSEIF_TITLE_ELSEIF);
    this.setPreviousStatement(true);
    this.setNextStatement(true);
    this.setTooltip(Blockly.Msg.CONTROLS_IF_ELSEIF_TOOLTIP);
    this.contextMenu = false;
  }
};

Blockly.Blocks['controls_if_else'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c1);
    this.appendDummyInput()
        .appendField(Blockly.Msg.CONTROLS_IF_ELSE_TITLE_ELSE);
    this.setPreviousStatement(true);
    this.setTooltip(Blockly.Msg.CONTROLS_IF_ELSE_TOOLTIP);
    this.contextMenu = false;
  }
};

/*for*/

Blockly.Blocks['controls_for'] = {
  init: function() {
    this.jsonInit({
      "message0": Blockly.Msg.CONTROLS_FOR_TITLE,
      "args0": [
        {
          "type": "field_variable",
          "name": "VAR",
          "variable": null
        },
        {
          "type": "input_value",
          "name": "FROM",
          "check": "Number",
          "align": "RIGHT"
        },
        {
          "type": "input_value",
          "name": "TO",
          "check": "Number",
          "align": "RIGHT"
        },
        {
          "type": "input_value",
          "name": "BY",
          "check": "Number",
          "align": "RIGHT"
        }
      ],
      "inputsInline": true,
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c1,
      "helpUrl": Blockly.Msg.CONTROLS_FOR_HELPURL
    });
    this.appendStatementInput('DO')
        .appendField(Blockly.Msg.CONTROLS_FOR_INPUT_DO);
    var thisBlock = this;
    this.setTooltip(function() {
      return Blockly.Msg.CONTROLS_FOR_TOOLTIP.replace('%1',
          thisBlock.getFieldValue('VAR'));
    });
  },
  customContextMenu: function(options) {
    if (!this.isCollapsed()) {
      var option = {enabled: true};
      var name = this.getFieldValue('VAR');
      option.text = Blockly.Msg.VARIABLES_SET_CREATE_GET.replace('%1', name);
      var xmlField = goog.dom.createDom('field', null, name);
      xmlField.setAttribute('name', 'VAR');
      var xmlBlock = goog.dom.createDom('block', null, xmlField);
      xmlBlock.setAttribute('type', 'variables_get');
      option.callback = Blockly.ContextMenu.callbackFactory(this, xmlBlock);
      options.push(option);
    }
  }
};

Blockly.Blocks['controls_forEach'] = {
  init: function() {
    this.jsonInit({
      "message0": Blockly.Msg.CONTROLS_FOREACH_TITLE,
      "args0": [
        {
          "type": "field_variable",
          "name": "VAR",
          "variable": null
        },
        {
          "type": "input_value",
          "name": "LIST",
          "check": "Array"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c1,
      "helpUrl": Blockly.Msg.CONTROLS_FOREACH_HELPURL
    });
    this.appendStatementInput('DO')
        .appendField(Blockly.Msg.CONTROLS_FOREACH_INPUT_DO);
    var thisBlock = this;
    this.setTooltip(function() {
      return Blockly.Msg.CONTROLS_FOREACH_TOOLTIP.replace('%1',
          thisBlock.getFieldValue('VAR'));
    });
  },
  customContextMenu: Blockly.Blocks['controls_for'].customContextMenu
};

Blockly.Blocks['controls_flow_statements'] = {
  init: function() {
    var OPERATORS =
        [[Blockly.Msg.CONTROLS_FLOW_STATEMENTS_OPERATOR_BREAK, 'BREAK'],
          [Blockly.Msg.CONTROLS_FLOW_STATEMENTS_OPERATOR_CONTINUE, 'CONTINUE']];
    this.setHelpUrl(Blockly.Msg.CONTROLS_FLOW_STATEMENTS_HELPURL);
    this.setColour(Blockly.Blocks.c1);
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown(OPERATORS), 'FLOW');
    this.setPreviousStatement(true);
    var thisBlock = this;
    this.setTooltip(function() {
      var op = thisBlock.getFieldValue('FLOW');
      var TOOLTIPS = {
        'BREAK': Blockly.Msg.CONTROLS_FLOW_STATEMENTS_TOOLTIP_BREAK,
        'CONTINUE': Blockly.Msg.CONTROLS_FLOW_STATEMENTS_TOOLTIP_CONTINUE
      };
      return TOOLTIPS[op];
    });
  },
  onchange: function(e) {
    var legal = false;
    var block = this;
    do {
      if (this.LOOP_TYPES.indexOf(block.type) != -1) {
        legal = true;
        break;
      }
      block = block.getSurroundParent();
    } while (block);
    if (legal) {
      this.setWarningText(null);
    } else {
      this.setWarningText(Blockly.Msg.CONTROLS_FLOW_STATEMENTS_WARNING);
    }
  },
  LOOP_TYPES: ['controls_repeat', 'controls_repeat_ext', 'controls_forEach',
    'controls_for', 'controls_whileUntil']
};

Blockly.Blocks['controls_whileUntil'] = {
  init: function() {
    var OPERATORS =
        [[Blockly.Msg.CONTROLS_WHILEUNTIL_OPERATOR_WHILE, 'WHILE'],
          [Blockly.Msg.CONTROLS_WHILEUNTIL_OPERATOR_UNTIL, 'UNTIL']];
    this.setHelpUrl(Blockly.Msg.CONTROLS_WHILEUNTIL_HELPURL);
    this.setColour(Blockly.Blocks.c1);
    this.appendValueInput('BOOL')
        .setCheck('Boolean')
        .appendField(new Blockly.FieldDropdown(OPERATORS), 'MODE');
    this.appendStatementInput('DO')
        .appendField(Blockly.Msg.CONTROLS_WHILEUNTIL_INPUT_DO);
    this.setPreviousStatement(true);
    this.setNextStatement(true);
    var thisBlock = this;
    this.setTooltip(function() {
      var op = thisBlock.getFieldValue('MODE');
      var TOOLTIPS = {
        'WHILE': Blockly.Msg.CONTROLS_WHILEUNTIL_TOOLTIP_WHILE,
        'UNTIL': Blockly.Msg.CONTROLS_WHILEUNTIL_TOOLTIP_UNTIL
      };
      return TOOLTIPS[op];
    });
  }
};

/*----------------------行驶分类开始----------------------*/

Blockly.Blocks['run_forward'] = {
  init: function() {
    this.appendValueInput("NUM")
        .appendField(new Blockly.FieldImage("img/runFont.png", 20, 20))
        .appendField(Blockly.AlsForward);
    this.jsonInit({
      "args0": [
        {
          "type": "input_value",
          "name": "TIMES",
          "check": "Number"
        }
      ],
      "message0": Blockly.AlsSecond,
      "inputsInline": true,
      "previousStatement": true,
      "nextStatement": true,
      "colour": Blockly.Blocks.c2,
      "tooltip": Blockly.AlsForwardTip
    });
    this.contextMenu = false;
  }
};

Blockly.Blocks['run_backwards'] = {
  init: function() {
    this.appendValueInput("NUM")
        .appendField(new Blockly.FieldImage("img/runFont.png", 20, 20))
        .appendField(Blockly.AlsBackwards);
    this.jsonInit({
      "args0": [
        {
          "type": "field_number",
          "name": "TIMES",
          "check": "Number"
        }
      ],
      "message0": Blockly.AlsSecond,
      "inputsInline": true,
      "previousStatement": true,
      "nextStatement": true,
      "colour": Blockly.Blocks.c2,
      "tooltip": Blockly.AlsForwardTip
    });
    this.contextMenu = false;
  }
};

Blockly.Blocks['run_left'] = {
  init: function() {
    this.appendValueInput("NUM")
        .appendField(new Blockly.FieldImage("img/runFont.png", 20, 20))
        .appendField(Blockly.AlsLeft);
    this.jsonInit({
      "args0": [
        {
          "type": "input_value",
          "name": "TIMES",
          "check": "Number"
        }-
      ],
      "message0": Blockly.AlsSecond,
      "inputsInline": true,
      "previousStatement": true,
      "nextStatement": true,
      "colour": Blockly.Blocks.c2
    });
    this.contextMenu = false;
  }
};

Blockly.Blocks['run_right'] = {
  init: function() {
    this.appendValueInput("NUM")
        .appendField(new Blockly.FieldImage("img/runFont.png", 20, 20))
        .appendField(Blockly.AlsRight);
    this.jsonInit({
      "args0": [
        {
          "type": "input_value",
          "name": "TIMES",
          "check": "Number"
        }
      ],
      "message0": Blockly.AlsSecond,
      "inputsInline": true,
      "previousStatement": true,
      "nextStatement": true,
      "colour": Blockly.Blocks.c2,
    });
    this.contextMenu = false;
  }
};

/*----------------------行驶分类结束----------------------*/

/*-------------------------看开始-------------------------*/

Blockly.Blocks['look_left'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c3);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/lookLeft.png", 20, 20))
        .appendField(Blockly.AlsLookLeft);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsLookLeftTip);
  }
};
Blockly.Blocks['look_right'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c3);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/lookRight.png", 20, 20))
        .appendField(Blockly.AlsLookRight);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsLookRightTip);
  }
};

Blockly.Blocks['look_people'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c3);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/lookPeople.png", 20, 20))
        .appendField(Blockly.AlsLookPeople);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsLookPeopleTip);
  }
};
/*-------------------------看结束-------------------------*/

/*------------------------灯光开始--------------------------*/
Blockly.Blocks['light_left'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c4);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/light.png", 20, 20))
        .appendField(Blockly.AlsLightLeft);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsLightLeftTip);
  }
};
Blockly.Blocks['light_right'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c4);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/light.png", 20, 20))
        .appendField(Blockly.AlsLightRight);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsLightRightTip);
  }
};
Blockly.Blocks['light_front'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c4);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/light.png", 20, 20))
        .appendField(Blockly.AlsLightFront);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsLightFrontTip);
  }
};
Blockly.Blocks['light_behind'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c4);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/light.png", 20, 20))
        .appendField(Blockly.AlsLightBehind);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsLightBehindTip);
  }
};
Blockly.Blocks['light_all'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c4);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/light.png", 20, 20))
        .appendField(Blockly.AlsLightAll);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsLightAllTip);
  }
};
/*------------------------灯光结束--------------------------*/


/*------------------------声音开始--------------------------*/

Blockly.Blocks['sound_only'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c5);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/sound.png", 20, 20))
        .appendField(Blockly.AlsSoundOnly);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsSoundOnlyTip);
  }
};
Blockly.Blocks['sound_say'] = {
  init: function() {
    var say = [['嗨','say1'],['嗯','say2'],['唔哦','say3'],['好的','say4'],['叹息声','say5'],['哈','say6'],['哇','say7'],['再见','']];
    this.setColour(Blockly.Blocks.c5);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/say.png", 20, 20))
        .appendField(Blockly.AlsSoundSay)
        .appendField(new Blockly.FieldDropdown(say), 'say');
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsSoundSayTip);
  }
};

Blockly.Blocks['sound_animal'] = {
  init: function() {
    var animal = [['马','animal1'],['猫','animal2'],['狗','animal3'],['恐龙','animal4'],['狮子','animal5'],['山羊','animal6'],['鳄鱼','animal7'],['大象','animal8']];
    this.setColour(Blockly.Blocks.c5);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/animal.png", 20, 20))
        .appendField(Blockly.AlsSoundAnimal)
        .appendField(new Blockly.FieldDropdown(animal), 'animal');
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsSoundAnimalTip);
  }
};

Blockly.Blocks['sound_strange'] = {
  init: function() {
    var strange = [['哔哔声','strange1'],['激光','strange2'],['咯咯声','strange3'],['嗡嗡声','strange4'],['呀呀呀','strange5'],['吱吱声','strange6']];
    this.setColour(Blockly.Blocks.c5);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/strange.png", 20, 20))
        .appendField(Blockly.AlsSoundStrange)
        .appendField(new Blockly.FieldDropdown(strange), 'strange');
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsSoundStrangeTip);
  }
};

Blockly.Blocks['sound_vehicle'] = {
  init: function() {
    var vehicle = [['火警报警','vehicle1'],['卡车喇叭','vehicle2'],['汽车发动机','vehicle3'],['轿车轮胎摩擦','vehicle4'],['直升飞机','vehicle5'],['喷气式飞机','vehicle6'],['船','vehicle7'],['火车','vehicle8']];
    this.setColour(Blockly.Blocks.c5);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/vehicle.png", 20, 20))
        .appendField(Blockly.AlsSoundVehicle)
        .appendField(new Blockly.FieldDropdown(vehicle), 'vehicle');
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsSoundVehicleTip);
  }
};
/*------------------------声音结束--------------------------*/

/*------------------------动画开始--------------------------*/
Blockly.Blocks['animation_only'] = {
  init: function() {
   this.setColour(Blockly.Blocks.c6);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/dance.png", 20, 20))
        .appendField(Blockly.AlsAnimationOnly);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsAnimationOnlyTip);
  }
};

Blockly.Blocks['animation_greet'] = {
  init: function() {
    var greet = [['嗨','greet1'],['你好','greet2'],['没关系','greet3'],['再见','greet4']];
    this.setColour(Blockly.Blocks.c6);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/greet.png", 20, 20))
        .appendField(Blockly.AlsAnimationGreet)
        .appendField(new Blockly.FieldDropdown(greet), 'greet');
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsAnimationGreetTip);
  }
};

Blockly.Blocks['animation_dance'] = {
  init: function() {
    var dance = [['自信','dance1'],['左','dance2'],['右','dance3'],['可笑','dance4'],['方块','dance5']];
    this.setColour(Blockly.Blocks.c6);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/dance2.png", 20, 20))
        .appendField(Blockly.AlsAnimationDance)
        .appendField(new Blockly.FieldDropdown(dance), 'dance');
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsAnimationDanceTip);
  }
};

Blockly.Blocks['animation_expression'] = {
  init: function() {
    var expressio = [['笑','expression1'],['打嗝','expression2'],['亲吻','expression3'],['救命','expression4'],['让我们开始吧','expression5'],['呀','expression6'],['口哨','expression7'],['头晕','expression8']];
    this.setColour(Blockly.Blocks.c6);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/expression.png", 20, 20))
        .appendField(Blockly.AlsAnimationExpression)
        .appendField(new Blockly.FieldDropdown(expressio), 'vehicle');
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsAnimationExpressionTip);
  }
};

Blockly.Blocks['animation_match'] = {
  init: function() {
    var match = [['出发','match1'],['打滑','match2'],['轮胎漏气','match3'],['发动机','match4']];
    this.setColour(Blockly.Blocks.c6);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/match.png", 20, 20))
        .appendField(Blockly.AlsAnimationMatch)
        .appendField(new Blockly.FieldDropdown(match), 'match');
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsAnimationMatchTip);
  }
};


Blockly.Blocks['animation_answer'] = {
  init: function() {
    var answer = [['也许','answer1'],['否','answer2'],['是','answer3'],['好','answer4']];
    this.setColour(Blockly.Blocks.c6);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/answer.png", 20, 20))
        .appendField(Blockly.AlsAnimationAnswer)
        .appendField(new Blockly.FieldDropdown(answer), 'answer');
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsAnimationAnswerTip);
  }
};


Blockly.Blocks['animation_play'] = {
  init: function() {
    var play = [['拿着','play1'],['躲藏','play2'],['接住','play3']];
    this.setColour(Blockly.Blocks.c6);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/play.png", 20, 20))
        .appendField(Blockly.AlsAnimationPlay)
        .appendField(new Blockly.FieldDropdown(play), 'play');
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsAnimationPlayTip);
  }
};


/*------------------------动画结束--------------------------*/

/*------------------------功能开始--------------------------*/

Blockly.Blocks['fun_line'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c7);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/line.png", 20, 20))
        .appendField(Blockly.AlsFunLine);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsFunLineTip);
  }
};

Blockly.Blocks['fun_distance'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c7);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/distance.png", 20, 20))
        .appendField(Blockly.AlsFunDistance);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsFunDistanceTip);
  }
};

Blockly.Blocks['fun_light'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c7);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/light2.png", 20, 20))
        .appendField(Blockly.AlsFunLight);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsFunLightTip);
  }
};

Blockly.Blocks['fun_sound'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c7);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/sound2.png", 20, 20))
        .appendField(Blockly.AlsFunSound);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsFunSoundTip);
  }
};

Blockly.Blocks['fun_temp_hum'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c7);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/tempHum.png", 20, 20))
        .appendField(Blockly.AlsFunTempHum);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsFunTempHumTip);
  }
};
Blockly.Blocks['fun_temp'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c7);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/temp.png", 20, 20))
        .appendField(Blockly.AlsFunTemp);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsFunTempTip);
  }
};
Blockly.Blocks['fun_compass'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c7);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/compass.png", 20, 20))
        .appendField(Blockly.AlsFunCompass);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsFunCompassTip);
  }
};
Blockly.Blocks['fun_pot'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c7);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/pot.png", 20, 20))
        .appendField(Blockly.AlsFunPot);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsFunPotTip);
  }
};
Blockly.Blocks['fun_red'] = {
  init: function() {
    this.setColour(Blockly.Blocks.c7);
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("img/red.png", 20, 20))
        .appendField(Blockly.AlsFunRed)
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setTooltip(Blockly.AlsFunRedTip);
  }
};

/*------------------------功能结束--------------------------*/


/*公共*/

Blockly.Blocks['math_number'] = {
  init: function() {
    this.setColour(Blockly.Blocks.mathColor);
    this.appendDummyInput()
        .appendField(new Blockly.FieldNumber('0'), 'NUM');
    this.setOutput(true, 'Number');
    var thisBlock = this;
    this.setTooltip(function() {
      var parent = thisBlock.getParent();
      return (parent && parent.getInputsInline() && parent.tooltip) ||
          Blockly.Msg.MATH_NUMBER_TOOLTIP;
    });
  }
};

Blockly.FieldTextInput.math_number_validator = function(text) {
  return String(text);//不再校验
};