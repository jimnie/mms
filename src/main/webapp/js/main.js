$(function () {

    initNavBar();
    tabDoubleClickEvent();
    tabRightClickEvent();

    $('#css3menu a').click(function () {
        $('#css3menu a').removeClass('active');
        $(this).addClass('active');
        var modules = modsJson[$(this).attr('name')];
        clearModules();
        addModules(modules);
        addMenus();
    });

    $.extend($.fn.validatebox.defaults.rules, {
        equalTo: {
            validator: function (value, param) {
                return $(param[0]).val() == value;
            },
            message: '字段不匹配'
        }
    });

    // 导航菜单绑定初始化
    var firstMenuName = $('#css3menu a:first').attr('name');
    addModules(modsJson[firstMenuName]); //首次加载basic 左侧菜单
    addMenus();
    showTime();
});

function clearModules() {
    var panels = $('#nav').accordion('panels');
    if (panels) {
        var len = panels.length;
        $.each(panels, function (i, n) {
            $('#nav').accordion('remove', len - i - 1);
        });
    }
}

function getMenuList(data, menulist) {
    if (data.menus == null)
        return menulist;
    else {
        menulist += '<ul>';
        $.each(data.menus, function (i, sm) {
            if (sm.url != null) {
                menulist += '<li><div><a ref="' + sm.menuid + '" href="javascript:void(0)" rel="' + base + sm.url + '"><span class="icon ' + sm.icon + '"' + '>&nbsp;</span><span class="nav">' + sm.menuname + '</span></a>';
            }
            else {
                menulist += '<li state="closed"><span class="nav">' + sm.menuname + '</span>'
            }
            menulist = getMenuList(sm, menulist);
        })
        menulist += '</ul>';
    }
    return menulist;
}
//左侧导航加载
function addModules(data) {
    $.each(data, function (i, sm) {
        var menulist = "";
        //sm 常用菜单  邮件列表
        menulist = getMenuList(sm, menulist);
        $('#nav').accordion('add', {
            title: sm.menuname,
            content: menulist,
            iconCls: 'icon ' + sm.icon,
            animate: true
        });
    });

    var panels = $('#nav').accordion('panels');
    if (panels) {
        var title = panels[0].panel('options').title;
        $('#nav').accordion('select', title);
    }
}

// 初始化左侧
function addMenus() {
    $('#nav li a').click(function () {
        var tabTitle = $(this).children('.nav').text();
        var ref = $(this).attr("ref");
        var url = $(this).attr("rel");
        var menuid = $(this).attr("ref");
        //var icon = 'icon icon-nav';
        var icon = getIcon(menuid);
        addTab(tabTitle, url, icon);
        $('#nav li div').removeClass("selected");
        $(this).parent().addClass("selected");
    }).hover(function () {
        $(this).parent().addClass("hover");
    }, function () {
        $(this).parent().removeClass("hover");
    });
}

// 获取左侧导航的菜单图标
function getIcon(menuid) {
    var icon = 'icon ';
    $.each(modsJson, function (i, n) {
        $.each(n, function (j, o) {
            $.each(o.menus, function (k, m) {
                if (m.menuid == menuid) {
                    icon += m.icon;
                    return icon;
                }
            });
        });
    });
    return icon;
}

function addTab(subtitle, url, icon) {
    if (!$('#tabs').tabs('exists', subtitle)) {
        $('#tabs').tabs('add', {
            title: subtitle,
            content: createFrame(url),
            closable: true,
            icon: icon
        });
    } else {
        $('#tabs').tabs('select', subtitle);
        $('#mm-tabupdate').click();
    }
    tabDoubleClickEvent();
}

function createFrame(url) {
    var s = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>';
    return s;
}

function tabDoubleClickEvent() {
    /* 双击关闭TAB选项卡 */
    $('.tabs-inner').dblclick(function () {
        var subtitle = $(this).children('.tabs-closable').text();
        $('#tabs').tabs('close', subtitle);
    });
    /* 为选项卡绑定右键 */
    $('.tabs-inner').bind('contextmenu', function (e) {
        $('#rightMenu').menu('show', {
            left: e.pageX,
            top: e.pageY
        });

        var subtitle = $(this).children('.tabs-closable').text();

        $('#rightMenu').data('currtab', subtitle);
        $('#tabs').tabs('select', subtitle);
        return false;
    });
}
// 绑定右键菜单事件
function tabRightClickEvent() {
    //刷新
    $('#tabRefresh').click(function () {
        var currTab = $('#tabs').tabs('getSelected');
        var url = $(currTab.panel('options').content).attr('src');
        $('#tabs').tabs('update', {
            tab: currTab,
            options: {
                content: createFrame(url)
            }
        })
    })
    //关闭当前
    $('#tabClose').click(function () {
        var currtab_title = $('#rightMenu').data('currtab');
        $('#tabs').tabs('close', currtab_title);
    })
    //全部关闭
    $('#tabCloseAll').click(function () {
        $('.tabs-inner span').each(function (i, n) {
            var t = $(n).text();
            $('#tabs').tabs('close', t);
        });
    });
    //关闭除当前之外的TAB
    $('#tabCloseOther').click(function () {
        $('#mm-tabcloseright').click();
        $('#mm-tabcloseleft').click();
    });
    //关闭当前右侧的TAB
    $('#tabCloseRight').click(function () {
        var nextall = $('.tabs-selected').nextAll();
        if (nextall.length == 0) {
            return false;
        }
        nextall.each(function (i, n) {
            var t = $('a:eq(0) span', $(n)).text();
            $('#tabs').tabs('close', t);
        });
        return false;
    });
    //关闭当前左侧的TAB
    $('#tabCloseLeft').click(function () {
        var prevall = $('.tabs-selected').prevAll();
        if (prevall.length == 0) {
            return false;
        }
        prevall.each(function (i, n) {
            var t = $('a:eq(0) span', $(n)).text();
            $('#tabs').tabs('close', t);
        });
        return false;
    });

    //退出
    $('#tabExit').click(function () {
        $('#rightMenu').menu('hide');
    })
}

