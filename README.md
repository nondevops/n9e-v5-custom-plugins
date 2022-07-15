# n9e-v5-custom-plugins

夜莺监控V5版本，除官方自带input插件外所支持的自定义插件库

# 运行原理
使用categraf自带的input.exec插件作为数据上报

# 使用方法
## 克隆
```
git clone https://ghproxy.com/https://github.com/nondevops/n9e-v5-custom-plugins.git
```

## 修改input.exec配置
根据自己的需求，定义```instances```的程序执行路径
``` shell
  [root@aliyun input.exec]# cat exec.toml
# # collect interval
# interval = 15

[[instances]]
# # commands, support glob
commands = [
     "/opt/categraf_custom_scripts/*/collect_*.sh"
     "/opt/categraf_custom_scripts/*/collect_*.py"
     "/opt/categraf_custom_scripts/*/collect_*.go"
     "/opt/categraf_custom_scripts/*/collect_*.lua"
     "/opt/categraf_custom_scripts/*/collect_*.java"
     "/opt/categraf_custom_scripts/*/collect_*.bat"
     "/opt/categraf_custom_scripts/*/collect_*.cmd"
     "/opt/categraf_custom_scripts/*/collect_*.ps1"
]
timeout = 60
interval = 60

# # timeout for each command to complete
# timeout = 5

# # interval = global.interval * interval_times
interval_times = 1

# # mesurement,labelkey1=labelval1,labelkey2=labelval2 field1=1.2,field2=2.3
data_format = "influx"
[root@aliyun input.exec]# pwd
/opt/gocode/src/categraf/conf/input.exec
```
## 用法
需使用人解读每个脚本或程序的逻辑，其脚本或程序顶部有大概作用的描述。

## 调试
参考categraf官方提供的调试方法处置

# 自定义脚本格式（参考）
``` shell
var_name="constant,tag1_key=tag1_value,tag2_key=tag2_value filed1_key=filed1_value,filed2_key=filed2_value"
var_name="cpu,region=aliyun,ip=${ip} user=${user},free=${free},used=${used}"
echo ${var_name}

备注：
python脚本同理，拼凑为以上格式即可。
filed1_value需可变化的值。
```

# 备注
本仓库所维护的是exec执行目录下的具体内容

# 严正说明
```
本仓库所托管的程序在生产环境未做全量覆盖，可能会遇到不可避免的风险，由此带来的风险由本人承担，本仓库所发起人及贡献人都不承担任何责任。
本仓库所托管的程序为完全开源，不存在任何后门程序，如有发现类似情况，欢迎举报和反馈。
```

# 温馨提示
```
各位开源有志之士如有共同维护此仓库意识，欢迎提PR。
非常欢迎需要监控的同学加入夜莺开源交流群。
```
