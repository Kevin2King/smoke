<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="navItemName" type="java.lang.String" required="false" description="导航项名称" %>
<%@ attribute name="subMenuName" type="java.lang.String" required="false" description="子菜单名称" %>

<div class="page-sidebar-wrapper">
    <div class="page-sidebar navbar-collapse collapse">
        <ul class="page-sidebar-menu  page-header-fixed " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
            <li class="sidebar-toggler-wrapper hide">
                <div class="sidebar-toggler"> </div>
            </li>
            <style>
                span.arrownew:before{
                    color: #fff !important;
                }
            </style>
            <c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
                <c:if test="${menu.parent.id eq '1' && menu.isShow eq '1'}">
                    <li class="nav-item second-menu-king ${menu.name eq navItemName ? 'start active open' : ''}">
                        <c:if test="${empty menu.href}">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="${menu.icon} " ></i>
                                <span class="title">
                                    ${menu.name}
                                </span>
                                <c:choose>
                                    <c:when test="${menu.name eq navItemName}">
                                        <span class="selected"></span>
                                        <span class="arrow open"></span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="arrow"></span>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </c:if>
                        <ul class="sub-menu" >
                            <c:forEach items="${fns:getMenuList()}" var="menuItem" varStatus="idxItemStatus">
                                <c:if test="${menuItem.parent.id eq menu.id && menuItem.isShow eq '1'}">
                                    <li class="nav-item ${menuItem.name eq subMenuName ? 'start active open' : ''}">
                                        <a href="${fn:indexOf(menuItem.href, '://') eq -1 ? ctx : ''}${menuItem.href}" target="${menuItem.target}" class="nav-link">
                                            <i class="${menuItem.icon}"></i>
                                            <span class="title">${menuItem.name}</span>
                                            <c:if test="${(menuItem.name eq '检查更新')}">
                                                <span style="display: ${fns:isNewestVersion()?'none':'inline-block'};" class="badge badge-success bg-red">1</span>
                                            </c:if>
                                            <c:if test="${menuItem.name eq subMenuName}">
                                                <span class="selected"></span>
                                            </c:if>
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        var haveSelected = false;
        var isFirst = false;
        $('ul.page-sidebar-menu li.second-menu-king').each(function (i) {
            var hasClass = $(this).hasClass('open');
            if (hasClass == true) {
                if (i == 0) isFirst = true;
                haveSelected = true;
                return haveSelected;
            }
        });
        if (haveSelected == true) {
            if(isFirst == true) return;
            $('ul.page-sidebar-menu li.second-menu-king').eq(0).removeClass('start active open');
        } else {
            $('ul.page-sidebar-menu li.second-menu-king').eq(0).addClass('start active open');
        }
    });
</script>
