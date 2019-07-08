<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
${r"<#"}import "common/common.macro.ftl" as netCommon>
${r"<@netCommon.commonStyle />"}
</head>
<body class="no-skin">
${r"<@netCommon.commonHeader />"}

<div class="main-container ace-save-state" id="main-container">
    <script type="text/javascript">
        try {
            ace.settings.loadState('main-container')
        } catch (e) {
        }
    </script>
${r"<@netCommon.commonMenu moduleList=["}"${classInfo.name}","${classInfo.businessModule}"]/>
    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="#">${classInfo.projectDesc}</a>
                    </li>

                    <li>
                        <a href="#">${classInfo.businessModuleDesc}</a>
                    </li>
                    <li class="active">${classInfo.desc}</li>
                </ul><!-- /.breadcrumb -->

                <div class="nav-search" id="nav-search">
                    <form class="form-search">
								<span class="input-icon">
									<input type="text" placeholder="Search ..." class="nav-search-input"
                                           id="nav-search-input" autocomplete="off"/>
									<i class="ace-icon fa fa-search nav-search-icon"></i>
								</span>
                    </form>
                </div><!-- /.nav-search -->
            </div>

            <div class="page-content">
                <div class="ace-settings-container" id="ace-settings-container">
                    <div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
                        <i class="ace-icon fa fa-cog bigger-130"></i>
                    </div>

                    <div class="ace-settings-box clearfix" id="ace-settings-box">
                        <div class="pull-left width-50">
                            <div class="ace-settings-item">
                                <div class="pull-left">
                                    <select id="skin-colorpicker" class="hide">
                                        <option data-skin="no-skin" value="#438EB9">#438EB9</option>
                                        <option data-skin="skin-1" value="#222A2D">#222A2D</option>
                                        <option data-skin="skin-2" value="#C6487E">#C6487E</option>
                                        <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
                                    </select>
                                </div>
                                <span>&nbsp; Choose Skin</span>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2 ace-save-state"
                                       id="ace-settings-navbar" autocomplete="off"/>
                                <label class="lbl" for="ace-settings-navbar"> Fixed Navbar</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2 ace-save-state"
                                       id="ace-settings-sidebar" autocomplete="off"/>
                                <label class="lbl" for="ace-settings-sidebar"> Fixed Sidebar</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2 ace-save-state"
                                       id="ace-settings-breadcrumbs" autocomplete="off"/>
                                <label class="lbl" for="ace-settings-breadcrumbs"> Fixed Breadcrumbs</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl"
                                       autocomplete="off"/>
                                <label class="lbl" for="ace-settings-rtl"> Right To Left (rtl)</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2 ace-save-state"
                                       id="ace-settings-add-container" autocomplete="off"/>
                                <label class="lbl" for="ace-settings-add-container">
                                    Inside
                                    <b>.container</b>
                                </label>
                            </div>
                        </div><!-- /.pull-left -->

                        <div class="pull-left width-50">
                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-hover"
                                       autocomplete="off"/>
                                <label class="lbl" for="ace-settings-hover"> Submenu on Hover</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-compact"
                                       autocomplete="off"/>
                                <label class="lbl" for="ace-settings-compact"> Compact Sidebar</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-highlight"
                                       autocomplete="off"/>
                                <label class="lbl" for="ace-settings-highlight"> Alt. Active Item</label>
                            </div>
                        </div><!-- /.pull-left -->
                    </div><!-- /.ace-settings-box -->
                </div><!-- /.ace-settings-container -->

                <div class="page-header">
                    <h1>
                    ${classInfo.desc}
                    </h1>
                </div><!-- /.page-header -->

                <div class="row">
                    <div class="col-xs-12">
                        <table id="grid-table"></table>
                        <div id="grid-pager"></div>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.page-content -->
        </div>
    </div><!-- /
${r"<@netCommon.commonFooter />"}
</div>
${r"<@netCommon.commonScript />"}
<!-- inline scripts related to this page -->
    <script type="text/javascript">

        jQuery(function ($) {
            var grid_selector = "#grid-table";
            var pager_selector = "#grid-pager";

            jQuery(grid_selector).jqGrid(
                    {
                        url: '${request.contextPath}/${classInfo.businessModule}/${classInfo.name?uncap_first}/pageList.do',
                        datatype: "json",
                        colNames: [<#list classInfo.columnList as fieldItem >'${fieldItem.desc}'<#if fieldItem_has_next>,</#if></#list>],
                        colModel: [
                            <#list classInfo.columnList as fieldItem >
                              {
                                name: '${fieldItem.desc}',
                                index: '${fieldItem.name}',
                                editable: '${!(classInfo.disableEdit || fieldItem.disableEdit || classInfo.primaryKey.name == fieldItem.name)}',
                                editoptions: {readonly: '${!(classInfo.disableEdit || fieldItem.disableEdit || classInfo.primaryKey.name == fieldItem.name)}', size: 10}
                              }
                              <#if fieldItem_has_next>,</#if>
                              </#list>
                        ],
                        rowNum: 10,
                        rowList: [10, 20, 30],
                        pager: pager_selector,
                        sortname: '${classInfo.primaryKey.name }',
                        viewrecords: true,
                        sortorder: "desc",
                        caption: "${classInfo.desc }",
                        editurl: "${request.contextPath}/${classInfo.businessModule}/${classInfo.name?uncap_first}/save.do"
                    });
            jQuery(grid_selector).jqGrid('navGrid', pager_selector, {edit : true,add : true,del : true});
        });
    </script>
</body>
</html>
