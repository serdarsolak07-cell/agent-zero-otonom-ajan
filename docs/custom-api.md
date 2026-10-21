# Custom API Setup / Özel API Kurulumu

**Serdar Kaptan**

This guide shows how to connect your OpenAI-compatible API  
(Cloudflare tunnel + Unsloth/Qwen model) to Agent Zero.

Bu rehber, OpenAI uyumlu API'nizi  
(Cloudflare tüneli + Unsloth/Qwen modeli) Agent Zero'ya nasıl bağlayacağınızı anlatır.

---

## English

### Your API Details
- **Base URL**: `YOUR_TUNNEL_URL/v1`
- **API Key**: `sk-unsloth-YOUR_KEY` (replace with your real key)
- **Model**: `your-model-name`

### Method 1 — UI (Recommended)

1. Open Agent Zero Web UI → **Settings → Models** (or Edit Model Presets).
2. For **Main** model (and Utility if you want):
   - Provider: **Other OpenAI compatible**  
     (or use the Custom Providers plugin **+** button if available)
   - Model name: `your-model-name`
   - API Base URL: `YOUR_TUNNEL_URL/v1`
   - API Key: `sk-unsloth-YOUR_KEY`
3. In **Advanced → Additional Parameters** add (if you get LiteLLM errors):
   ```
   a0_api_mode=chat_completions
   ```
4. Save and test with a short message.

### Method 2 — Python Test (outside Agent Zero)
```python
from openai import OpenAI

client = OpenAI(
    base_url="YOUR_TUNNEL_URL/v1",
    api_key="sk-unsloth-YOUR_KEY",
)

response = client.chat.completions.create(
    model="your-model-name",
    messages=[{"role": "user", "content": "What is Unsloth?"}],
    stream=True,
)

for chunk in response:
    print(chunk.choices[0].delta.content or "", end="")
```

### Notes
- The Cloudflare URL is temporary. When it changes, update the Base URL in Agent Zero.
- Do not hardcode the real API key in files. Enter it only in the UI or environment variables.
- If the model list does not load, type the model name manually.

---

## Türkçe

### API Bilgilerin
- **Base URL**: `YOUR_TUNNEL_URL/v1`
- **API Key**: `sk-unsloth-YOUR_KEY` (gerçek anahtarınla değiştir)
- **Model**: `your-model-name`

### Yöntem 1 — Arayüz (Tavsiye edilen)

1. Agent Zero Web UI → **Ayarlar → Models** (veya Edit Model Presets) aç.
2. **Main** model (ve istersen Utility) için:
   - Provider: **Other OpenAI compatible**
   - Model name: `your-model-name`
   - API Base URL: `YOUR_TUNNEL_URL/v1`
   - API Key: `sk-unsloth-YOUR_KEY`
3. Hata alırsan **Advanced → Additional Parameters** kısmına ekle:
   ```
   a0_api_mode=chat_completions
   ```
4. Kaydet ve kısa bir mesajla test et.

### Notlar
- Cloudflare adresi geçici. Değişince Agent Zero'da Base URL'yi güncelle.
- Gerçek API anahtarını dosyalara yazma. Sadece arayüzden veya ortam değişkeninden gir.
- Model listesi gelmezse model adını elle yaz.

---

**Serdar Kaptan**
