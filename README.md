# GitTest

一个用于练习 Git / GitHub 工作流的 Python 示例项目。

## 环境要求

- Python >= 3.14

## 快速开始

```bash
# 创建并激活虚拟环境
python -m venv .venv
.venv\Scripts\activate      # Windows
# source .venv/bin/activate  # macOS / Linux

# 运行示例脚本
python main.py
```

预期输出：

```
Hi, PyCharm
```

## 项目结构

```
GitTest/
├── main.py           # 示例入口脚本
├── pyproject.toml    # 项目元数据与依赖声明
└── .gitignore        # 虚拟环境、缓存与 IDE 配置的忽略规则
```

## 说明

本仓库目前是一个最小可运行骨架，`main.py` 保留的是 PyCharm 生成的示例代码，
可以直接替换为自己的实现。
