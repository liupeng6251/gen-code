package org.qvit.lp.admin.generator;

import org.apache.commons.collections4.MapUtils;
import org.qvit.lp.admin.model.ClassFieldInfo;
import org.qvit.lp.admin.model.ClassInfo;
import org.qvit.lp.admin.utils.FreemarkerUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.io.File;
import java.nio.charset.Charset;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by peng.liu11 on 2019/5/26.
 */
public abstract class BaseGenerator implements IGenerator {

    public void execute(List<ClassInfo> classInfos, Map<String, Object> extParam, ZipOutputStream zipOutputStream) throws Exception {
        if (!isGlobal() && CollectionUtils.isEmpty(classInfos)) {
            return;
        }
        if ( CollectionUtils.isEmpty(classInfos) && isGlobal()) {
            ClassInfo classInfo = new ClassInfo();
            String pastPackage = MapUtils.getString(extParam,"packageName")+"."+MapUtils.getString(extParam,"projectName");
            classInfo.setPackagePath(pastPackage);
            ZipEntry entry = new ZipEntry(extParam.get("projectName") + File.separator + getPath(classInfo));
            zipOutputStream.putNextEntry(entry);
            Map<String, Object> param = new HashMap<>();
            if (!CollectionUtils.isEmpty(classInfos)) {
                param.put("classInfo", classInfos.get(0));
            }
            param.putAll(extParam);
            String value = FreemarkerUtil.processString(getTemplate(), param);
            zipOutputStream.write(value.getBytes(Charset.forName("utf-8")));
            zipOutputStream.closeEntry();
            return;
        }
        for (ClassInfo classInfo : classInfos) {
            ZipEntry entry = new ZipEntry(extParam.get("projectName") + File.separator + getPath(classInfo));
            zipOutputStream.putNextEntry(entry);
            ClassFieldInfo primaryKey = classInfo.getPrimaryKey();
            classInfo.setPrimaryKey(primaryKey);
            Map<String, Object> param = new HashMap<>();
            param.put("classInfo", classInfo);
            param.putAll(extParam);
            String value = FreemarkerUtil.processString(getTemplate(), param);
            zipOutputStream.write(value.getBytes(Charset.forName("utf-8")));
            zipOutputStream.closeEntry();
            if (isGlobal()) {
                break;
            }
        }
    }

    protected abstract boolean isGlobal();

    protected abstract String getTemplate();

    protected abstract String getPath(ClassInfo classInfo);

}
