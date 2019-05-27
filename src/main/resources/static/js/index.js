$(function () {
    /**
     * 获取表列表
     */
    var map = {};
    var $formTemplate = $("#formTemplate").children();
    var $list = $("#tabs_list");
    var $tabContent = $list.find(".tab-content");
    var $ui = $list.find("ul");
    var $selectTableList = $("#selectTable");
    var $step1 = $("#step1");
    var $step2 = $("#step2");
    var $step3 = $("#step3");
    var $step4 = $("#step4");
    $step1.show();
    $step2.hide();
    $step3.hide();
    $step4.hide();
    function genTable(value, index) {
        var $formTmp = $formTemplate.clone();
        if (index == 0) {
            $formTmp.addClass("active");
        }
        var $form = $formTmp.find("form");
        var $tbody = $form.find(".colmunEdit tbody");
        var $tr = $tbody.find("tr");
        $tbody.empty();
        $.each($form.find(".table-edit :input"), function (index, obj) {
            var $this = $(this);
            var name = $this.attr("name");
            if (value[name]) {
                $this.val(value[name])
            }
        });
        var columns = value.columnList || [];
        columns.forEach(function (columnData, index) {
            var $trTmp = $tr.clone();
            $.each($trTmp.find(":input"), function (index, obj) {
                var $this = $(this);
                var name = $this.attr("name");
                if (columnData[name]) {
                    $this.val(columnData[name])
                }
            });
            if (columnData["allowNull"]) {
                $trTmp.find(":checkbox").attr("checked", true);
            } else {
                $trTmp.find(":checkbox").attr("checked", false);
            }
            $tbody.append($trTmp);
        });
        $formTmp.attr("id", value.tableName);
        $tabContent.append($formTmp);
        $step3.hide();
        $step4.show();
    }

    $("#step1NextBtn").click(function () {
        $step1.hide();
        $step2.show();
    });
    $("#step2NextBtn").click(function () {
        var url = $("#url").val();
        var userName = $("#username").val();
        var password = $("#password").val();
        var dbName = $("#dbName").val();
        var packageName = $("#packageName").val();
        var projectName = $("#projectName").val();
        var projectDesc = $("#projectDesc").val();

        $.ajax({
            type: 'POST',
            url: base_url + "/tableList",
            data: {
                "url": url,
                "userName": userName,
                "password": password,
                "dbName": dbName,
                "packageName": packageName,
                "projectName": projectName,
                "projectDesc": projectDesc
            },
            dataType: "json",
            success: function (data) {
                if (data.code == 200) {
                    var dataList = data.data || [];
                    map = {};
                    $selectTableList.empty();
                    var package = packageName;
                    if (projectName) {
                        package = package + "." + projectName;
                    }
                    dataList.forEach(function (value, index) {
                        map[value.tableName] = value;
                        value.packagePath = package;
                        $selectTableList.append("<div class=\"row\" style='border-bottom: 1px solid #999'>"
                            + "<div class=\"col-md-1\" style='text-align: right'><input type=\"checkbox\" checked name=\"tables\" value='" + value.tableName + "'/></div>"
                            + "<div class=\"col-md-11\">" + value.tableName + "</div>"
                            + "</div>");
                    });
                    $step2.hide();
                    $step3.show();
                } else {
                    layer.open({
                        icon: '2',
                        content: (data.msg || '数据库链接失败')
                    });
                }
            },
            error: function () {
                layer.open({
                    icon: '2',
                    content: ('数据库链接失败，请检查配置！' + data.msg || '')
                });
            }
        });
    });
    $("#step2PrevBtn").click(function () {
        $step2.hide();
        $step1.show();
    });
    $("#step3PrevBtn").click(function () {
        $step3.hide();
        $step2.show();
    });
    $("#step3NextBtn").click(function () {
        console.error("click")
        var $checked = $selectTableList.find(":checked");
        if ($checked.length < 1) {
            layer.open({
                icon: '2',
                content: ("至少要选择一张表")
            });
            return false;
        }
        $tabContent.empty();
        $ui.find("a").parent().remove();
        $.each($checked, function (index) {
            var $this = $(this);
            var tableName = $this.val();
            var value = map[tableName];
            var active = "";
            if (index == 0) {
                active = "active";
            }
            var $li = $("<li class=\"" + active + "\" ><a href=\"#" + value.tableName + "\" data-toggle=\"tab\">" + value.tableName + "</a></li>");
            $ui.append($li);
            genTable(value, index)
        });
        console.error("success");

    });
    $("#step4PrevBtn").click(function () {
        $step4.hide();
        $step3.show();
    });

    $("#genCodeBtn").click(function () {
        console.error("click")
        var param = [];
        $.each($("form"), function () {
            var $this = $(this);
            var $tableEdit = $this.find(".table-edit");
            var tableName = $this.find(":text[name='tableName']").val();
            if (!tableName) {
                return;
            }
            var dataObj = map[tableName];
            $.each($tableEdit.find("input"), function () {
                var $element = $(this);
                var name = $element.attr("name");
                dataObj[name] = $.trim($element.val());
            });
            var columnObjs = dataObj.columnList || [];
            var clonumMap = {};
            columnObjs.forEach(function (obj) {
                clonumMap[obj.columnName] = obj;
            });
            var $colnumList = $this.find(".colmunEdit tbody tr");
            $.each($colnumList, function () {
                var $colnumTr = $(this);
                var columnName = $colnumTr.find(":text[name='columnName']").val();
                var colnumObj = clonumMap[columnName];
                $.each($colnumTr.find(":input"), function () {
                    var $input = $(this);
                    if ($input.attr("type") == 'checkbox') {
                        var name = $input.attr("name");
                        var value = $input.val();
                        colnumObj[name] = $input.prop("checked");
                    } else {
                        var name = $input.attr("name");
                        var value = $input.val();
                        colnumObj[name] = value;
                    }
                });

            })
        })
        var $checked = $selectTableList.find(":checked");
        if ($checked.length < 1) {
            layer.open({
                icon: '2',
                content: ("至少要选择一张表")
            });
            return false;
        }
        $tabContent.empty();
        $ui.find("a").parent().remove();
        $.each($checked, function (index) {
            var $this = $(this);
            var tableName = $this.val();
            param.push(map[tableName]);
        });
        var jdbcUrl = $("#url").val();
        var jdbcUserName = $("#username").val();
        var jdbcPassword = $("#password").val();
        var packageName = $("#packageName").val();
        var projectName = $("#projectName").val();
        var projectDesc = $("#projectDesc").val();
        //创建表单对象
        var _form = $("<form></form>", {
            'id': 'tempForm',
            'method': 'post',
            'action': "/codeGenerate",
            'target': "_blank",
            'style': 'display:none'
        }).appendTo($("body"));
        _form.append($("<input>", {'type': 'hidden', 'name': "data", 'value': JSON.stringify(param)}));
        _form.append($("<input>", {'type': 'hidden', 'name': "jdbcUrl", 'value': jdbcUrl}));
        _form.append($("<input>", {'type': 'hidden', 'name': "jdbcUsername", 'value': jdbcUserName}));
        _form.append($("<input>", {'type': 'hidden', 'name': "jdbcPassword", 'value': jdbcPassword}));
        _form.append($("<input>", {'type': 'hidden', 'name': "packageName", 'value': packageName}));
        _form.append($("<input>", {'type': 'hidden', 'name': "projectName", 'value': projectName}));
        _form.append($("<input>", {'type': 'hidden', 'name': "projectDesc", 'value': projectDesc}));
        _form.trigger("submit");
        _form.remove();
    });
})