// 弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
function msgShow(title, msgString, msgType) {
    $.messager.alert(title, msgString, msgType);
}

// 本地时钟
function showTime() {
    var now = new Date();
    var year = now.getFullYear(); // getFullYear getYear
    var month = now.getMonth() + 1;
    var date = now.getDate();
    var day = now.getDay();
    var hour = now.getHours();
    var minu = now.getMinutes();
    var sec = now.getSeconds();
    var dayOfWeek;
    var time;
    if (month < 10) month = "0" + month;
    if (date < 10) date = "0" + date;
    if (hour < 10) hour = "0" + hour;
    if (minu < 10) minu = "0" + minu;
    if (sec < 10) sec = "0" + sec;
    var weekArrays = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
    dayOfWeek = weekArrays[day];
    time = year + "年" + month + "月" + date + "日" + " " + hour + ":" + minu
        + ":" + sec + " " + dayOfWeek;
    $('#bgclock').html(time);
    window.setTimeout('showTime()', 1000);
}

function initNavBar() {
    var len = navsJson.navs.length;
    var navs = navsJson.navs;
    if (len > 0) {
        for (var i = 0; i < len; i++) {
            var elem;
            if (navs[i].classname) {
                elem = '<li><a name="' + navs[i].name + '" class="' + navs[i].classname + '" href="javascript:void(0);" title="' + navs[i].title + '">' + navs[i].title + '</a></li>';
            } else {
                elem = '<li><a name="' + navs[i].name + '" href="javascript:void(0);" title="' + navs[i].title + '">' + navs[i].title + '</a></li>';
            }
            $('#css3menu').append(elem);
        }
    }
}

/************************************************************************Index页面********************************************************/
//设置登录窗口
function openPasswordChangingDialog() {
    $('#modifyPassword').window({
        title: '修改密码',
        width: 300,
        modal: true,
        shadow: true,
        closed: true,
        height: 160,
        resizable: false
    });
}
//关闭登录窗口
function closePwd() {
    $('#modifyPassword').window('close');
}


//修改密码
function serverLogin() {
    var $newpass = $('#inputNewPwd');
    var $rePass = $('#reNewPwd');

    if ($newpass.val() == '') {
        msgShow('系统提示', '请输入密码！', 'warning');
        return false;
    }
    if ($rePass.val() == '') {
        msgShow('系统提示', '请在一次输入密码！', 'warning');
        return false;
    }

    if ($newpass.val() != $rePass.val()) {
        msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
        return false;
    }

    $.post('/ajax/editpassword.ashx?newpass=' + $newpass.val(), function (msg) {
        msgShow('系统提示', '恭喜，密码修改成功！<br>您的新密码为：' + msg, 'info');
        $newpass.val('');
        $rePass.val('');
        close();
    })

}
$(function () {
    openPasswordChangingDialog();

    $('#editPwd').click(function () {
        $('#modifyPassword').window('open');
    });

    $('#btnOk').click(function () {
        serverLogin();
    })

    $('#btnCancel').click(function () {
        closePwd();
    })

    $('#loginOut').click(function () {
        $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function (r) {
            if (r) {
                location.href = base + "/logout.jsp";
            }
        });
    })
    $('#perCenter').click(function () {
        $('#perForm').form('load', '/cwma/employee/getEmp');
        $('#perWin').window('open');
    });
    $('#editPer').click(function () {
        $('#perForm').form('submit', {
            url: '/cwma/employee/employeeUpdate',
            success: function (data) {
                data = eval('(' + data + ')');
                if (data.type == 'success') {
                    $('#perWin').window('close');
                    $.messager.alert('操作提示', '修改成功', 'info');
                } else {
                    $.messager.alert('操作提示', data.content, 'error');
                }
            }
        });
    });
    $('#closePer').click(function () {
        $('#perWin').window('close');
    });
    /*居住地址级联菜单*/
    /*省份*/
    $('#nowProvince').combobox({
        url: "/cwma/area/province",
        editable: false,
        method: 'get',
        valueField: 'areaName',
        textField: 'areaName',
        onSelect: function (record) {
            var areaName = $('#nowProvince').combobox('getValue');
            $('#nowCity').combobox('reload', base + '/area/getChildrenbyName/' + areaName);
        }
    });
    /*城市*/
    $('#nowCity').combobox({
        editable: false,
        method: 'get',
        valueField: 'areaName',
        textField: 'areaName',
        onSelect: function (record) {
            var areaName = $('#nowCity').combobox('getValue');
            $('#nowCounty').combobox('reload', base + '/area/getChildrenbyName/' + areaName);
        }
    });
    /*区县*/
    $('#nowCounty').combobox({
        editable: false,
        method: 'get',
        valueField: 'areaName',
        textField: 'areaName'
    });
});

/*************************************************************************************************************************************/