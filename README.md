# 苏州市医院预约挂号系统

基于 SSM（Spring + Spring MVC + MyBatis）框架开发的医院预约挂号系统，支持患者在线预约挂号、后台管理排班等功能。

## 技术栈

| 层级 | 技术 | 版本 |
|------|------|------|
| 核心框架 | Spring / Spring MVC | 4.1.7.RELEASE |
| ORM | MyBatis | 3.3.0 |
| 数据库 | MySQL | 8.0 (driver 8.0.30) |
| 连接池 | C3P0 | 0.9.1.2 |
| 前端 | Bootstrap 3 + jQuery 1.11.1 | - |
| 模板 | JSP + JSTL | - |
| 邮件 | JavaMail | 1.5.6 |
| JSON | Jackson | 2.5.4 |
| 构建 | Maven | WAR 3.1.0 |
| 运行环境 | Tomcat 8 + JDK 1.7+ | - |

## 功能概览

### 患者端

| 功能 | 状态 | 说明 |
|------|------|------|
| 用户注册/登录 | ✅ 已完成 | 邮箱+密码注册，MD5 加密 |
| 密码找回 | ✅ 已完成 | 通过邮箱验证码重置 |
| 完善个人信息（实名认证） | ✅ 已完成 | 姓名、身份证号、手机号、性别 |
| 个人中心 | ✅ 已完成 | 查看预约记录、修改性别、收藏医院 |
| 修改手机号 | ✅ 已完成 | 需邮箱验证码 |
| 修改密码 | ✅ 已完成 | 修改后需重新登录 |
| 医院浏览与搜索 | ✅ 已完成 | 按地区/等级/性质筛选 |
| 科室浏览与搜索 | ✅ 已完成 | 按科室名称搜索 |
| 医生浏览与搜索 | ✅ 已完成 | 按职称/职位等筛选 |
| 医生排班查看 | ✅ 已完成 | 日历形式展示可预约日期和时段 |
| 预约挂号 | ✅ 已完成 | 选择日期/时段，填写病情描述 |
| 取消预约 | ✅ 已完成 | 个人中心取消待处理订单 |
| 收藏医院 | ✅ 已完成 | 收藏/取消收藏 |
| 意见反馈 | ✅ 已完成 | 提交反馈到数据库 |
| 公告查看 | ✅ 已完成 | 公告列表及详情 |
| 联系我们 | ✅ 已完成 | 联系方式、法律声明、服务协议 |
| 帮助中心 | ✅ 已完成 | 常见问题、预约指南、账户指南 |
| 预约时邮件验证码 | ❌ 未完成 | 邮箱验证码后端已完整实现，但订单确认页前端面板被注释，`sendMessage()` 函数未实现 |
| 在线支付 | ❌ 未开通 | 仅支持"现场支付"，在线支付按钮已禁用 |
| 注册时填写详细信息 | ❌ 已简化 | 注册时仅需邮箱+密码，详细信息在登录后补充 |

### 管理端

| 功能 | 状态 | 说明 |
|------|------|------|
| 管理员登录 | ✅ 已完成 | 通过账号 `isAdmin=1` 区分 |
| 控制台首页 | ✅ 已完成 | 统计卡片 + 快捷操作入口 |
| 科室管理 | ✅ 已完成 | 增删改查 |
| 医生管理 | ✅ 已完成 | 增删改查 |
| 排班管理 | ✅ 已完成 | 单个/批量创建排班，开关排班 |
| 预约管理 | ✅ 已完成 | 查看订单，批准/拒绝 |
| 医院管理 | ⚠️ 部分完成 | 仅可查看列表和开关状态，无增删改 |
| 公告管理 | ❌ 未完成 | 管理员无法发布/编辑/删除公告 |
| 反馈管理 | ❌ 未完成 | 管理员无法查看/处理用户反馈 |
| 用户管理 | ❌ 未完成 | 无用户列表及管理功能 |

## 项目结构

