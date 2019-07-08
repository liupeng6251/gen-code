package org.qvit.lp.admin.generator.impl;

import org.apache.commons.lang3.StringUtils;
import org.qvit.lp.admin.generator.BaseGenerator;
import org.qvit.lp.admin.model.ClassInfo;
import org.springframework.stereotype.Component;

import java.io.File;

/**
 * Created by peng.liu11 on 2019/6/5.
 */
@Component
public class FreemarkerListPageGenerator extends BaseGenerator {

    @Override
    protected boolean isGlobal() {
        return false;
    }

    @Override
    protected String getTemplate() {
        return "hui/htmllist.ftl";
    }

    @Override
    protected String getPath(ClassInfo classInfo) {
        String packatePath;
        if (StringUtils.isNotEmpty(classInfo.getBusinessModule())) {
            packatePath = "src/main/resources/templates/" + File.separator + classInfo.getBusinessModule() + File.separator + classInfo.getName() + ".ftl";
        } else {
            packatePath = "src/main/resources/templates/" + org.qvit.lp.admin.utils.StringUtils.lowerCaseFirst(classInfo.getName()) + ".ftl";
        }
        return packatePath;
    }
}
