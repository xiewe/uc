<jsp:directive.page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" />
<jsp:directive.include file="/WEB-INF/pages/include.inc.jsp" />

<div class="row main-content">
    <form id="saveForm" class="form-horizontal" role="form" method="post" action="${contextPath }/groupinfo/create" onsubmit="return doSave(this, '${contextPath }/groupinfo/list');">
        <div class="form-group">
            <label for="orgName" class="col-sm-2 control-label">组织名称*</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="orgName" placeholder="请输入组织名称">
            </div>
        </div>
        <div class="form-group">
            <label for="groupNo" class="col-sm-2 control-label">组号码 *</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="groupNo" placeholder="请输入组号码">
            </div>
        </div>
        <div class="form-group">
            <label for="groupName" class="col-sm-2 control-label">组名称 *</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="groupName" placeholder="请输入组名称">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary">确定</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    function doSave(form, listUrl) {
        var flag = $(form).data("bootstrapValidator").isValid();
        if (flag) {
            _doSave(form, listUrl);
        }
        return false;
    }

    $(document).ready(function() {

        $('#saveForm').bootstrapValidator({
            feedbackIcons : {
                valid : 'glyphicon glyphicon-ok',
                invalid : 'glyphicon glyphicon-remove',
                validating : 'glyphicon glyphicon-refresh'
            },
            fields : {
                orgName : {
                    validators : {
                        notEmpty : {},
                        stringLength : {
                            max : 32
                        }
                    }
                },
                groupNo : {
                    validators : {
                        notEmpty : {},
                        stringLength : {
                            max : 32
                        }
                    }
                },
                groupName : {
                    validators : {
                        notEmpty : {},
                        stringLength : {
                            max : 32
                        }
                    }
                }
            }
        }).on('success.form.bv', function(e) {
            e.preventDefault();
        });
    });
</script>