```
hosp_order-master/
├── ssm_pro/                          # Maven 主模块
│   ├── pom.xml
│   └── src/
│       ├── main/
│       │   ├── java/edu/jssvc/
│       │   │   ├── dao/              # MyBatis Mapper 接口 (10个)
│       │   │   ├── entity/           # 实体类 (11个)
│       │   │   ├── scheduler/        # 定时任务
│       │   │   ├── service/          # 服务接口 (8个)
│       │   │   │   └── impl/         # 服务实现 (8个)
│       │   │   ├── utils/            # 工具类 (5个)
│       │   │   └── web/              # Controller (9个)
│       │   │       └── interceptor/  # 拦截器
│       │   ├── resources/
│       │   │   ├── mapper/           # MyBatis XML (10个)
│       │   │   ├── spring/           # Spring 配置文件 (3个)
│       │   │   ├── jdbc.properties
│       │   │   ├── system_config.properties
│       │   │   ├── logback.xml
│       │   │   └── mybatis-config.xml
│       │   └── webapp/
│       │       ├── WEB-INF/
│       │       │   ├── jsp/          # 视图文件 (42个)
│       │       │   │   ├── admin/         # 管理端页面
│       │       │   │   ├── include/       # 公共引入 (导航、菜单)
│       │       │   │   ├── user/          # 用户认证相关
│       │       │   │   ├── userCenter/    # 个人中心
│       │       │   │   ├── hospital/      # 医院浏览
│       │       │   │   ├── doctor/        # 医生浏览
│       │       │   │   ├── office/        # 科室浏览
│       │       │   │   ├── order/         # 预约下单
│       │       │   │   ├── notice/        # 公告
│       │       │   │   ├── help/          # 帮助中心
│       │       │   │   ├── feedBack/      # 意见反馈
│       │       │   │   └── contact/       # 联系我们
│       │       │   └── web.xml
│       │       └── assets/           # 静态资源
│       │           ├── bootstrap/    # Bootstrap 3.3.4
│       │           ├── font-awesome/ # Font Awesome 图标
│       │           ├── date/         # 日历插件
│       │           ├── css/          # 自定义样式
│       │           ├── js/           # JavaScript
│       │           └── img/          # 图片
│       └── test/
├── 实训报告.html                      # 实训文档
└── pom.xml                           # 父 POM
```

## 数据库表

| 表名 | 说明 |
|------|------|
| `commonuser` | 用户表（含管理员） |
| `hospital` | 医院信息表 |
| `hos_office` | 科室信息表 |
| `doctor` | 医生信息表 |
| `doctor_schedule` | 医生排班表 |
| `order_records` | 预约订单表 |
| `favourite` | 用户收藏表 |
| `notice` | 公告表 |
| `feed_back` | 用户反馈表 |
| `help_q_a` | 帮助问答表 |
| `area` | 地区表（省/市/区三级） |

## 环境搭建

### 前置条件

- JDK 1.7 或更高版本
- Maven 3.x
- MySQL 5.7+ / 8.0
- Tomcat 8.x

### 部署步骤

1. **创建数据库**

```sql
CREATE DATABASE hosdb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

导入项目附带的 SQL 初始化脚本（如有）。

2. **修改数据库配置**

将 `ssm_pro/src/main/resources/jdbc.properties.template` 复制为 `jdbc.properties`，并修改：

```properties
jdbc.driver=com.mysql.cj.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/hosdb?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true
jdbc.username=root
jdbc.password=你的数据库密码
```

3. **修改邮件配置**

将 `ssm_pro/src/main/resources/system_config.properties.template` 复制为 `system_config.properties`，并修改：

```properties
mailhost = smtp.163.com
personal = 苏州市医院预约系统
mailuser = 你的163邮箱地址
mailpassword = 你的163邮箱SMTP授权码
pageRecord = 8
showPageCount = 10
```

> **说明：** 仓库中的 `jdbc.properties` 和 `system_config.properties` 已通过 `.gitignore` 排除，仅保留 `.template` 模板文件。clone 项目后需按上述步骤从模板文件复制并填入真实配置。
>
> **注意：** `mailpassword` 不是邮箱登录密码，而是网易邮箱的 SMTP 授权码。需登录 163 邮箱 → 设置 → POP3/SMTP/IMAP → 开启服务 → 获取授权码。

4. **编译部署**

```bash
cd ssm_pro
mvn clean package -DskipTests
```

将生成的 `target/ssm_pro-0.0.1-SNAPSHOT.war` 复制到 Tomcat 的 `webapps/` 目录，重命名为 `ssm_pro.war`。

5. **启动 Tomcat**

```bash
cd tomcat/bin
./startup.sh   # Linux/Mac
startup.bat    # Windows
```

6. **访问系统**

- 患者端：`http://localhost:8080/ssm_pro/index`
- 管理端：`http://localhost:8080/ssm_pro/admin/login`

