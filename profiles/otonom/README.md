# Otonom Ajan Profili

**Serdar Kaptan** tarafından tasarlanmış Agent Zero profili.

Bu profil, sistem promptundaki otonom ajan kurallarını uygular.

Kullanım:
1. Web UI'da Agent Profile olarak "otonom" seçin.
2. Yerel model ayarlarını yapın: http://host.docker.internal:11434

Tam sistem promptu (v18) bu profil klasöründeki `prompts/agent.system.main.specifics.md` dosyasındadır.
Agent Zero bu dosyayı kendi `agent.system.main.md` şablonuna dahil eder; böylece araç kullanım talimatları korunur.
Konteyner içindeki yolu: `/a0/usr/agents/otonom/prompts/agent.system.main.specifics.md`
