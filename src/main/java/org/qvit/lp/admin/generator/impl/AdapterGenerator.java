package org.qvit.lp.admin.generator.impl;

import org.qvit.lp.admin.generator.AbstractGenerator;
import org.qvit.lp.admin.model.ClassInfo;
import org.springframework.stereotype.Component;

import java.io.File;

/**
 * Created by peng.liu11 on 2019/5/26.
 */
@Component
public class AdapterGenerator extends AbstractGenerator {

    @Override
    protected String getTemplate() {
        return "adapter.ftl";
    }

    @Override
    protected String getPath(ClassInfo classInfo) {
        String packatePath = classInfo.adapterPackage().replace(".","/")+ File.separator  + classInfo.getName() + "Adapter.java";
        return "src/main/java/"+packatePath;
    }

    @Override
    protected boolean isGlobal() {
        return false;
    }
}
