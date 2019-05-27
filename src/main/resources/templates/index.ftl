<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>代码生成平台</title>

<#import "common/common.macro.ftl" as netCommon>
<@netCommon.commonStyle />
    <link rel="stylesheet" href="${request.contextPath}/static/plugins/codemirror/lib/codemirror.css">
    <link rel="stylesheet" href="${request.contextPath}/static/plugins/codemirror/addon/hint/show-hint.css">
</head>
<body class="hold-transition skin-blue layout-top-nav ">
<div class="wrapper">
<@netCommon.commonHeader />
    <div class="content-wrapper">
        <div class="container">

            <section class="content">

                <div class="row">

                    <div class2="col-md-9">
                        <div class="row" id="step1">
                            <div class="box box-default">
                                <div class="box-header with-border">
                                    <h4 class="pull-left">mysql链接信息</h4>
                                </div>
                                <div class="box-body">
                                    <form class="form-horizontal">
                                        <div class="box-body">
                                            <div class="form-group">
                                                <label for="url" class="col-sm-2 control-label">url</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="url"
                                                           placeholder="jdbc:mysql://localhost:3306/school">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="dbName"
                                                       class="col-sm-2 control-label">dbName</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="dbName"
                                                           placeholder="dbName">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="username" class="col-sm-2 control-label">username</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="username"
                                                           placeholder="username">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="password"
                                                       class="col-sm-2 control-label">password</label>
                                                <div class="col-sm-10">
                                                    <input type="password" class="form-control" id="password"
                                                           placeholder="Password">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.box-body -->
                                        <div class="box-footer">
                                            <button type="button" id="step1NextBtn" class="btn btn-info ">
                                                下一步
                                            </button>
                                        </div>
                                        <!-- /.box-footer -->
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="step2">
                            <div class="box box-default">
                                <div class="box-header with-border">
                                    <h4 class="pull-left">项目信息</h4>
                                </div>
                                <div class="box-body">
                                    <form class="form-horizontal">
                                        <div class="box-body">

                                            <div class="form-group">
                                                <label for="packageName"
                                                       class="col-sm-2 control-label">包名</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="packageName"
                                                           placeholder="org.qvit">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="projectName" class="col-sm-2 control-label">项目名</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="projectName"
                                                           placeholder="example">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="projectDesc" class="col-sm-2 control-label">项目描述信息</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="projectDesc"
                                                           placeholder="描述信息">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.box-body -->
                                        <div class="box-footer">
                                            <button type="reset" class="btn btn-default" id="step2PrevBtn">返回</button>
                                            <button type="button" id="step2NextBtn" class="btn btn-info ">
                                                下一步
                                            </button>
                                        </div>
                                        <!-- /.box-footer -->
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="step3">
                            <div class="box box-default">
                                <div class="box-header with-border">
                                    <h4 class="pull-left">选择要生成的表</h4>
                                </div>
                                <div class="box-body" id="selectTable">
                                    <div class="row">
                                        <div class="col-md-2"><input type="checkbox" name="tables"/></div>
                                        <div class="col-md-10">.col-md-4</div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button type="reset" class="btn btn-default" id="step3PrevBtn">返回</button>
                                    <button type="button" id="step3NextBtn" class="btn btn-info ">
                                        下一步
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="step4">
                        <#-- 生成代码 -->
                            <div class="nav-tabs-custom" id="tabs_list">
                                <!-- Tabs within a box -->
                                <div>
                                    <h3>详情设置</h3>
                                </div>
                                <div style="width: 100%;">
                                    <ul class="nav nav-tabs pull-right">
                                    </ul>
                                </div>
                                <div style="width: 100%">
                                    <div id="formTemplate" style="display: none">
                                        <div class="chart tab-pane">
                                            <div class="box-body">
                                                <form class="form-horizontal">
                                                    <div class="box-body">
                                                        <div class="form-group table-edit">
                                                            <label for="inputEmail3"
                                                                   class="col-sm-2 control-label">表名：</label>
                                                            <div class="col-sm-10">
                                                                <input type="text" readonly class="form-control"
                                                                       name="tableName"
                                                                       placeholder="table">
                                                            </div>
                                                        </div>
                                                        <div class="form-group table-edit">
                                                            <label for="inputEmail3"
                                                                   class="col-sm-2 control-label">类名：</label>
                                                            <div class="col-sm-10">
                                                                <input type="text" class="form-control"
                                                                       placeholder="对应Java类名" name="name">
                                                            </div>
                                                        </div>
                                                        <div class="form-group table-edit">
                                                            <label for="inputEmail3"
                                                                   class="col-sm-2 control-label">包路径：</label>
                                                            <div class="col-sm-10">
                                                                <input type="text"
                                                                       class="form-control packagePath"
                                                                       value="org.qvit.report"
                                                                       placeholder="对应Java包名" name="packagePath">
                                                            </div>
                                                        </div>
                                                        <div class="form-group table-edit">
                                                            <label for="inputEmail3"
                                                                   class="col-sm-2 control-label">业务模块：</label>
                                                            <div class="col-sm-10">
                                                                <input type="text"
                                                                       class="form-control businessModule"
                                                                       placeholder="英文模块标识" name="businessModule">
                                                            </div>
                                                        </div>
                                                        <div class="form-group table-edit">
                                                            <label for="inputEmail3"
                                                                   class="col-sm-2 control-label">描述：</label>
                                                            <div class="col-sm-10">
                                                                <input type="text" class="form-control desc"
                                                                       placeholder="类的描述信息" name="desc">
                                                            </div>
                                                        </div>
                                                        <div class="colmunEdit">
                                                            <h4>相关字段：</h4>
                                                            <div class="col-sm-12" style="overflow-x:scroll">
                                                                <div>
                                                                    <table>
                                                                        <thead>
                                                                        <tr>
                                                                            <th>字段名</th>
                                                                            <th>变量名</th>
                                                                            <th>描述</th>
                                                                            <th>jdbc type</th>
                                                                            <th>java类型</th>
                                                                            <th>java类型全路径</th>
                                                                            <th>长度</th>
                                                                            <th>为空校验</th>
                                                                        </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                        <tr>
                                                                            <td><input type="text" class="form-control"
                                                                                       readonly name="columnName"/></td>
                                                                            <td><input type="text" class="form-control"
                                                                                       name="name"/></td>
                                                                            <td><input type="text" class="form-control"
                                                                                       name="desc"/></td>
                                                                            <td><input type="text" class="form-control"
                                                                                       name="type"/></td>
                                                                            <td><input type="text" class="form-control"
                                                                                       name="typeClassName"/></td>
                                                                            <td><input type="text" class="form-control"
                                                                                       name="javaType"/></td>
                                                                            <td><input type="text" class="form-control"
                                                                                       name="lenth"/></td>
                                                                            <td><input type="checkbox" name="allowNull"
                                                                                       value="true"/></td>
                                                                        </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-content no-padding">
                                    </div>
                                    <div class="box-footer">
                                        <button type="button" class="btn btn-default" id="step4PrevBtn">上一步</button>
                                        <button type="button" id="genCodeBtn" class="btn btn-info">生成代码</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </section>


        </div>
    </div>

    <!-- footer -->
<@netCommon.commonFooter />

</div>

<@netCommon.commonScript />
<script src="${request.contextPath}/static/plugins/codemirror/lib/codemirror.js"></script>
<script src="${request.contextPath}/static/plugins/codemirror/addon/hint/show-hint.js"></script>
<script src="${request.contextPath}/static/plugins/codemirror/addon/hint/anyword-hint.js"></script>

<script src="${request.contextPath}/static/plugins/codemirror/addon/display/placeholder.js"></script>

<script src="${request.contextPath}/static/plugins/codemirror/mode/clike/clike.js"></script>
<script src="${request.contextPath}/static/plugins/codemirror/mode/sql/sql.js"></script>
<script src="${request.contextPath}/static/plugins/codemirror/mode/xml/xml.js"></script>

<script src="${request.contextPath}/static/js/index.js"></script>

</body>
</html>
