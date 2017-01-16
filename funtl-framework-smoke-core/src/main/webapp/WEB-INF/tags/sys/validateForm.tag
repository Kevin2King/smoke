<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="form" type="java.lang.String" required="true" description="表单"%>

<script type="text/javascript">
    $(function () {
        var form = $('#${form}');
        var error = $('.alert-danger', form);
        var success = $('.alert-success', form);

        form.validate({
            errorElement: 'span',
            errorClass: 'help-block help-block-error',
            focusInvalid: false,
            ignore: "",

            invalidHandler: function(event, validator) {
                success.hide();
                error.show();
                App.scrollTo(error, -200);
            },

            errorPlacement: function(error, element) {
                if (element.is(':checkbox')) {
                    error.insertAfter(element.closest(".md-checkbox-list, .md-checkbox-inline, .checkbox-list, .checkbox-inline"));
                } else if (element.is(':radio')) {
                    error.insertAfter(element.closest(".md-radio-list, .md-radio-inline, .radio-list,.radio-inline"));
                } else {
                    error.insertAfter(element);
                }
            },

            highlight: function(element) {
                $(element).closest('.form-group').addClass('has-error');
            },

            unhighlight: function(element) {
                $(element).closest('.form-group').removeClass('has-error');
            },

            success: function(label) {
                label.closest('.form-group').removeClass('has-error');
            },

            submitHandler: function(form) {
                Custom.initStartPageBlockUI();
                success.show();
                error.hide();
                form.submit();
            }
        });
    });
</script>