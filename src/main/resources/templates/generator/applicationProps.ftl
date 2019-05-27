spring.datasource.url=${jdbcUrl}
spring.datasource.username=${jdbcUsername}
spring.datasource.password=${jdbcPassword}
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.datasource.max-idle=10
spring.datasource.max-wait=10000
spring.datasource.min-idle=5
spring.datasource.initial-size=5
spring.datasource.type=com.alibaba.druid.pool.DruidDataSource
spring.datasource.validationQuery=select 'x'
mybatis.mapper-locations=classpath:mapper/sys/*.xml,classpath:mapper/*.xml
mybatis.type-aliases-package=org.qvit.report.entity.*.*,org.qvit.report.entity.*
pagehelper.helperDialect=mysql
pagehelper.reasonable=true
pagehelper.supportMethodsArguments=true
pagehelper.params=count=countSql
server.port=8011
server.tomcat.uri-encoding=UTF-8