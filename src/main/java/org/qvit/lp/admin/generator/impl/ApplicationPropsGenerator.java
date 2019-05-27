package org.qvit.lp.admin.generator.impl;

import org.qvit.lp.admin.generator.AbstractGenerator;
import org.qvit.lp.admin.model.ClassInfo;
import org.springframework.stereotype.Component;

/**
 * Created by peng.liu11 on 2019/5/26.
 */
@Component
public class ApplicationPropsGenerator extends AbstractGenerator {

    @Override
    protected String getTemplate() {
        return "applicationProps.ftl";
    }

    @Override
    protected String getPath(ClassInfo classInfo) {
        return "src/main/resources/application.properties";
    }

    @Override
    protected boolean isGlobal() {
        return true;
    }
}
