${r"<#macro commonStyle>"}
<link rel="Bookmark" href="favicon.ico" >
<link rel="Shortcut Icon" href="favicon.ico" />
<!--[if lt IE 9]>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/lib/html5.js"></script>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="${r"${request.contextPath}"}/statics/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${r"${request.contextPath}"}/statics/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${r"${request.contextPath}"}/statics/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${r"${request.contextPath}"}/statics/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${r"${request.contextPath}"}/statics/h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css" href="${r"${request.contextPath}"}/statics/lib/layui/css/layui.css" />
<link rel="stylesheet" type="text/css" href="${r"${request.contextPath}"}/statics/lib/datatables/css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="${r"${request.contextPath}"}/statics/css/global.css" />
<!--[if IE 6]>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script><![endif]-->
${r"</#macro>"}

${r"<#macro commonScript>"}
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/lib/layui/layui.all.js"></script>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/lib/date.js"></script>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/h-ui.admin/js/H-ui.admin.page.js"></script>
<!--/_footer /作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/lib/datatables/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/lib/jquery.dateFormat.js"></script>
<script type="text/javascript" src="${r"${request.contextPath}"}/statics/lib/common.js"></script>


${r"</#macro>"}
${r"<#macro commonHeader>"}
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl"> <a class="logo navbar-logo f-l mr-10 hidden-xs" href="/aboutHui.shtml">H-ui.admin</a> <a class="logo navbar-logo-m f-l mr-10 visible-xs" href="/aboutHui.shtml">H-ui</a> <span class="logo navbar-slogan f-l mr-10 hidden-xs">v3.0</span> <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
            <nav class="nav navbar-nav">
                <ul class="cl">
                    <li class="dropDown dropDown_hover"><a href="javascript:;" class="dropDown_A"><i class="Hui-iconfont">&#xe600;</i> 新增 <i class="Hui-iconfont">&#xe6d5;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" onclick="article_add('添加资讯','article-add.html')"><i class="Hui-iconfont">&#xe616;</i> 资讯</a></li>
                            <li><a href="javascript:;" onclick="picture_add('添加资讯','picture-add.html')"><i class="Hui-iconfont">&#xe613;</i> 图片</a></li>
                            <li><a href="javascript:;" onclick="product_add('添加资讯','product-add.html')"><i class="Hui-iconfont">&#xe620;</i> 产品</a></li>
                            <li><a href="javascript:;" onclick="member_add('添加用户','member-add.html','','510')"><i class="Hui-iconfont">&#xe60d;</i> 用户</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                <ul class="cl">
                    <li>超级管理员</li>
                    <li class="dropDown dropDown_hover"> <a href="#" class="dropDown_A">admin <i class="Hui-iconfont">&#xe6d5;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" onClick="myselfinfo()">个人信息</a></li>
                            <li><a href="#">切换账户</a></li>
                            <li><a href="#">退出</a></li>
                        </ul>
                    </li>
                    <li id="Hui-msg"> <a href="#" title="消息"><span class="badge badge-danger">1</span><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> </li>
                    <li id="Hui-skin" class="dropDown right dropDown_hover"> <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                            <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                            <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                            <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                            <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                            <li><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>
${r"</#macro>"}
${r"<#macro commonMenu moduleList>"}
<aside class="Hui-aside">
    <div class="menu_dropdown bk_2">
    <#list maps?keys as key>
        <dl id="menu-product">
            <dt ${r"${moduleList?seq_contains("}"${key}")?string('class="selected"','')}><i class="Hui-iconfont">&#xe620;</i>&nbsp;&nbsp;${maps["${key}"][0].businessModuleDesc}<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd ${r"${moduleList?seq_contains("}"${key}")?string('style="display: block;"','')}>
                <ul>
                    <#list maps["${key}"] as child>
                        <li ${r"${moduleList?seq_contains("}"${child.name}")?string('class="current"','')}><a href="<#if (child.businessModule)?? && child.businessModule gt 0>/${child.businessModule}</#if>/${child.name?uncap_first}/list.do" title="${child.desc}">${child.desc}</a></li>
                    </#list>
                </ul>
            </dd>
        </dl>
    </#list>
    </div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
${r"</#macro>"}
${r"<#macro commonFooter >"}
<div class="footer">
    <div class="footer-inner">
        <div class="footer-content">
						<span class="bigger-120">
							<span class="blue bolder">Ace</span>
							Application &copy; 2013-2014
						</span>

            &nbsp; &nbsp;
            <span class="action-buttons">
							<a href="#">
								<i class="ace-icon fa fa-twitter-square light-blue bigger-150"></i>
							</a>

							<a href="#">
								<i class="ace-icon fa fa-facebook-square text-primary bigger-150"></i>
							</a>

							<a href="#">
								<i class="ace-icon fa fa-rss-square orange bigger-150"></i>
							</a>
						</span>
        </div>
    </div>
</div>
<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
    <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
</a>
${r"</#macro>"}