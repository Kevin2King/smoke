<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="label" type="java.lang.String" required="true" description="输入框标题"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值"%>
<div class="input-icon right">
    <input id="${id}" name="${name}" type="text" class="form-control" value="${value}" readonly="readonly" onclick="upImage${id}();" />
    <label> ${label}</label>
    <span class="help-block"></span>
    <i class="icon-cloud-upload" onclick="show${id}();"></i>
</div>
<script type="text/plain" id="j_ueditorupload${id}" style="height:5px;display:none;" ></script>
<script>
    //实例化编辑器
    var o_ueditorupload${id} = UE.getEditor('j_ueditorupload${id}', {
        autoHeightEnabled: false
    });
    o_ueditorupload${id}.ready(function () {
        o_ueditorupload${id}.hide();//隐藏编辑器
        //监听图片上传
        o_ueditorupload${id}.addListener('beforeInsertImage', function (t, arg) {
            $("#${id}").val(arg[0].src).trigger('change');
        });
    });

    //弹出图片上传的对话框
    function upImage${id}() {
        var myImage${id} = o_ueditorupload${id}.getDialog("insertimage");
        myImage${id}.open();
    }

    // 查看图片
    function show${id}() {
        window.open($("#${id}").val(), null, 'dialogWidth:800px;dialogHeight:600px;center:yes;edge:raised;scroll:yes;status:no;minimize:yes;maximize:yes;');
    }
</script>