## 默认管理员账号

管理员通过数据库 `commonuser` 表中的 `is_admin` 字段区分（`1` = 管理员）。系统没有内置默认管理员账号，需要在数据库中手动将已注册用户设为管理员：

```sql
UPDATE commonuser SET is_admin = 1 WHERE user_email = '你的邮箱';
```

## 已知问题与限制

### 功能缺失

1. **管理员无法发布公告** — 公告管理完全未开发。NoticeDao 只有查询方法，无 INSERT/UPDATE/DELETE；AdminController 无公告相关接口；管理端菜单无公告管理入口。当前公告需要通过数据库直接插入。

2. **管理员无法查看用户反馈** — 反馈管理完全未开发。FeedBackDao 只有 INSERT 方法，无查询/删除；无 FeedBackService；无管理员反馈列表页面。用户提交的反馈只能通过数据库直接查看。

3. **预约时邮件验证码未接入** — 邮箱验证码整体功能已完整（密码找回、修改手机号、完善个人信息均可正常发送和校验验证码），但订单确认页（`orderInfo.jsp`）的前端验证码面板被注释掉，`sendMessage()` 函数未实现，导致预约下单时缺少验证码环节。

4. **无用户管理** — 管理端没有用户列表、用户状态管理等功能。

5. **医院信息不可增删改** — 管理端只能查看医院列表和切换开放状态，无法添加/编辑/删除医院。

6. **在线支付未开通** — 订单页面仅支持"现场支付"，在线支付按钮已禁用。

### 代码质量

7. **密码使用 MD5 加密** — 不建议生产环境使用，应升级为 BCrypt 或 Argon2。

8. **邮箱密码需自行配置** — SMTP 授权码需从模板文件 `system_config.properties.template` 复制后填写，配置文件已通过 `.gitignore` 排除，不会提交到仓库。

9. **部分 SQL 存在注入风险** — 部分 Mapper XML 使用 `${}` 拼接 LIKE 查询条件（如医院搜索），应改用 `#{}` 参数化。

10. **反馈提交无服务端鉴权** — 仅前端 JS 检查登录状态，服务端 `HelpController.feedBackInfo()` 未验证 Session。

11. **部分页面标题错误** — `checkVerification.jsp` 和 `modifiPhone.jsp` 的 `<title>` 误写为"用户找回密码"。

12. **邮件发送为同步** — `MailUtil.sendMail()` 采用同步方式，代码中有 FIXME 标记待改为异步。

### 架构限制

13. **Redis 依赖已引入但未实际使用** — pom.xml 引入了 Jedis 和 Protostuff，但代码中未见 Redis 缓存逻辑。

14. **无接口文档** — API 接口无 Swagger 或其他文档。

15. **无单元测试** — 仅有 BaseTest 基类，缺乏业务逻辑的单元测试覆盖。

## 开发说明

- 项目编译目标为 Java 1.7，使用传统 Servlet 3.1 + JSP 模型
- Spring 事务管理覆盖所有 Service 层方法（`@Transactional`）
- 定时任务每 2 分钟扫描一次待通知的订单，通过邮件发送预约成功通知
- 管理员拦截器检查 `isAdmin == 1`，非管理员访问 `/admin/**` 会被重定向到登录页
- 前端使用 Bootstrap 3 标签页（Tab）组件，注意避免重复加载 jQuery 导致插件被覆盖

## 参考信息

- 仓库地址：[itdjy04/HospitalOrder](https://github.com/itdjy04/HospitalOrder)
- 项目暂停维护，仅供学习交流使用
