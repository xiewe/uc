<jsp:directive.page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" />
<jsp:directive.include file="/WEB-INF/pages/include.inc.jsp" />

<div class="row main-content">
    <form id="saveForm" class="form-horizontal" role="form" method="post" action="${contextPath }/apngroup/create" onsubmit="return doSave(this, '${contextPath }/apngroup/list');">
        <div class="form-group">
            <label for="apnGroupId" class="col-sm-4 control-label">APN组ID *</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" name="apnGroupId" placeholder="请输入APN组ID">
            </div>
        </div>
        <div class="form-group">
            <label for="apnGroupName" class="col-sm-4 control-label">APN组名称 *</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" name="apnGroupName" placeholder="请输入APN组名称">
            </div>
        </div>
        <div class="form-group">
            <label for="maxRequestedBwUl" class="col-sm-4 control-label">上行最大带宽（kbps） *</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" name="maxRequestedBwUl" placeholder="请输入上行最大带宽">
            </div>
        </div>
        <div class="form-group">
            <label for="maxRequestedBwDl" class="col-sm-4 control-label">下行最大带宽（kbps） *</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" name="maxRequestedBwDl" placeholder="请输入下行最大带宽">
            </div>
        </div>
        <div class="form-group">
            <label for="apnNotifiedType" class="col-sm-4 control-label">APN模版配置通知类型 *</label>
            <div class="col-sm-8">
                <select class="form-control" name="apnNotifiedType">
                    <option value="0">通知所有APN</option>
                    <option value="1">通知被修改APN</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="apnIdList" class="col-sm-4 control-label">APN设置 *</label>
            <div class="col-sm-8">
                <input type="hidden" name="apnIdList" value="">
                <div class="checkbox">
                    <label><input type="checkbox" value="">选项 1</label>
                </div>
                <div class="checkbox">
                    <label><input type="checkbox" value="">选项 2</label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="pgwAllocationType" class="col-sm-4 control-label">默认APN *</label>
            <div class="col-sm-8">
                <div class="radio">
                    <label class="checkbox-inline"> <input type="radio" name="ci" id="optionsRadios1" value="0" checked> 静态
                    </label> <label class="checkbox-inline"> <input type="radio" name="ci" id="optionsRadios2" value="1"> 动态
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-8">
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
                apnGroupId : {
                    validators : {
                        notEmpty : {},
                        digits : {}
                    }
                },
                apnGroupName : {
                    validators : {
                        notEmpty : {},
                        stringLength : {
                            max : 32
                        }
                    }
                },
                maxRequestedBwUl : {
                    validators : {
                        notEmpty : {},
                        digits : {}
                    }
                },
                maxRequestedBwDl : {
                    validators : {
                        notEmpty : {},
                        digits : {}
                    }
                }
            }
        }).on('success.form.bv', function(e) {
            e.preventDefault();
        });
    });
</script>
