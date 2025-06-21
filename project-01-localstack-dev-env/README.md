# 🧪 LocalStack Dev Environment

LocalStack is a super useful tool for development and testing environments that emulates AWS services locally. It lets you develop and test apps that rely on AWS services without needing to connect to the real cloud. This saves costs, speeds up development, and allows you to work offline.

Basically, LocalStack acts as a local AWS mock that responds to the same APIs you’d use with the official SDK or CLI.

---

## 🔗 Resources

- 🌐 Official site: [https://localstack.cloud](https://localstack.cloud)  
- 🐙 GitHub: [https://github.com/localstack/localstack](https://github.com/localstack/localstack)  
- 📚 Documentation: [https://docs.localstack.cloud](https://docs.localstack.cloud)  

---

## 🧰 LocalStack Resource Requirements (Windows)

| Resource             | Recommended                          | Notes                                                                 |
|----------------------|--------------------------------------|-----------------------------------------------------------------------|
| **CPU**              | 4 cores or more                      | Docker runs multiple services simultaneously. 2 cores may work but will be slow. |
| **RAM**              | Minimum 8 GB, ideally 16 GB          | LocalStack + Docker + your code editor (VSCode, etc.) + browser can use a lot of memory. |
| **Storage**          | ~2 GB minimum                        | Docker images are ~1–1.5 GB. LocalStack stores logs and volumes if persistence is enabled. |
| **Operating System** | Windows 10/11 with WSL2              | ✅ *Virtual Machine Platform* and ✅ *Windows Subsystem for Linux* must be **checked in "Windows Features"**. |
| **Docker Desktop**   | Latest version (with WSL2 backend)   | Handles container runtime, WSL2 integration, and networking on Windows. |

---

## 📦 Setup (Coming Soon)

Instructions for installing WSL2, Docker Desktop, and running LocalStack will be added here.

---

## 📝 License

MIT (or add your preferred license here).
