'use strict';
Blockly.Blocks.command={};

goog.provide('Blockly.Blocks.command');

goog.require('Blockly.Blocks');

Blockly.Blocks.c1 = "#FFAB00";
Blockly.Blocks.mathColor = "#FF1164";
Blockly.Blocks.c2 = "#478FFF";
Blockly.Blocks.c3 = "#AD40FF";
Blockly.Blocks.c4 = "#FF3B46";
Blockly.Blocks.c5 = "#CF37BD";
Blockly.Blocks.c6 = "#00BFEA";
Blockly.Blocks.c7 = "#00CA59";

Blockly.Blocks['base_setup'] = {
  init: function() {
    this.jsonInit({
      "type": "base_setup",
      "message0": "%1",
      "args0": [
        {
          "type": "field_image",
          "src": "img/start.png",
          "width": 83,
          "height": 24,
          "alt": ""
        }
      ],
      "nextStatement": null,
      "colour":'#FFD900',
      "tooltip": "",
      "helpUrl": ""
    });
  }
};

Blockly.Blocks['base_delay'] = {
  init: function() {
    this.jsonInit({
      "type": "block_type",
      "message0": "%1 延时 %2 秒",
      "args0": [
        {
          "type": "field_image",
          "src": "img/delay.png",
          "width": 20,
          "height": 20,
          "alt": ""
        },
        {
          "type": "field_number",
          "name": "NUM",
          "value": 0
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c1,
      "tooltip": "",
      "helpUrl": ""
    });
  }
};

Blockly.Blocks['base_repeat'] = {
  init: function() {
    this.jsonInit({
      "type": "base_repeat'",
      "message0": "%1 重复 %2 次",
      "args0": [
        {
          "type": "field_image",
          "src": "img/repeat.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        },
        {
          "type": "field_number",
          "name": "NUM",
          "value": 0
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c1,
      "tooltip": "",
      "helpUrl": ""
    });
  }
};

Blockly.Blocks['base_repeat_end'] = {
  init: function() {
    this.jsonInit({
      "type": "base_repeat_end",
      "message0": "%1 重复结束",
      "args0": [
        {
          "type": "field_image",
          "src": "img/repeat.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c1,
      "tooltip": "",
      "helpUrl": ""
    });
  }
};
Blockly.Blocks['base_loop'] = {
  init: function() {
    this.jsonInit({
      "type": "base_loop",
      "message0": "循环 %1 次 %2",
      "args0": [
        {
          "type": "field_number",
          "name": "NAME",
          "value": 1,
          "min": 1,
          "max": 100
        },
        {
          "type": "input_statement",
          "name": "other"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c1,
      "tooltip": "",
      "helpUrl": ""
    });
  }
};

Blockly.Blocks['base_pause'] = {
  init: function() {
    this.jsonInit({
      "type": "base_repeat_end",
      "message0": "%1 暂停",
      "args0": [
        {
          "type": "field_image",
          "src": "img/pause.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c1,
      "tooltip": "",
      "helpUrl": ""
    });
  }
};

/*Blockly.Blocks['controls_if'] = {
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

/!*for*!/

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
};*/

/*----------------------行驶分类开始----------------------*/

Blockly.Blocks['run_forward'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "run_forward",
          "message0": "%1 前进 %2 秒",
          "args0": [
            {
              "type": "field_image",
              "src": "img/runFont.png",
              "width": 20,
              "height": 20,
              "alt": ""
            },
            {
              "type": "field_number",
              "name": "NUM",
              "value": 0
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c2,
          "tooltip": "",
          "helpUrl": ""
        }
    );
  }
};

Blockly.Blocks['run_backwards'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "run_backwards",
          "message0": "%1 后退 %2 秒",
          "args0": [
            {
              "type": "field_image",
              "src": "img/runBack.png",
              "width": 20,
              "height": 20,
              "alt": ""
            },
            {
              "type": "field_number",
              "name": "NUM",
              "value": 0
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c2,
          "tooltip": "",
          "helpUrl": ""
        }
    );
  }
};

Blockly.Blocks['run_left'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "run_left",
          "message0": "%1 左转 %2 秒",
          "args0": [
            {
              "type": "field_image",
              "src": "img/runLeft.png",
              "width": 20,
              "height": 20,
              "alt": ""
            },
            {
              "type": "field_number",
              "name": "NUM",
              "value": 0
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c2,
          "tooltip": "",
          "helpUrl": ""
        }
    );
  }
};

Blockly.Blocks['run_right'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "run_right",
          "message0": "%1 右转 %2 秒",
          "args0": [
            {
              "type": "field_image",
              "src": "img/runRight.png",
              "width": 20,
              "height": 20,
              "alt": ""
            },
            {
              "type": "field_number",
              "name": "NUM",
              "value": 0
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c2,
          "tooltip": "",
          "helpUrl": ""
        }
    );
  }
};

/*----------------------行驶分类结束----------------------*/

/*-------------------------看开始-------------------------*/

Blockly.Blocks['look_left'] = {
  init: function() {
    this.jsonInit({
      "type": "look_left",
      "message0": "%1 左看",
      "args0": [
        {
          "type": "field_image",
          "src": "img/lookLeft.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c3,
      "tooltip": "",
      "helpUrl": ""
    });
  }
};
Blockly.Blocks['look_right'] = {
  init: function() {
    this.jsonInit({
      "type": "look_right",
      "message0": "%1 右看",
      "args0": [
        {
          "type": "field_image",
          "src": "img/lookRight.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c3,
      "tooltip": "",
      "helpUrl": ""
    });
  }
};

Blockly.Blocks['look_people'] = {
  init: function() {
    this.jsonInit({
      "type": "look_people",
      "message0": "%1 看向说话的人",
      "args0": [
        {
          "type": "field_image",
          "src": "img/lookPeople.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c3,
      "tooltip": "",
      "helpUrl": ""
    });
  }
};
/*-------------------------看结束-------------------------*/

/*------------------------灯光开始--------------------------*/
Blockly.Blocks['light_left'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "light_left",
          "message0": "%1 左灯",
          "args0": [
            {
              "type": "field_image",
              "src": "img/light.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c4,
          "tooltip": "",
          "helpUrl": ""
        }
    );

  }
};
Blockly.Blocks['light_right'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "light_right",
          "message0": "%1 右灯",
          "args0": [
            {
              "type": "field_image",
              "src": "img/light.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c4,
          "tooltip": "",
          "helpUrl": ""
        }
    );
  }
};
Blockly.Blocks['light_front'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "light_right",
          "message0": "%1 前灯",
          "args0": [
            {
              "type": "field_image",
              "src": "img/light.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c4,
          "tooltip": "",
          "helpUrl": ""
        }
    );
  }
};
Blockly.Blocks['light_behind'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "light_right",
          "message0": "%1 后灯",
          "args0": [
            {
              "type": "field_image",
              "src": "img/light.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c4,
          "tooltip": "",
          "helpUrl": ""
        }
    );
  }
};
Blockly.Blocks['light_all'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "light_right",
          "message0": "%1 所有灯",
          "args0": [
            {
              "type": "field_image",
              "src": "img/light.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c4,
          "tooltip": "",
          "helpUrl": ""
        }
    );
  }
};
/*------------------------灯光结束--------------------------*/


/*------------------------声音开始--------------------------*/

Blockly.Blocks['sound_only'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "sound_only",
          "message0": "%1 说话",
          "args0": [
            {
              "type": "field_image",
              "src": "img/sound.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c5,
          "tooltip": "",
          "helpUrl": ""
        }
    );
  }
};
Blockly.Blocks['sound_say'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "sound_say",
          "message0": "%1 说 %2",
          "args0": [
            {
              "type": "field_image",
              "src": "img/say.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            },
            {
              "type": "field_dropdown",
              "name": "say",
              "options": [
                ["嗨","1"],
                ["嗯","2"],
                ["唔哦", "3"],
                ['好的','4'],
                ['叹息声','5'],
                ['哈','6'],
                ['哇','7'],
                ['再见','8']
              ]
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c5,
          "tooltip": "",
          "helpUrl": ""
        }
    );

  }
};

Blockly.Blocks['sound_animal'] = {
  init: function() {

    this.jsonInit(
        {
          "type": "sound_say",
          "message0": "%1 动物 %2",
          "args0": [
            {
              "type": "field_image",
              "src": "img/animal.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            },
            {
              "type": "field_dropdown",
              "name": "animal",
              "options": [
                ['马','1'],
                ['猫','2'],
                ['狗','3'],
                ['恐龙','4'],
                ['狮子','5'],
                ['山羊','6'],
                ['鳄鱼','7'],
                ['大象','8']
              ]
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c5,
          "tooltip": "",
          "helpUrl": ""
        }
    );

  }
};

Blockly.Blocks['sound_strange'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "sound_strange",
          "message0": "%1 奇怪 %2",
          "args0": [
            {
              "type": "field_image",
              "src": "img/strange.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            },
            {
              "type": "field_dropdown",
              "name": "strange",
              "options": [
                ['哔哔声','1'],
                ['激光','2'],
                ['咯咯声','3'],
                ['嗡嗡声','4'],
                ['呀呀呀','5'],
                ['吱吱声','6']
              ]
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c5,
          "tooltip": "",
          "helpUrl": ""
        }
    );

  }
};

Blockly.Blocks['sound_vehicle'] = {
  init: function() {

    this.jsonInit(
        {
          "type": "sound_vehicle",
          "message0": "%1 交通工具 %2",
          "args0": [
            {
              "type": "field_image",
              "src": "img/vehicle.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            },
            {
              "type": "field_dropdown",
              "name": "vehicle",
              "options": [
                ['火警报警','1'],
                ['卡车喇叭','2'],
                ['汽车发动机','3'],
                ['轿车轮胎摩擦','4'],
                ['直升飞机','5'],
                ['喷气式飞机','6'],
                ['船','7'],
                ['火车','8']
              ]
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c5,
          "tooltip": "",
          "helpUrl": ""
        }
    );

  }
};
/*------------------------声音结束--------------------------*/

/*------------------------动画开始--------------------------*/
Blockly.Blocks['animation_only'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "animation_only",
          "message0": "%1 跳舞",
          "args0": [
            {
              "type": "field_image",
              "src": "img/dance.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c6,
          "tooltip": "",
          "helpUrl": ""
        }
    );


  }
};

Blockly.Blocks['animation_greet'] = {
  init: function() {

    this.jsonInit(
        {
          "type": "animation_greet",
          "message0": "%1 问候 %2",
          "args0": [
            {
              "type": "field_image",
              "src": "img/greet.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            },
            {
              "type": "field_dropdown",
              "name": "greet",
              "options": [
                ['嗨','1'],
                ['你好','2'],
                ['没关系','3'],
                ['再见','4']
              ]
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c6,
          "tooltip": "",
          "helpUrl": ""
        }
    );


  }
};

Blockly.Blocks['animation_dance'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "animation_dance",
          "message0": "%1 跳舞 %2",
          "args0": [
            {
              "type": "field_image",
              "src": "img/dance2.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            },
            {
              "type": "field_dropdown",
              "name": "dance",
              "options": [
                ['自信','1'],
                ['左','2'],
                ['右','3'],
                ['可笑','4'],
                ['方块','5']
              ]
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c6,
          "tooltip": "",
          "helpUrl": ""
        }
    );


  }
};

Blockly.Blocks['animation_expression'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "animation_expression",
          "message0": "%1 表情 %2",
          "args0": [
            {
              "type": "field_image",
              "src": "img/expression.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            },
            {
              "type": "field_dropdown",
              "name": "expression",
              "options": [
                ['笑','1'],
                ['打嗝','2'],
                ['亲吻','3'],
                ['救命','4'],
                ['让我们开始吧','5'],
                ['呀','6'],
                ['口哨','7'],
                ['头晕','8']
              ]
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c6,
          "tooltip": "",
          "helpUrl": ""
        }
    );


  }
};

Blockly.Blocks['animation_match'] = {
  init: function() {

    this.jsonInit(
        {
          "type": "animation_match",
          "message0": "%1 比赛 %2",
          "args0": [
            {
              "type": "field_image",
              "src": "img/match.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            },
            {
              "type": "field_dropdown",
              "name": "match",
              "options": [
                ['出发','1'],
                ['打滑','2'],
                ['轮胎漏气','3'],
                ['发动机','4']
              ]
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c6,
          "tooltip": "",
          "helpUrl": ""
        }
    );


  }
};


Blockly.Blocks['animation_answer'] = {
  init: function() {
    this.jsonInit(
        {
          "type": "animation_answer",
          "message0": "%1 回答 %2",
          "args0": [
            {
              "type": "field_image",
              "src": "img/answer.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            },
            {
              "type": "field_dropdown",
              "name": "answer",
              "options": [
                ['也许','1'],
                ['否','2'],
                ['是','3'],
                ['好','4']
              ]
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c6,
          "tooltip": "",
          "helpUrl": ""
        }
    );


  }
};


Blockly.Blocks['animation_play'] = {
  init: function() {

    this.jsonInit(
        {
          "type": "animation_play",
          "message0": "%1 播放 %2",
          "args0": [
            {
              "type": "field_image",
              "src": "img/play.png",
              "width": 20,
              "height": 20,
              "alt": "*"
            },
            {
              "type": "field_dropdown",
              "name": "play",
              "options": [
                ['拿着','1'],
                ['躲藏','2'],
                ['接住','3']
              ]
            }
          ],
          "previousStatement": null,
          "nextStatement": null,
          "colour": Blockly.Blocks.c6,
          "tooltip": "",
          "helpUrl": ""
        }
    );

  }
};


/*------------------------动画结束--------------------------*/

/*------------------------功能开始--------------------------*/

Blockly.Blocks['fun_line'] = {
  init: function() {

    this.jsonInit({
      "type": "fun_line",
      "message0": "%1 寻线",
      "args0": [
        {
          "type": "field_image",
          "src": "img/line.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c7,
      "tooltip": "",
      "helpUrl": ""
    });

  }
};

Blockly.Blocks['fun_distance'] = {
  init: function() {

    this.jsonInit({
      "type": "fun_distance",
      "message0": "%1 探测障碍物距离",
      "args0": [
        {
          "type": "field_image",
          "src": "img/distance.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c7,
      "tooltip": "",
      "helpUrl": ""
    });

  }
};

Blockly.Blocks['fun_light'] = {
  init: function() {

    this.jsonInit({
      "type": "fun_distance",
      "message0": "%1 探测光线强度",
      "args0": [
        {
          "type": "field_image",
          "src": "img/light2.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c7,
      "tooltip": "",
      "helpUrl": ""
    });

  }
};

Blockly.Blocks['fun_sound'] = {
  init: function() {

    this.jsonInit({
      "type": "fun_sound",
      "message0": "%1 探测声音强度",
      "args0": [
        {
          "type": "field_image",
          "src": "img/sound2.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c7,
      "tooltip": "",
      "helpUrl": ""
    });

  }
};

Blockly.Blocks['fun_temp_hum'] = {
  init: function() {

    this.jsonInit({
      "type": "fun_temp_hum",
      "message0": "%1 探测温湿度传感器",
      "args0": [
        {
          "type": "field_image",
          "src": "img/tempHum.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c7,
      "tooltip": "",
      "helpUrl": ""
    });


  }
};
Blockly.Blocks['fun_temp'] = {
  init: function() {

    this.jsonInit({
      "type": "fun_temp",
      "message0": "%1 探测温度值",
      "args0": [
        {
          "type": "field_image",
          "src": "img/temp.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c7,
      "tooltip": "",
      "helpUrl": ""
    });

  }
};
Blockly.Blocks['fun_compass'] = {
  init: function() {

    this.jsonInit({
      "type": "fun_distance",
      "message0": "%1 读取电子罗盘",
      "args0": [
        {
          "type": "field_image",
          "src": "img/compass.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c7,
      "tooltip": "",
      "helpUrl": ""
    });

  }
};
Blockly.Blocks['fun_pot'] = {
  init: function() {

    this.jsonInit({
      "type": "fun_distance",
      "message0": "%1 读取电位器的值",
      "args0": [
        {
          "type": "field_image",
          "src": "img/pot.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c7,
      "tooltip": "",
      "helpUrl": ""
    });

  }
};
Blockly.Blocks['fun_red'] = {
  init: function() {

    this.jsonInit({
      "type": "fun_red",
      "message0": "%1 读取人体红外传感器的状态值",
      "args0": [
        {
          "type": "field_image",
          "src": "img/red.png",
          "width": 20,
          "height": 20,
          "alt": "*"
        }
      ],
      "previousStatement": null,
      "nextStatement": null,
      "colour": Blockly.Blocks.c7,
      "tooltip": "",
      "helpUrl": ""
    });

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