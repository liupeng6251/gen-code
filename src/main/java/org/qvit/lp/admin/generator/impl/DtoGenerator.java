package org.qvit.lp.admin.generator.impl;

import org.qvit.lp.admin.generator.BaseGenerator;
import org.qvit.lp.admin.model.ClassInfo;
import org.springframework.stereotype.Component;

import java.io.File;

/**
 * Created by peng.liu11 on 2019/5/26.
 */
@Component
public class DtoGenerator extends BaseGenerator {

    @Override
    protected String getTemplate() {
        return "dto.ftl";
    }

    @Override
    protected String getPath(ClassInfo classInfo) {
        String packatePath = classInfo.dtoPackage().replace(".","/")+ File.separator  + classInfo.getName() + "Dto.java";
        return "src/main/java/"+packatePath;
    }
    @Override
    protected boolean isGlobal() {
        return false;
    }
}
