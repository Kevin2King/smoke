var Custom = function() {
    // 开启遮罩效果
    var handleStartPageBlockUI = function() {
        App.blockUI({
            overlayColor: "#EEE",
            animate: true
        });
    };

    // 关闭遮罩效果
    var handleStopPageBlockUI = function() {
        App.unblockUI();
    };

    // 警告提示框
    var handleAlertsApi = function (message, type) {
        App.alert({
            container: "", // alerts parent container(by default placed after the page breadcrumbs)
            place: "prepent", // append or prepent in container
            type: type,  // alert's type
            message: message,  // alert's message
            close: true, // make alert closable
            reset: true, // close all previouse alerts first
            focus: true, // auto scroll to the alert after shown
            closeInSeconds: type == "success" ? 5 : 0, // auto close after defined seconds
            icon: type == "success" ? "fa fa-check" : "fa fa-close" // put icon before the message
        });
    };

    // 确认对话框
    var handleBootBoxConfirm = function (message, href) {
        bootbox.dialog({
            message: message,
            title: "温馨提示",
            buttons: {
                danger: {
                    label: "取消",
                    className: "default",
                    callback: function() {

                    }
                },
                main: {
                    label: "确定",
                    className: "blue",
                    callback: function() {
                        Custom.initStartPageBlockUI();
                        window.location = href;
                    }
                }
            }
        });

        return false;
    };

    // 确认对话框（自定义回调）
    var handleBootBoxConfirmWithCallback = function (message, cancelCallback, successCallback) {
        bootbox.dialog({
            message: message,
            title: "温馨提示",
            buttons: {
                danger: {
                    label: "取消",
                    className: "default",
                    callback: function() {
                        cancelCallback();
                    }
                },
                main: {
                    label: "确定",
                    className: "blue",
                    callback: function() {
                        successCallback();
                    }
                }
            }
        });

        return false;
    };

    // 警告对话框
    var handleBootBoxAlert = function (message) {
        bootbox.dialog({
            message: message,
            title: "温馨提示",
            buttons: {
                main: {
                    label: "确定",
                    className: "blue",
                    callback: function() {
                    }
                }
            }
        });

        return false;
    };

    // 获取字典标签
    var handleGetDictLabel = function (data, value, defaultValue) {
        for (var i=0; i<data.length; i++){
            var row = data[i];
            if (row.value == value){
                return row.label;
            }
        }
        return defaultValue;
    };

    // 获取URL地址参数
    var handleGetQueryString = function (name, url) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        if (!url || url == ""){
            url = window.location.search;
        }else{
            url = url.substring(url.indexOf("?"));
        }
        r = url.substr(1).match(reg)
        if (r != null) return unescape(r[2]); return null;
    };

    // 绑定复选框
    var handleCheckbox = function(tId) {
        var table = $("#" + tId);
        table.find('.group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).prop("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).prop("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
            jQuery.uniform.update(set);
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });
    };

    // 获取复选框选中值
    var handleCheckboxValues = function(tId) {
        var table = $("#" + tId);
        var trs = table.find('tbody tr .checkboxes');
        var values = new Array();
        jQuery(trs).each(function () {
            var checked = $(this).prop("checked");
            if (checked) {
                values.push($(this).val());
            }
        });
        return values;
    };

    // 是否微信浏览器
    var handlerIsWeChat = function() {
        var ua = navigator.userAgent.toLowerCase();
        if (ua.match(/MicroMessenger/i) == "micromessenger") {
            return true;
        } else {
            return false;
        }
    };

    /**
     * jQuery验证框架通用验证方法
     *
     *  自带验证类型
     *      required - 必填信息
     *      remote - 请修正该信息
     *      email - 请输入正确格式的电子邮件
     *      url - 请输入合法的网址
     *      date - 请输入合法的日期
     *      dateISO - 请输入合法的日期 (ISO)
     *      number - 请输入合法的数字
     *      digits - 只能输入整数
     *      creditcard - 请输入合法的信用卡号
     *      equalTo - 请再次输入相同的值
     *      accept - 请输入拥有合法后缀名的字符串
     *      maxlength - 请输入一个长度最多是 {0} 的字符串
     *      minlength - 请输入一个长度最少是 {0} 的字符串
     *      rangelength - 请输入一个长度介于 {0} 和 {1} 之间的字符串
     *      range - 请输入一个介于 {0} 和 {1} 之间的值
     *      max - 请输入一个最大为 {0} 的值
     *      min - 请输入一个最小为 {0} 的值
     *
     * 自定义验证类型
     *      isIntEqZero - 整数必须为0
     *      isIntGtZero - 整数必须大于0
     *      isIntGteZero - 整数必须大于或等于0
     *      isIntNEqZero - 整数必须不等于0
     *      isIntLtZero - 整数必须小于0
     *      isIntLteZero - 整数必须小于或等于0
     *      isFloatEqZero - 判断浮点数value是否等于0
     *      isFloatGtZero - 浮点数必须大于0
     *      isFloatGteZero - 浮点数必须大于或等于0
     *      isFloatNEqZero - 浮点数必须不等于0
     *      isFloatLtZero - 浮点数必须小于0
     *      isFloatLteZero - 浮点数必须小于或等于0
     *      isFloat - 判断浮点型
     *      isInteger - 匹配integer
     *      isNumber - 匹配数值类型，包括整数和浮点数
     *      isDigits - 只能输入0-9数字
     *      isChinese - 只能包含中文字符
     *      isEnglish - 只能包含英文字符
     *      isMobile - 请正确填写您的手机号码
     *      isPhone - 请正确填写您的电话号码
     *      isTel - 联系电话(手机/电话皆可)验证
     *      isQq - 匹配QQ
     *      isZipCode - 邮政编码验证
     *      isPwd - 匹配密码，以字母开头，长度在6-12之间，只能包含字符、数字和下划线
     *      isIdCardNo - 身份证号码验证
     *      ip - IP地址验证
     *      stringCheck - 字符验证，只能包含中文、英文、数字、下划线等字符
     *      isChineseChar - 匹配中文(包括汉字和字符)
     *      isRightfulString - 判断是否为合法字符(a-zA-Z0-9-_)
     *      isContainsSpecialChar - 判断是否包含中英文特殊字符，除英文"-_"字符外
     *      isPlateNo - 车牌号校验
     */
    var handleJQueryValidateMethods = function() {
        // 判断整数value是否等于0
        jQuery.validator.addMethod("isIntEqZero", function (value, element) {
            value = parseInt(value);
            return this.optional(element) || value == 0;
        }, "整数必须为0");

        // 判断整数value是否大于0
        jQuery.validator.addMethod("isIntGtZero", function (value, element) {
            value = parseInt(value);
            return this.optional(element) || value > 0;
        }, "整数必须大于0");

        // 判断整数value是否大于或等于0
        jQuery.validator.addMethod("isIntGteZero", function (value, element) {
            value = parseInt(value);
            return this.optional(element) || value >= 0;
        }, "整数必须大于或等于0");

        // 判断整数value是否不等于0
        jQuery.validator.addMethod("isIntNEqZero", function (value, element) {
            value = parseInt(value);
            return this.optional(element) || value != 0;
        }, "整数必须不等于0");

        // 判断整数value是否小于0
        jQuery.validator.addMethod("isIntLtZero", function (value, element) {
            value = parseInt(value);
            return this.optional(element) || value < 0;
        }, "整数必须小于0");

        // 判断整数value是否小于或等于0
        jQuery.validator.addMethod("isIntLteZero", function (value, element) {
            value = parseInt(value);
            return this.optional(element) || value <= 0;
        }, "整数必须小于或等于0");

        // 判断浮点数value是否等于0
        jQuery.validator.addMethod("isFloatEqZero", function (value, element) {
            value = parseFloat(value);
            return this.optional(element) || value == 0;
        }, "浮点数必须为0");

        // 判断浮点数value是否大于0
        jQuery.validator.addMethod("isFloatGtZero", function (value, element) {
            value = parseFloat(value);
            return this.optional(element) || value > 0;
        }, "浮点数必须大于0");

        // 判断浮点数value是否大于或等于0
        jQuery.validator.addMethod("isFloatGteZero", function (value, element) {
            value = parseFloat(value);
            return this.optional(element) || value >= 0;
        }, "浮点数必须大于或等于0");

        // 判断浮点数value是否不等于0
        jQuery.validator.addMethod("isFloatNEqZero", function (value, element) {
            value = parseFloat(value);
            return this.optional(element) || value != 0;
        }, "浮点数必须不等于0");

        // 判断浮点数value是否小于0
        jQuery.validator.addMethod("isFloatLtZero", function (value, element) {
            value = parseFloat(value);
            return this.optional(element) || value < 0;
        }, "浮点数必须小于0");

        // 判断浮点数value是否小于或等于0
        jQuery.validator.addMethod("isFloatLteZero", function (value, element) {
            value = parseFloat(value);
            return this.optional(element) || value <= 0;
        }, "浮点数必须小于或等于0");

        // 判断浮点型
        jQuery.validator.addMethod("isFloat", function (value, element) {
            return this.optional(element) || /^[-\+]?\d+(\.\d+)?$/.test(value);
        }, "只能包含数字、小数点等字符");

        // 匹配integer
        jQuery.validator.addMethod("isInteger", function (value, element) {
            return this.optional(element) || (/^[-\+]?\d+$/.test(value) && parseInt(value) >= 0);
        }, "匹配integer");

        // 判断数值类型，包括整数和浮点数
        jQuery.validator.addMethod("isNumber", function (value, element) {
            return this.optional(element) || /^[-\+]?\d+$/.test(value) || /^[-\+]?\d+(\.\d+)?$/.test(value);
        }, "匹配数值类型，包括整数和浮点数");

        // 只能输入[0-9]数字
        jQuery.validator.addMethod("isDigits", function (value, element) {
            return this.optional(element) || /^\d+$/.test(value);
        }, "只能输入0-9数字");

        // 判断中文字符
        jQuery.validator.addMethod("isChinese", function (value, element) {
            return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
        }, "只能包含中文字符");

        // 判断英文字符
        jQuery.validator.addMethod("isEnglish", function (value, element) {
            return this.optional(element) || /^[A-Za-z]+$/.test(value);
        }, "只能包含英文字符");

        // 手机号码验证
        jQuery.validator.addMethod("isMobile", function (value, element) {
            var length = value.length;
            return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
        }, "请正确填写您的手机号码");

        // 电话号码验证
        jQuery.validator.addMethod("isPhone", function (value, element) {
            var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
            return this.optional(element) || (tel.test(value));
        }, "请正确填写您的电话号码");

        // 联系电话(手机/电话皆可)验证
        jQuery.validator.addMethod("isTel", function (value, element) {
            var length = value.length;
            var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
            var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
            return this.optional(element) || tel.test(value) || (length == 11 && mobile.test(value));
        }, "请正确填写您的联系方式");

        // 匹配qq
        jQuery.validator.addMethod("isQq", function (value, element) {
            return this.optional(element) || /^[1-9]\d{4,12}$/;
        }, "匹配QQ");

        // 邮政编码验证
        jQuery.validator.addMethod("isZipCode", function (value, element) {
            var zip = /^[0-9]{6}$/;
            return this.optional(element) || (zip.test(value));
        }, "请正确填写您的邮政编码");

        // 匹配密码，以字母开头，长度在6-12之间，只能包含字符、数字和下划线。
        jQuery.validator.addMethod("isPwd", function (value, element) {
            return this.optional(element) || /^[a-zA-Z]\\w{6,12}$/.test(value);
        }, "以字母开头，长度在6-12之间，只能包含字符、数字和下划线");

        // 身份证号码验证
        jQuery.validator.addMethod("isIdCardNo", function (value, element) {
            //var idCard = /^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/;
            return this.optional(element) || isIdCardNo(value);
        }, "请输入正确的身份证号码");

        // IP地址验证
        jQuery.validator.addMethod("ip", function (value, element) {
            return this.optional(element) || /^(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.)(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.){2}([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))$/.test(value);
        }, "请填写正确的IP地址");

        // 字符验证，只能包含中文、英文、数字、下划线等字符。
        jQuery.validator.addMethod("stringCheck", function (value, element) {
            return this.optional(element) || /^[a-zA-Z0-9\u4e00-\u9fa5-_]+$/.test(value);
        }, "只能包含中文、英文、数字、下划线等字符");

        // 匹配中文(包括汉字和字符)
        jQuery.validator.addMethod("isChineseChar", function (value, element) {
            return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
        }, "匹配中文(包括汉字和字符) ");

        // 判断是否为合法字符(a-zA-Z0-9-_)
        jQuery.validator.addMethod("isRightfulString", function (value, element) {
            return this.optional(element) || /^[A-Za-z0-9_-]+$/.test(value);
        }, "判断是否为合法字符(a-zA-Z0-9-_)");

        // 判断是否包含中英文特殊字符，除英文"-_"字符外
        jQuery.validator.addMethod("isContainsSpecialChar", function (value, element) {
            var reg = RegExp(/[(\ )(\`)(\~)(\!)(\@)(\#)(\$)(\%)(\^)(\&)(\*)(\()(\))(\+)(\=)(\|)(\{)(\})(\')(\:)(\;)(\')(',)(\[)(\])(\.)(\<)(\>)(\/)(\?)(\~)(\！)(\@)(\#)(\￥)(\%)(\…)(\&)(\*)(\（)(\）)(\—)(\+)(\|)(\{)(\})(\【)(\】)(\‘)(\；)(\：)(\”)(\“)(\’)(\。)(\，)(\、)(\？)]+/);
            return this.optional(element) || !reg.test(value);
        }, "含有中英文特殊字符");

        // 车牌号校验
        jQuery.validator.addMethod("isPlateNo", function (value, element) {
            return isPlateNo(value);
        }, "请输入正确的车牌号码");

        // 身份证号码的验证规则
        function isIdCardNo(num) {
            //if (isNaN(num)) {alert("输入的不是数字！"); return false;}
            var len = num.length, re;
            if (len == 15)
                re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{2})(\w)$/);
            else if (len == 18)
                re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/);
            else {
                //alert("输入的数字位数不对。");
                return false;
            }
            var a = num.match(re);
            if (a != null) {
                if (len == 15) {
                    var D = new Date("19" + a[3] + "/" + a[4] + "/" + a[5]);
                    var B = D.getYear() == a[3] && (D.getMonth() + 1) == a[4] && D.getDate() == a[5];
                }
                else {
                    var D = new Date(a[3] + "/" + a[4] + "/" + a[5]);
                    var B = D.getFullYear() == a[3] && (D.getMonth() + 1) == a[4] && D.getDate() == a[5];
                }
                if (!B) {
                    //alert("输入的身份证号 "+ a[0] +" 里出生日期不对。");
                    return false;
                }
            }
            if (!re.test(num)) {
                //alert("身份证最后一位只能是数字和字母。");
                return false;
            }
            return true;
        }

        // 车牌号校验
        function isPlateNo(plateNo) {
            var re = /^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/;
            if (re.test(plateNo)) {
                return true;
            }
            return false;
        }
    };

    return {
        initStartPageBlockUI: function() {
            handleStartPageBlockUI();
        },
        initStopPageBlockUI: function() {
            handleStopPageBlockUI();
        },
        initAlertsApi: function(message, type) {
            handleAlertsApi(message, type);
        },
        initBootBoxAlert: function(message) {
            return handleBootBoxAlert(message);
        },
        initBootBoxConfirm: function(message, href) {
            return handleBootBoxConfirm(message, href);
        },
        initBootBoxConfirmWithCallback: function(message, cancelCallback, successCallback) {
            return handleBootBoxConfirmWithCallback(message, cancelCallback, successCallback);
        },
        initGetDictLabel: function(data, value, defaultValue) {
            return handleGetDictLabel(data, value, defaultValue);
        },
        initGetQueryString: function (name, url) {
            return handleGetQueryString(name, url);
        },
        initCheckbox: function(tId) {
            handleCheckbox(tId);
        },
        initCheckboxValues: function(tId) {
            return handleCheckboxValues(tId);
        },
        initIsWeChat: function() {
            return handlerIsWeChat();
        },
        initJQueryValidateMethods: function () {
            handleJQueryValidateMethods();
        }
    };
}();

jQuery(document).ready(function() {
    Custom.initJQueryValidateMethods();
});