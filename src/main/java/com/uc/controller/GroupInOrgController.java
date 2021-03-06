package com.uc.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.framework.AppConstants;
import com.framework.SysErrorCode;
import com.framework.controller.BaseController;
import com.framework.entity.GeneralResponseData;
import com.framework.log4jdbc.Log;
import com.framework.log4jdbc.LogLevel;
import com.framework.utils.pager.DynamicSpecifications;
import com.framework.utils.pager.Pager;
import com.framework.utils.pager.SearchFilter;
import com.uc.entity.GroupInOrg;
import com.uc.service.GroupInOrgService;

@Controller
@RequestMapping("/groupinfo")
public class GroupInOrgController extends BaseController {

    @Autowired
    private GroupInOrgService groupInOrgService;

    ObjectMapper mapper = new ObjectMapper();
    private static final String CREATE = "biz/mgruser/groupinfo/create";
    private static final String UPDATE = "biz/mgruser/groupinfo/update";
    private static final String LIST = "biz/mgruser/groupinfo/list";
    private static final String VIEW = "biz/mgruser/groupinfo/view";

    @RequiresPermissions("GroupInOrg:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String preCreate(Map<String, Object> map) {
        return CREATE;
    }

    @Log(message = "添加了组信息:{0}", level = LogLevel.INFO, catrgory = "uc")
    @RequiresPermissions("GroupInOrg:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public @ResponseBody String create(@Valid GroupInOrg groupinorg) throws JsonProcessingException {
        GeneralResponseData<GroupInOrg> ret = new GeneralResponseData<GroupInOrg>();

        // hessian call
        groupinorg.setCreateTime(new Date());
        Boolean b = groupInOrgService.add(groupinorg);
        if (!b) {
            ret.setStatus(AppConstants.FAILED);
            ret.setErrCode(SysErrorCode.SAVE_FAILED);
            ret.setErrMsg(SysErrorCode.MAP.get(SysErrorCode.SAVE_FAILED));
        } else {
            ret.setStatus(AppConstants.SUCCESS);
            ret.setData(groupinorg);
            setLogObject(new Object[] { groupinorg.getOrgName() + "-" + groupinorg.getGroupName() + "-"
                    + groupinorg.getGroupNo() });
        }

        return mapper.writeValueAsString(ret);
    }

    @Log(message = "删除了组信息:{0}", level = LogLevel.INFO, catrgory = "uc")
    @RequiresPermissions("GroupInOrg:delete")
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public @ResponseBody String delete(@PathVariable double id) throws JsonProcessingException {
        GeneralResponseData<String> ret = new GeneralResponseData<String>();

        // hessian call
        groupInOrgService.delete(id);
        ret.setStatus(AppConstants.SUCCESS);
        setLogObject(new Object[] { id });
        return mapper.writeValueAsString(ret);
    }

    @RequiresPermissions("GroupInOrg:update")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
    public String preUpdate(@PathVariable Integer id, Map<String, Object> map) {
        GroupInOrg groupinorg = groupInOrgService.findOne(id);
        map.put("groupinorg", groupinorg);
        return UPDATE;
    }

    @Log(message = "修改了组信息:{0}的信息", level = LogLevel.INFO, catrgory = "uc")
    @RequiresPermissions("GroupInOrg:update")
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public @ResponseBody String update(@Valid GroupInOrg groupinorg) throws JsonProcessingException {
        GeneralResponseData<GroupInOrg> ret = new GeneralResponseData<GroupInOrg>();

        // hessian call
        GroupInOrg tmp = groupInOrgService.findOne(groupinorg.getCreateTime().getTime());
        groupinorg.setCreateTime(tmp.getCreateTime());
        groupinorg.setModifyTime(new Date());

        Boolean b = groupInOrgService.update(groupinorg);
        if (!b) {
            ret.setStatus(AppConstants.FAILED);
            ret.setErrCode(SysErrorCode.SAVE_FAILED);
            ret.setErrMsg(SysErrorCode.MAP.get(SysErrorCode.SAVE_FAILED));
        } else {
            ret.setStatus(AppConstants.SUCCESS);
            ret.setData(groupinorg);
            setLogObject(new Object[] { groupinorg.getOrgName() + "-" + groupinorg.getGroupName() + "-"
                    + groupinorg.getGroupNo() });
        }

        return mapper.writeValueAsString(ret);
    }

    @RequiresPermissions(value = { "GroupInOrg:view", "GroupInOrg:create", "GroupInOrg:update", "GroupInOrg:delete" }, logical = Logical.OR)
    @RequestMapping(value = "/list", method = { RequestMethod.GET, RequestMethod.POST })
    public String list(ServletRequest request, Pager pager, Map<String, Object> map) {
        List<GroupInOrg> groupinorgs = new ArrayList<GroupInOrg>();
        SearchFilter filter = DynamicSpecifications.genSearchFilter(request);
        if (filter != null && filter.getRules() != null && filter.getRules().size() > 0) {
            // hessian call
        } else {
            groupinorgs = groupInOrgService.findByPage(pager.getPageSize(), pager.getCurrPage());
        }

        Long count = groupInOrgService.findCount();
        pager.setTotalCount(count);
        map.put("pager", pager);
        map.put("groupinorgs", groupinorgs);

        return LIST;
    }

    @RequiresPermissions(value = { "GroupInOrg:view", "GroupInOrg:create", "GroupInOrg:update", "GroupInOrg:delete" }, logical = Logical.OR)
    @RequestMapping(value = "/view/{id}", method = { RequestMethod.GET })
    public String view(@PathVariable Integer id, Map<String, Object> map) {
        GroupInOrg groupinorg = groupInOrgService.findOne(id);
        map.put("groupinorg", groupinorg);
        return VIEW;
    }
}
