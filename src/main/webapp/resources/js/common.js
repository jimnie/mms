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
