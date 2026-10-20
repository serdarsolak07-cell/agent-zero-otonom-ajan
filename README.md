# Agent Zero Otonom Ajan

**Tamamen yerel çalışan, kendini geliştiren otonom ajan sistemi.**

Agent Zero üzerine kurulu, 16 GB VRAM hedefiyle tasarlanmış, faz faz kurulabilen güvenli otonom ajan çatısı.

> **Tasarım ve geliştirme:** Serdar Kaptan  
> GitHub: [@serdarsolak07-cell](https://github.com/serdarsolak07-cell)

---

## Özellikler

- **Beyin + Beyincik**: Agent Zero + Letta uzun süreli hafıza
- **Eleştirmen & Öğrenci**: Her görevden öğrenme döngüsü
- **Onay Katmanı**: Sessiz veya Aktif mod
- **Acil Durdurma**: Model dışında çalışan bekçi süreci (`DUR` / `STOP`)
- **Kaynak Kontrolü**: Olgusal iddiaları doğrulama
- **Güvenlik sınırları**, sürümleme, sağlık kontrolü
- **8 fazlı** parça parça kurulum
- Tamamen yerel (Ollama / LM Studio), bulut gerektirmez

## Hızlı Kurulum

### Gereksinimler
- Docker
- İsteğe bağlı: Ollama (yerel model için)

### Linux / macOS
```bash
git clone https://github.com/serdarsolak07-cell/agent-zero-otonom-ajan.git
cd agent-zero-otonom-ajan
chmod +x scripts/install.sh
./scripts/install.sh
```

### Windows (PowerShell)
```powershell
git clone https://github.com/serdarsolak07-cell/agent-zero-otonom-ajan.git
cd agent-zero-otonom-ajan
.\scripts\install.ps1
```

Kurulum bitince tarayıcıda aç:

**http://localhost:5080**

Ayarlar → Agent Profile → **otonom** seç.

### Yerel Model
Ollama kurduktan sonra Agent Zero ayarlarında:
- Provider: Ollama
- Base URL: `http://host.docker.internal:11434`

## Fazlar

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

## Acil Durdurma

```bash
python3 phases/06-acil-durdurma/watchdog.py
```

Başka bir terminalden `DUR` veya `STOP` yaz → sistem anında durur. `DEVAM` ile devam eder.

## Lisans ve Katkı

Kişisel kullanım ve öğrenme amaçlıdır.

**Serdar Kaptan** tarafından tasarlanmış ve paylaşılmıştır.

---

*Bu proje Agent Zero açık kaynak çatısı üzerine inşa edilmiştir.*
