<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="table" type="java.lang.String" required="true" description="表格ID"%>

<script type="text/javascript">
    $(function () {
       /* // 解决表格X轴显示问题
        $('table').dataTable({
            language: {
                "sProcessing": "处理中...",
                "sLengthMenu": "显示_MENU_项结果",
                "sZeroRecords": "没有匹配结果",
                "sInfo": "显示第_START_至_END_项结果，共_TOTAL_项",
                "sInfoEmpty": "显示第0至0项结果，共0项",
                "sInfoFiltered": "(由_MAX_项结果过滤)",
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
                    "sSortAscending": ":以升序排列此列",
                    "sSortDescending": ":以降序排列此列"
                }
            },
            lengthChange: false,
            sort: false,
            filter: false,
            info: false,
            scroller: true,
            deferRender: true,
            scrollX: true,
            scrollCollapse: true,
            scrollY: 1440
        });*/
        // BY JinY 解决表格X轴显示问题
        $('#${table}').dataTable({
            language: {
                "sProcessing": "处理中...",
                "sLengthMenu": "显示_MENU_项结果",
                "sZeroRecords": "没有匹配结果",
                "sInfo": "显示第_START_至_END_项结果，共_TOTAL_项",
                "sInfoEmpty": "显示第0至0项结果，共0项",
                "sInfoFiltered": "(由_MAX_项结果过滤)",
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
                    "sSortAscending": ":以升序排列此列",
                    "sSortDescending": ":以降序排列此列"
                }
            },
            scrollY: "1440px",
            scrollCollapse: true,
            sort: false,
            filter: false,
            info: false,
            scroller: true,
            lengthChange: false,
            deferRender: true
        });
    });
    //#
</script>