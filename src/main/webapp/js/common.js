var messages = {
    "admin.message.success": "操作成功",
    "admin.message.error": "操作错误",
    "admin.dialog.ok": "确&nbsp;&nbsp;定",
    "admin.dialog.cancel": "取&nbsp;&nbsp;消",
    "admin.dialog.deleteConfirm": "您确定要删除吗？",
    "admin.dialog.clearConfirm": "您确定要清空吗？",
    "admin.browser.title": "选择文件",
    "admin.browser.upload": "本地上传",
    "admin.browser.parent": "上级目录",
    "admin.browser.orderType": "排序方式",
    "admin.browser.name": "名称",
    "admin.browser.size": "大小",
    "admin.browser.type": "类型",
    "admin.browser.select": "选择文件",
    "admin.upload.sizeInvalid": "上传文件大小超出限制",
    "admin.upload.typeInvalid": "上传文件格式不正确",
    "admin.upload.invalid": "上传文件格式或大小不正确",
    "admin.validate.required": "必填",
    "admin.validate.email": "E-mail格式错误",
    "admin.validate.url": "网址格式错误",
    "admin.validate.date": "日期格式错误",
    "admin.validate.dateISO": "日期格式错误",
    "admin.validate.pointcard": "信用卡格式错误",
    "admin.validate.number": "只允许输入数字",
    "admin.validate.digits": "只允许输入零或正整数",
    "admin.validate.minlength": "长度不允许小于{0}",
    "admin.validate.maxlength": "长度不允许大于{0}",
    "admin.validate.rangelength": "长度必须在{0}-{1}之间",
    "admin.validate.min": "不允许小于{0}",
    "admin.validate.max": "不允许大于{0}",
    "admin.validate.range": "必须在{0}-{1}之间",
    "admin.validate.accept": "输入后缀错误",
    "admin.validate.equalTo": "两次输入不一致",
    "admin.validate.remote": "输入错误",
    "admin.validate.integer": "只允许输入整数",
    "admin.validate.positive": "只允许输入正数",
    "admin.validate.negative": "只允许输入负数",
    "admin.validate.decimal": "数值超出了允许范围",
    "admin.validate.pattern": "格式错误",
    "admin.validate.extension": "文件格式错误"
};

function message(code) {
    if (code != null) {
        var content = messages[code] != null ? messages[code] : code;
        if (arguments.length == 1) {
            return content;
        } else {
            if ($.isArray(arguments[1])) {
                $.each(arguments[1], function (i, n) {
                    content = content.replace(new RegExp("\\{" + i + "\\}", "g"), n);
                });
                return content;
            } else {
                $.each(Array.prototype.slice.apply(arguments).slice(1), function (i, n) {
                    content = content.replace(new RegExp("\\{" + i + "\\}", "g"), n);
                });
                return content;
            }
        }
    }
}

// 添加Cookie
function addCookie(name, value, options) {
    if (arguments.length > 1 && name != null) {
        if (options == null) {
            options = {};
        }
        if (value == null) {
            options.expires = -1;
        }
        if (typeof options.expires == "number") {
            var time = options.expires;
            var expires = options.expires = new Date();
            expires.setTime(expires.getTime() + time * 1000);
        }
        document.cookie = encodeURIComponent(String(name)) + "=" + encodeURIComponent(String(value)) + (options.expires ? "; expires=" + options.expires.toUTCString() : "") + (options.path ? "; path=" + options.path : "") + (options.domain ? "; domain=" + options.domain : ""), (options.secure ? "; secure" : "");
    }
}

// 获取Cookie
function getCookie(name) {
    if (name != null) {
        var value = new RegExp("(?:^|; )" + encodeURIComponent(String(name)) + "=([^;]*)").exec(document.cookie);
        return value ? decodeURIComponent(value[1]) : null;
    }
}

// 移除Cookie
function removeCookie(name, options) {
    addCookie(name, null, options);
}

function showQueryDialog(options) {
    var opts = options || {};
    var dlg = $('#dlg-query');
    if (!dlg.length) {
        dlg = $('<div id="dlg-query"></div>').appendTo('body');
        dlg.dialog({
            top: 100,
            title: opts.title || advencedQuery,
            width: opts.width || 400,
            height: opts.height || 300,
            closed: true,
            modal: true,
            href: opts.form,
            buttons: [{
                text: query,
                iconCls: 'icon-search',
                handler: function () {
                    dlg.dialog('close');
                    var param = {};
                    dlg.find('input').each(function () {
                        var name = $(this).attr('name');
                        var val = $(this).val();
                        if ($(this).hasClass('datebox-f')) {
                            name = $(this).attr('comboname');
                            val = $(this).datebox('getValue');
                        } else if ($(this).hasClass('combogrid-f')) {
                            name = $(this).attr('comboname');
                            val = $(this).combogrid('getValue');
                        } else if ($(this).hasClass('combobox-f')) {
                            name = $(this).attr('comboname');
                            val = $(this).combobox('getValue');
                        } else if ($(this).hasClass('textbox-f')) {
                            name = $(this).attr("textboxname");
                            val = $(this).textbox('getValue');
                        }
                        param[name] = val;
                    });
                    opts.callback(param);
                }
            }, {
                text: cancel,
                iconCls: 'icon-cancel',
                handler: function () {
                    dlg.dialog('close');
                }
            }, {
                text: reset,
                iconCls: 'icon-reload',
                handler: function () {
                    dlg.find('input').each(function () {
                        $(this).val('');
                    });
                }
            }]
        });
    }
    dlg.dialog('open');
}
