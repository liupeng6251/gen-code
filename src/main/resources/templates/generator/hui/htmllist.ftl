<!--_meta 作为公共模版分离出去-->
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8"/>
<#if (classInfo.businessModule)?? && classInfo.businessModule gt 0>
    ${r"<#"}import "../common/common.macro.ftl" as netCommon>
<#else>
    ${r"<#"}import "common/common.macro.ftl" as netCommon>
</#if>
${r"<@netCommon.commonStyle />"}
    <title>${classInfo.desc}</title>
</head>
<body>
${r"<@netCommon.commonHeader />"}
${r"<@netCommon.commonMenu moduleList=["}"${classInfo.name}","${classInfo.businessModule}"]/>
<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span
            class="c-gray en">&gt;</span> ${classInfo.businessModuleDesc} <span
            class="c-gray en">&gt;</span> ${classInfo.desc}<a class="btn btn-success radius r"
                                                              style="line-height:1.6em;margin-top:3px"
                                                              href="javascript:location.replace(location.href);"
                                                              title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="Hui-article">
        <article class="cl pd-20">
            <div class="text-c">
                <#list classInfo.columnList as fieldItem >
                    <input type="text" class="input-text radius" style="width:250px" placeholder="输${fieldItem.desc}"
                           id="${fieldItem.name}Input" name="${fieldItem.name}">
                </#list>
                <button type="button" class="btn btn-success radius" onclick="searchData()" name=""><i
                        class="Hui-iconfont">&#xe665;</i> 搜索
                </button>
            </div>
            <div class="cl pd-5 bg-1 bk-gray mt-20">
                <button type="button" id="addDataBtn" class="layui-btn layui-btn-normal">新增</button>
                <button type="button" id="editDataBtn" class="layui-btn">编辑</button>
                <button type="button" id="deleteDataBtn" class="layui-btn layui-btn-danger">删除</button>
                <button type="button" class="layui-btn layui-btn-normal">批量导入</button>
                <button type="button" class="layui-btn layui-btn-normal">模板下载</button>
                <button type="button" class="layui-btn layui-btn-normal">批量导出</button>
            </div>
            <div
            ">
            <table id="example" class="layui-table">
                <thead>
                <tr class="text-c">
                    <#list classInfo.columnList as fieldItem >
                        <th>${fieldItem.desc}</th>
                    </#list>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
    </div>
    </article>
    </div>
</section>
<!--_footer 作为公共模版分离出去-->
${r"<@netCommon.commonFooter />"}
${r"<@netCommon.commonScript />"}
<div id="modal-add">
    <form class="layui-form" action="" id="${classInfo.name}Form">
    <#list classInfo.columnList as fieldItem >
        <#if fieldItem.autoIncrement>
            <input type="hidden" id="${fieldItem.name}Add" name="${fieldItem.name}">
        <#else>
        <div class="layui-form-item">
            <label class="layui-form-label">${fieldItem.desc}</label>
            <div class="layui-input-block">
                <#if fieldItem.typeClassName == 'Date'>
                    <input type="text" id="${fieldItem.name}Add" name="${fieldItem.name}" required lay-verify="required"
                           placeholder="请输入${fieldItem.desc}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                           autocomplete="off" class="layui-input">
                </#if>
                <#if fieldItem.typeClassName == 'String'>
                    <#if fieldItem.lenth gt 1000 >
                        <textarea name="desc" id="${fieldItem.name}Add" name="${fieldItem.name}" placeholder="请输入内容"
                                  class="layui-textarea"></textarea>
                    <#else>
                        <input type="text" id="${fieldItem.name}Add" name="${fieldItem.name}" lay-verify="required"
                               placeholder="请输入${fieldItem.desc}" autocomplete="off" class="layui-input">
                    </#if>
                </#if>
                <#if fieldItem.typeClassName == 'Integer' ||  fieldItem.typeClassName == 'Long'>
                    <input type="text" id="${fieldItem.name}Add" name="${fieldItem.name}" lay-verify="number"
                           placeholder="请输入${fieldItem.desc}" autocomplete="off" class="layui-input">
                </#if>
                <#if fieldItem.typeClassName == 'Boolean'>
                    <input type="checkbox" id="${fieldItem.name}Add" name="${fieldItem.name}" lay-skin="switch"
                           lay-text="ON|OFF" lay-filter="switchTest" value="true">
                </#if>
            </div>
        </div>
        </#if>
    </#list>
    </form>
