<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${classInfo.mapperPackage()}.${classInfo.name}Mapper">
    <resultMap id="BaseResultMap" type="${classInfo.entityPackage()}.${classInfo.name}Entity">
    <#if classInfo.columnList?exists && classInfo.columnList?size gt 0>
        <#list classInfo.columnList as fieldItem >
            <result column="${fieldItem.columnName}" jdbcType="${fieldItem.type}" property="${fieldItem.name}" />
        </#list>
    </#if>
    </resultMap>
    <sql id="Base_Column_List">
    <#if classInfo.columnList?exists && classInfo.columnList?size gt 0>
     <#list classInfo.columnList as fieldItem >`${fieldItem.columnName}`<#if fieldItem_has_next>,</#if></#list>
    </#if>
    </sql>

    <sql id="limit">
        <if test='offset != 0 and limit != 0'>
            ${r"limit #{offset}, #{limit}"}
        </if>

        <if test='offset == 0 and limit != 0'>
            limit ${r"#{limit}"}
        </if>
    </sql>

    <sql id="queryWhere">
        <where>
         <#if classInfo.columnList?exists && classInfo.columnList?size gt 0>
          <#list classInfo.columnList as fieldItem >
              <if test="${fieldItem.name} != null">
                  and `${fieldItem.columnName}` = ${fieldItem.name}
              </if>
          </#list>
          </#if>
        </where>
    </sql>

    <select id="selectByParam" parameterType="${classInfo.paramPackage()}.${classInfo.name}Param" resultMap="BaseResultMap">
        select
        <if test="distinct">
            distinct
        </if>
        <include refid="Base_Column_List" />
        from ${classInfo.tableName}
        <include refid="queryWhere" />
        <if test="orderByClause != null">
            order by ${r"${orderByClause}"}
        </if>
        <include refid="limit" />
    </select>

    <select id="countByParam" resultType="java.lang.Long">
        SELECT count(*)
        from ${classInfo.tableName}
        <include refid="queryWhere"/>
    </select>
    <select id="selectByPrimaryKey" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List" />
        from ${classInfo.tableName}
        where ${classInfo.primaryKey.columnName} = ${r"#{"}${classInfo.primaryKey.name}${r"}"}
    </select>
    <delete id="deleteByPrimaryKey">
        delete from ${classInfo.tableName}
        where ${classInfo.primaryKey.columnName} = ${r"#{"}${classInfo.primaryKey.name}${r"}"}
    </delete>

    <insert id="insertSelective"  >
        INSERT INTO ${classInfo.tableName}
        <#if classInfo.columnList?exists && classInfo.columnList?size gt 0>
        <trim prefix="(" suffix=")" suffixOverrides=",">
         <#list classInfo.columnList as fieldItem >
             <if test="${fieldItem.name} != null">
                  `${fieldItem.columnName}`,
             </if>
          </#list>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
         <#list classInfo.columnList as fieldItem >
              <if test="${fieldItem.name} != null">
               ${r"#{"}${fieldItem.name}${r"}"},
              </if>
         </#list>
        </trim>
        </#if>
    </insert>
    <insert id="insertBatch"  >
        INSERT INTO ${classInfo.tableName}
    <#if classInfo.columnList?exists && classInfo.columnList?size gt 0>
        <trim prefix="(" suffix=")" suffixOverrides=",">
            <#list classInfo.columnList as fieldItem >
                    `${fieldItem.columnName}`,
            </#list>
        </trim>
         values
        <foreach collection="list" item="item" index="index" separator=",">
        <trim prefix="(" suffix=")" suffixOverrides=",">
                <#list classInfo.columnList as fieldItem >
                    ${r"#{item."}${fieldItem.name}${r"}"},
                </#list>
            </trim>
        </foreach>
    </#if>
    </insert>
    <insert id="insertOrUpdate"  >
        INSERT INTO ${classInfo.tableName}
    <#if classInfo.columnList?exists && classInfo.columnList?size gt 0>
        <trim prefix="(" suffix=")" suffixOverrides=",">
            <#list classInfo.columnList as fieldItem >
                <if test="${fieldItem.name} != null">
                    `${fieldItem.columnName}`,
                </if>
            </#list>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
            <#list classInfo.columnList as fieldItem >
                <if test="${fieldItem.name} != null">
                ${r"#{"}${fieldItem.name}${r"}"},
                </if>
            </#list>
        </trim>
        ON DUPLICATE KEY UPDATE
        <set>
            <#list classInfo.columnList as fieldItem >
                <if test="${fieldItem.name} != null">
                    `${fieldItem.columnName}` = ${r"#{"}${fieldItem.name}${r"}"},
                </if>
            </#list>
        </set>
    </#if>
    </insert>
    <update id="updateByPrimaryKeySelective"  useGeneratedKeys="true">
        update ${classInfo.tableName}
        <set>
        <#list classInfo.columnList as fieldItem >
            <if test="${fieldItem.name} != null">
              `${fieldItem.columnName}` = ${r"#{"}${fieldItem.name}${r"}"},
            </if>
        </#list>
        </set>
        where ${classInfo.primaryKey.columnName} = ${r"#{"}${classInfo.primaryKey.name}${r"}"}
    </update>
</mapper>