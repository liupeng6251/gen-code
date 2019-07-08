package org.qvit.lp.admin.generator;

import org.qvit.lp.admin.model.ClassInfo;
import org.qvit.lp.admin.utils.FreemarkerUtil;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.io.File;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by peng.liu11 on 2019/6/5.
 */
@Component
public class FreemarkerCommonMacroGenerator implements IGenerator {

    @Override
    public void execute(List<ClassInfo> classInfos, Map<String, Object> extParam, ZipOutputStream zipOutputStream) throws Exception {
        ZipEntry entry = new ZipEntry(extParam.get("projectName") + File.separator + getPath());
        zipOutputStream.putNextEntry(entry);

        Map<String, Object> param = new HashMap<>();
        param.put("maps", menuTree(classInfos));
        param.putAll(extParam);
        String value = FreemarkerUtil.processString(getTemplate(), param);
        zipOutputStream.write(value.getBytes(Charset.forName("utf-8")));
        zipOutputStream.closeEntry();
    }


    private String getTemplate() {
        return "hui/common.macro.ftl";
    }

    private String getPath() {
        return "src/main/resources/templates/common/common.macro.ftl";
    }

    private Map<String, List<ClassInfo>> menuTree(List<ClassInfo> classInfos) {
        if (CollectionUtils.isEmpty(classInfos)) {
            return new HashMap<>();
        }
        Map<String, List<ClassInfo>> maps = classInfos.stream().collect((Collectors.groupingBy(o -> o.getBusinessModule())));
        return maps;
    }
}
