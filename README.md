# Agent Zero Autonomous Agent / Agent Zero Otonom Ajan

**A fully local, self-improving autonomous agent system.**  
**Tamamen yerel çalışan, kendini geliştiren otonom ajan sistemi.**

Built on Agent Zero. Designed for 16 GB VRAM. Installed in phases. Safe and modular.  
Agent Zero üzerine kurulu. 16 GB VRAM hedefiyle tasarlanmış. Faz faz kurulabilen güvenli otonom ajan çatısı.

> **Design & Development / Tasarım ve Geliştirme:** Serdar Kaptan  
> GitHub: [@serdarsolak07-cell](https://github.com/serdarsolak07-cell)

---

## English

### Features
- **Brain + Cerebellum**: Agent Zero + Letta long-term memory
- **Critic & Student**: Learning loop after every task
- **Approval Layer**: Silent or Active mode
- **Emergency Stop**: Watchdog process outside the model (`DUR` / `STOP`)
- **Source Check**: Verification of factual claims
- **Security boundaries**, versioning, health checks
- **8-phase** incremental setup
- Fully local (Ollama / LM Studio) or custom OpenAI-compatible API

### Quick Start

**Requirements**
- Docker
- Optional: Ollama (for local models) or your own OpenAI-compatible endpoint

**Linux / macOS**
```bash
git clone https://github.com/serdarsolak07-cell/agent-zero-otonom-ajan.git
cd agent-zero-otonom-ajan
chmod +x scripts/install.sh
./scripts/install.sh
```

**Windows (PowerShell)**
```powershell
git clone https://github.com/serdarsolak07-cell/agent-zero-otonom-ajan.git
cd agent-zero-otonom-ajan
.\scripts\install.ps1
```

After installation open:

**http://localhost:5080**

Go to Settings → Agent Profile → select **otonom**.

**Local Model (Ollama)**  
- Provider: Ollama  
- Base URL: `http://host.docker.internal:11434`

**Custom OpenAI-compatible API**  
See full guide: [docs/custom-api.md](docs/custom-api.md)  
Example (Cloudflare + Qwen):
- Provider: Other OpenAI compatible
- Base URL: `YOUR_TUNNEL_URL/v1`
- Model: `your-model-name`
- API Key: your `sk-unsloth-...` key

### Phases
The system is installed in 8 phases. See the `phases/` folder.

| Phase | Content |
|-------|---------|
| 1 | Brain and Cerebellum |
| 2 | Critic, Student, Approval Layer |
| 3 | Sleep node |
| 4 | Security, health, versioning |
| 5 | Source Check and context reset |
| 6 | Emergency Stop (watchdog) |
| 7 | Web UI and Settings |
| 8 | Voice layer |

### Emergency Stop
```bash
python3 phases/06-acil-durdurma/watchdog.py
```
From another terminal type `DUR` or `STOP` → the system pauses immediately. Type `DEVAM` to resume.

---

## Türkçe

### Özellikler
- **Beyin + Beyincik**: Agent Zero + Letta uzun süreli hafıza
- **Eleştirmen & Öğrenci**: Her görevden öğrenme döngüsü
- **Onay Katmanı**: Sessiz veya Aktif mod
- **Acil Durdurma**: Model dışında çalışan bekçi süreci (`DUR` / `STOP`)
- **Kaynak Kontrolü**: Olgusal iddiaları doğrulama
- **Güvenlik sınırları**, sürümleme, sağlık kontrolü
- **8 fazlı** parça parça kurulum
- Tamamen yerel (Ollama / LM Studio) veya özel OpenAI uyumlu API

### Hızlı Kurulum

**Gereksinimler**
- Docker
- İsteğe bağlı: Ollama (yerel model) veya kendi OpenAI uyumlu endpoint'in

**Linux / macOS**
```bash
git clone https://github.com/serdarsolak07-cell/agent-zero-otonom-ajan.git
cd agent-zero-otonom-ajan
chmod +x scripts/install.sh
./scripts/install.sh
```

**Windows (PowerShell)**
```powershell
git clone https://github.com/serdarsolak07-cell/agent-zero-otonom-ajan.git
cd agent-zero-otonom-ajan
.\scripts\install.ps1
```

Kurulum bitince tarayıcıda aç:

**http://localhost:5080**

Ayarlar → Agent Profile → **otonom** seç.

**Yerel Model (Ollama)**  
- Provider: Ollama  
- Base URL: `http://host.docker.internal:11434`

**Özel OpenAI uyumlu API**  
Detaylı rehber: [docs/custom-api.md](docs/custom-api.md)  
Örnek (Cloudflare + Qwen):
- Provider: Other OpenAI compatible
- Base URL: `YOUR_TUNNEL_URL/v1`
- Model: `your-model-name`
- API Key: `sk-unsloth-...` anahtarın

### Fazlar
Sistem 8 fazda kurulur. Detaylar `phases/` klasöründe.

| Faz | İçerik |
|-----|--------|
| 1 | Beyin ve Beyincik |
| 2 | Eleştirmen, Öğrenci, Onay Katmanı |
| 3 | Uyku düğümü |
| 4 | Güvenlik, sağlık, sürümleme |
| 5 | Kaynak Kontrolü ve bağlam sıfırlama |
| 6 | Acil Durdurma (bekçi) |
| 7 | Web arayüzü ve Ayarlar |
| 8 | Sesli katman |

### Acil Durdurma
```bash
python3 phases/06-acil-durdurma/watchdog.py
```
Başka bir terminalden `DUR` veya `STOP` yaz → sistem anında durur. `DEVAM` ile devam eder.

---

## License / Lisans

Personal use and learning.  
Kişisel kullanım ve öğrenme amaçlıdır.

**Designed and shared by Serdar Kaptan.**  
**Serdar Kaptan** tarafından tasarlanmış ve paylaşılmıştır.

---

*Built on the open-source Agent Zero framework.*  
*Bu proje Agent Zero açık kaynak çatısı üzerine inşa edilmiştir.*
