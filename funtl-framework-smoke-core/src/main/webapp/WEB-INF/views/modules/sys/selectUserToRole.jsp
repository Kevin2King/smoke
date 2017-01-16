<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
    <h4 class="modal-title">分配角色</h4>
</div>
<div class="modal-body">
    <div class="row">
        <div class="col-md-4">
            <div class="portlet box green">
                <div class="portlet-title">
                    <div class="caption">所在部门 </div>
                </div>
                <div class="portlet-body">
                    <div id="officeTree" class="ztree"></div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="portlet box green">
                <div class="portlet-title">
                    <div class="caption">待选人员</div>
                </div>
                <div class="portlet-body">
                    <div id="userTree" class="ztree"></div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="portlet box green">
                <div class="portlet-title">
                    <div class="caption">已选人员</div>
                </div>
                <div class="portlet-body">
                    <div id="selectedTree" class="ztree"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <small class="pull-left">通过选择部门，然后为列出的人员分配角色</small>
    <button type="button" class="btn default" data-dismiss="modal">取消</button>
    <button id="roleButtonClear" type="button" class="btn green">清除已选</button>
    <button id="roleButton" type="button" class="btn blue" data-dismiss="modal">确定分配</button>
</div>

<script type="text/javascript">
    $(function(){
        $("#ajax").find(".modal-dialog").attr("style", "width:1024px;");
    });

    var officeTree;
    var selectedTree;//zTree已选择对象

    var setting = {
        view: {selectedMulti: false, nameIsHTML: true, showTitle: false, dblClickExpand: false},
        data: {simpleData: {enable: true}},
        callback: {onClick: treeOnClick}
    };

    var officeNodes = [
        <c:forEach items="${officeList}" var="office">
        {
            id: "${office.id}",
            pId: "${not empty office.parent?office.parent.id:0}",
            name: "${office.name}"
        },
        </c:forEach>
    ];

    var pre_selectedNodes = [
        <c:forEach items="${userList}" var="user">
        {
            id: "${user.id}",
            pId: "0",
            name: "<font color='red' style='font-weight:bold;'>${user.name}</font>"
        },
        </c:forEach>
    ];

    var selectedNodes = [
        <c:forEach items="${userList}" var="user">
        {
            id: "${user.id}",
            pId: "0",
            name: "<font color='red' style='font-weight:bold;'>${user.name}</font>"
        },
        </c:forEach>
    ];

    var pre_ids = "${selectIds}".split(",");
    var ids = "${selectIds}".split(",");

    // 点击选择项回调
    function treeOnClick(event, treeId, treeNode) {
        $.fn.zTree.getZTreeObj(treeId).expandNode(treeNode);
        if ("officeTree" == treeId) {
            $.get("${ctx}/sys/role/users?officeId=" + treeNode.id, function (userNodes) {
                $.fn.zTree.init($("#userTree"), setting, userNodes);
            });
        }
        if ("userTree" == treeId) {
            if ($.inArray(String(treeNode.id), ids) < 0) {
                selectedTree.addNodes(null, treeNode);
                ids.push(String(treeNode.id));
            }
        }
        if ("selectedTree" == treeId) {
            if ($.inArray(String(treeNode.id), pre_ids) < 0) {
                selectedTree.removeNode(treeNode);
                ids.splice($.inArray(String(treeNode.id), ids), 1);
            } else {
                alert('角色原有成员不能清除！');
            }
        }
    }

    function clearAssign() {
        if (confirm('确定清除角色【${role.name}】下的已选人员？')) {
            var tips = "";
            if (pre_ids.sort().toString() == ids.sort().toString()) {
                tips = "未给角色【${role.name}】分配新成员！";
            } else {
                tips = "已选人员清除成功！";
            }
            ids = pre_ids.slice(0);
            selectedNodes = pre_selectedNodes;
            $.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
            alert(tips);
        } else {
            alert('取消清除操作！');
        }
    }

    officeTree = $.fn.zTree.init($("#officeTree"), setting, officeNodes);
    selectedTree = $.fn.zTree.init($("#selectedTree"), setting, selectedNodes);

    // 保存
    $('#roleButton').click(function() {
        // 删除''的元素
        if (ids[0] == '') {
            ids.shift();
            pre_ids.shift();
        }

        if(pre_ids.sort().toString() == ids.sort().toString()){
            alert('未给角色【${role.name}】分配新成员！');
            return false;
        }

        // 执行保存
        Custom.initStartPageBlockUI();
        var idsArr = "";
        for (var i = 0; i < ids.length; i++) {
            idsArr = (idsArr + ids[i]) + (((i + 1) == ids.length) ? '' : ',');
        }
        $('#idsArr').val(idsArr);
        $('#assignRoleForm').submit();
        return true;
    });

    // 清除
    $('#roleButtonClear').click(function() {
        clearAssign();
        return false;
    });
</script>