</div>
<script type="text/javascript">
    var $table;
    var form = layui.form;
    var laypage = layui.laypage;
    var layer = layui.layer;
    $(function () {
        //取子页面的form
        $table = $('#example').DataTable({
            "ajax": {
                "url": '<#if (classInfo.businessModule)?? && classInfo.businessModule gt 0>/${classInfo.businessModule}</#if>/${classInfo.name?uncap_first}/pageList.do',
                "type": "POST",
                "contentType": "application/json",
                "dataType": 'json',
                "data": function (obj) {
                <#list classInfo.columnList as fieldItem >
                   var ${fieldItem.name} =
                    $.trim($('#${fieldItem.name}Input').val());
                   if (${fieldItem.name}) {
                    <#if fieldItem.typeClassName == 'Date'>
                       obg.${fieldItem.name} = Date.parse(${fieldItem.name});
                    <#else>
                        obg.${fieldItem.name} = ${fieldItem.name};
                    </#if>
                   }
                </#list>
                    return JSON.stringify(obj)
                },
            },
            "dom": '<"top">tirlp<"bottom"><"clear">',
            "processing": true,
            "serverSide": true,
            "retrieve": true,
            "ordering": false,
            "sScrollX": true,
            "bAutoWidth": true,
            "jQueryUI": false,
            "columns": [
            <#list classInfo.columnList as fieldItem >
                <#if fieldItem.typeClassName == 'Date'>
                    {
                        data: '${fieldItem.name}',
                        "render": function (data, type, row, meta) {
                            return data ? $.format.date(data, "yyyy-MM-dd HH:mm:ss") : '';
                        }
                    }<#if fieldItem_has_next>,</#if>
                <#else>
                  {data: '${fieldItem.name}',}<#if fieldItem_has_next>,</#if>
                </#if>
            </#list>],
            searchDelay: 350,
            language: {
                "sProcessing": "处理中...",
                "sLengthMenu": "显示 _MENU_ 项结果",
                "sZeroRecords": "没有匹配结果",
                "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
                "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
                "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
                "sInfoPostFix": "",
                "sSearch": "搜索:",
                "sUrl": "",
                "sEmptyTable": "表中数据为空",
                "sLoadingRecords": "载入中...",
                "sInfoThousands": ",",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "上页",
                    "sNext": "下页",
                    "sLast": "末页"
                },
                "oAria": {
                    "sSortAscending": ": 以升序排列此列",
                    "sSortDescending": ": 以降序排列此列"
                }
            }
        });
        $('#example tbody').on('click', 'tr', function () {
            if ($(this).hasClass('selected')) {
                $(this).removeClass('selected');
            } else {
                $table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
        });
        $('#editDataBtn').click(function () {
            $table.row('.selected').remove().draw(false);
        });
        $('#deleteDataBtn').click(function () {
            var  ${classInfo.primaryKey.name}=$table.row('.selected').data(). ${classInfo.primaryKey.name};
            $.ajax({
                type: "GET",
                dataType: "json",
                url: "<#if (classInfo.businessModule)?? && classInfo.businessModule gt 0>/${classInfo.businessModule}</#if>/${classInfo.name?uncap_first}/delete.do?${classInfo.primaryKey.name}=" +${classInfo.primaryKey.name},
                success: function (result) {
                    if (result.status == 0) {
                        layer.msg('保存成功！');
                        $table.ajax.reload();
                        layer.closeAll();
                    } else {
                        layer.msg(result.errMsg);
                    }

                },
                error: function () {
                    alert("异常！");
                }
            });
        });
        $("#addDataBtn").click(function () {
            layer.open({
                type: 1,
                title: "新增${classInfo.desc}",
                btn: ['确定', '取消'],
                content: $("#modal-add"),
                area: ['600px', '500px'],
                btnAlign: 'c',
                yes: function (obj, index) {
                    var formArray = $('${r'#'}${classInfo.name}Form').serializeArray();
                    var data = {};
                    for (var i in formArray) {
                        data[formArray[i].name] = formArray[i]['value'];
                    }
               <#list classInfo.columnList as fieldItem >
                   <#if fieldItem.typeClassName == 'Date'>
                   if (data.${fieldItem.name}) {
                       data.${fieldItem.name} = Date.parse(data.${fieldItem.name});
                   }
                   </#if>
               </#list>
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: 'application/json',
                        url: "<#if (classInfo.businessModule)?? && classInfo.businessModule gt 0>/${classInfo.businessModule}</#if>/${classInfo.name?uncap_first}/save.do",
                        data: JSON.stringify(data),
                        success: function (result) {
                            if (result.status == 0) {
                                layer.msg('保存成功！');
                                $table.ajax.reload();
                                layer.closeAll();
                            } else {
                                layer.msg(result.errMsg);
                            }

                        },
                        error: function () {
                            alert("异常！");
                        }
                    });
                },
                cancel: function (index) {
                    layer.close(index);
                }
            });
        })
    });

    /*用户-还原*/
    function member_huanyuan(obj, id) {
        layer.confirm('确认要还原吗？', function (index) {
            $(obj).remove();
            layer.msg('已还原!', {icon: 6, time: 1000});
        });
    }

    /*用户-删除*/
    function member_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            $(obj).parents("tr").remove();
            layer.msg('已删除!', {icon: 1, time: 1000});
        });
    }

    function searchData() {
        $table.ajax.reload();
    }

    layui.use('form', function () {
        form.render();
        form.on('extendsAuth(switchTest)', function (data) {
            layer.tips('开关checked：' + (this.checked ? 'true' : 'false'), data.othis)
        });
        //监听提交
        form.on('submit(formDemo)', function (data) {
            layer.msg(JSON.stringify(data.field));
            return false;
        });
    });

</script>

<!--/请在上方写此页面业务相关的脚本-->
</body>

</html>