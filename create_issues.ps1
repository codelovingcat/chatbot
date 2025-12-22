# PowerShell script to create GitHub issues using gh CLI

gh issue create --title "Core/config ve core/utils klasörlerinin boş dosyalarıyla birlikte hazırlanması" --label "todo" --body ""

gh issue create --title "Domain katmanında users, chatbot ve mentors paketlerinin oluşturulması" --label "todo" --body ""

gh issue create --title "Application/services içinde temel service iskeletinin eklenmesi" --label "todo" --body ""

gh issue create --title "Infrastructure/orm, infrastructure/api ve infrastructure/ai klasörlerinin eklenmesi" --label "todo" --body ""

gh issue create --title "main.py dosyasına FastAPI başlangıç kodunun eklenmesi" --label "todo" --body ""

gh issue create --title "React frontend klasör yapısının oluşturulması" --label "todo" --body ""

gh issue create --title "src/components/Chat klasöründe ChatWindow, ChatMessage ve ChatInput componentlerinin oluşturulması" --label "todo" --body ""

gh issue create --title "API client için services/apiClient.js dosyasının hazırlanması" --label "todo" --body ""

gh issue create --title "ChatContext'in oluşturulması" --label "todo" --body ""

gh issue create --title "Login ve Chatbot sayfalarının minimal iskeletlerinin eklenmesi" --label "todo" --body ""

$body1 = @"
Amaç:
Basit kullanıcı kayıt ve giriş akışını sağlayacak /auth/register ve /auth/login endpointlerini oluşturmak.

Kabul Kriterleri:
- /auth/register POST: email, password alır; basit doğrulama yapar; memory-based store'a ekler.
- /auth/login POST: email, password alır; doğrulama başarılıysa basit success JSON döner.
- Parolalar plaintext depolanmaz (basit hash kullanımı önerilir, örnek: werkzeug veya hashlib).

Adımlar/Implementation:
1) backend/application/services içinde AuthService iskeleti oluştur.
2) backend/domain/users modeline temel alanlar ekle (email, password_hash, id, created_at).
3) backend/infrastructure/api içine auth_router ekle ve iki endpointi tanımla.
4) Basit in-memory store (dictionary) kullan; ileride DB ile replace edilecek.

Notlar:
- Bu aşamada token/JWT gerekmiyor; ileride ekleyeceğiz.
- Error handling ve uygun HTTP status kodlarını kullan.
"@

gh issue create --title "AuthService: Register & Login endpoints (basic)" --label "todo" --body $body1

$body2 = @"
Amaç:
User entity/modelini ve transfer objelerini (DTO) tanımlamak.

Kabul Kriterleri:
- backend/domain/users içinde User dataclass veya pydantic model hazırlanmış.
- DTO'lar: UserCreate, UserRead (göndermek için) tanımlı.

Adımlar/Implementation:
1) backend/domain/users/models.py oluştur: User, UserCreate, UserRead.
2) Fieldler: id (uuid), email, password_hash, role, created_at.
3) Basit örnek unit test veya docstring ile modelin kullanılabilirliği gösterilsin.

Notlar:
- Pydantic kullanımı tercih edilir (FastAPI ile uyumlu).
"@

gh issue create --title "User domain: User model + DTOs" --label "todo" --body $body2

$body3 = @"
Amaç:
Chatbot için sendMessage fonksiyonunun temel iskeletini oluşturmak; şimdilik LLM bağlı değil, placeholder cevap dönecek.

Kabul Kriterleri:
- backend/application/services/chatbot_service.py içinde send_message(user_id, message) fonksiyonu var.
- Fonksiyon gelen mesajı loglayıp: "Mesaj alındı: <mesaj>" şeklinde dönüş sağlıyor.

Adımlar/Implementation:
1) servis sınıfı iskeleti oluştur (class ChatbotService).
2) send_message fonksiyonu implement edilsin.
3) Test endpoint ile entegre edilecek (/chat/send).

Notlar:
- İleride OpenAI/Supabase bağlanınca bu fonksiyon genişletilecek.
"@

gh issue create --title "ChatbotService: sendMessage skeleton" --label "todo" --body $body3

$body4 = @"
Amaç:
Frontend'in mesaj gönderip bot cevabı alabileceği basit endpoint.

Kabul Kriterleri:
- POST /chat/send JSON alır: { "user_id": "...", "message": "..." }
- Endpoint ChatbotService.send_message çağırır ve returned cevabı JSON döner.

Adımlar/Implementation:
1) backend/infrastructure/api/chat_router.py oluştur.
2) router'a /chat/send endpoint ekle.
3) Endpoint validate için pydantic model kullan (ChatRequest).
4) Return format: { "reply": "..." }

Notlar:
- Hata durumlarında 4xx/5xx uygun dönüşler verilsin.
"@

gh issue create --title "API endpoint: POST /chat/send (basic)" --label "todo" --body $body4

$body5 = @"
Amaç:
React Login sayfasını backend auth endpointine bağlamak: form verisi POST ile gönderilecek ve sonuç işlenecek.

Kabul Kriterleri:
- src/pages/Login.jsx formu çalışır durumda.
- Submit ile /auth/login çağrılır (fetch/axios) ve gelen response UI'da gösterilir.

Adımlar/Implementation:
1) src/pages/Login.jsx içinde form hazırlansın (email, password).
2) services/apiClient.js üzerinden login isteği atılsın.
3) Başarılı/başarısız durumlar kullanıcıya gösterilsin.

Notlar:
- Gerçek auth yoksa mock success response kabul edilir.
"@

gh issue create --title "Frontend: Login page functional (basic API hookup)" --label "todo" --body $body5

$body6 = @"
Amaç:
Chat arayüzünden gönderilen mesajın backend /chat/send endpointine ulaşması ve dönen cevabın ekranda gösterilmesi.

Kabul Kriterleri:
- ChatInput'tan gönderilen mesaj backend'e POST edilir.
- Dönen "reply" mesaj ChatWindow'da görünür.

Adımlar/Implementation:
1) src/components/Chat/ChatInput.jsx gönderme fonksiyonunu apiClient kullanacak şekilde düzenle.
2) ChatWindow mesaj listesine backend cevabını push et.
3) Loading state (isLoading) göster.

Notlar:
- Hatalı isteklerde kullanıcıya uyarı verilsin.
"@

gh issue create --title "Frontend: ChatWindow -> sends message to backend" --label "todo" --body $body6

$body7 = @"
Amaç:
Uygulama genelinde chat mesajlarını yönetecek context ve sendMessage fonksiyonunun oluşturulması.

Kabul Kriterleri:
- src/context/ChatContext.jsx içinde context sağlanıyor.
- messages dizisi, sendMessage fonksiyonu ve isLoading state mevcut.

Adımlar/Implementation:
1) ChatContext wrapper oluştur ve App'e sar.
2) sendMessage fonksiyonu backend çağrısını yapıp messages'a eklesin.
3) Child componentler (ChatWindow vb.) context konsumeli şekilde çalışsın.

Notlar:
- State yönetimi basit React Context ile yapılacak; ileride Zustand vb. eklenebilir.
"@

gh issue create --title "ChatContext: global state for messages & sendMessage()" --label "todo" --body $body7

$body8 = @"
Amaç:
Mesaj baloncuklarının görsel düzeni: kullanıcı/bot ayrımı, timestamp gösterimi.

Kabul Kriterleri:
- src/components/Chat/ChatMessage.jsx içinde kullanıcı mesajı sağda, bot sol taraf.
- Mesaj metni ve saat bilgisi gösterilsin.

Adımlar/Implementation:
1) ChatMessage component layout tasarlanacak (CSS sınıfları kullanılarak).
2) timestamp formatlanıp gösterilecek (örn. HH:MM).
3) Responsive davranış test edilecek.

Notlar:
- Stil için mevcut styles/global.css kullanılacak.
"@

gh issue create --title "UI: MessageBubble component düzenlemesi" --label "todo" --body $body8

$body9 = @"
Amaç:
OpenAI/LLM entegrasyonu için altyapı dosyası oluşturmak; fakat bu aşamada gerçek anahtar yok, sadece iskelet.

Kabul Kriterleri:
- backend/infrastructure/ai/openai_client.py oluşturulsun.
- Class OpenAIClient { def send(self, message): return "LLM not connected" }

Adımlar/Implementation:
1) Dosya ve sınıf iskeleti yazılsın.
2) ChatbotService bu client ile entegre edilmeye hazır olsun (dependency injection).

Notlar:
- Gerçek anahtarlar .env dosyasına eklenecek, bu issue scope'unda değildir.
"@

gh issue create --title "Infrastructure: OpenAI client skeleton (no keys yet)" --label "todo" --body $body9

$body10 = @"
Amaç:
Proje için örnek environment dosyaları oluşturmak; geliştiricilerin hangi değişkenleri dolduracaklarını bilmeleri amaçlanıyor.

Kabul Kriterleri:
- backend/.env.example ve frontend/.env.example dosyaları eklenmiş.
- İçerik: BACKEND_PORT, API_URL, DATABASE_URL (placeholder), FIREBASE_DB_URL (placeholder), VITE_API_URL vb.

Adımlar/Implementation:
1) backend/.env.example dosyasını oluştur ve gerekli anahtar isimlerini ekle.
2) frontend/.env.example (Vite veya CRA kullanıyorsan REACT_APP_ prefix) ekle.
3) README'ye environment setup adımı kısa not olarak ekle.

Notlar:
- Gerçek secretlar asla repo'ya pushlanmasın; GitHub Secrets veya hosting secrets kullanılacak.
"@

gh issue create --title ".env.example dosyalarının oluşturulması (backend + frontend)" --label "todo" --body $body10

gh issue create --title "Backend: Environment (.env) ve config yönetiminin netleştirilmesi" --label "backend,config,phase-2" --body "Backend tarafında environment yönetimi yapılacak. .env örneği oluşturulacak, config değerleri (DB_URL, API_KEYS vb.) merkezi bir yapıdan okunacak. Güvenli olmayan değerler repoya girmeyecek. FastAPI config pattern uygulanacak."

gh issue create --title "Backend: Supabase bağlantısının kurulması (DB + Auth hazırlığı)" --label "backend,database,phase-2" --body "Supabase projesi oluşturulacak. Backend tarafında Supabase client entegre edilecek. Şimdilik sadece bağlantı ve test endpointi yazılacak. CRUD yok, sadece bağlantı doğrulama."

gh issue create --title "Backend: User modeli ve temel user schema'larının oluşturulması" --label "backend,domain,phase-2" --body "Domain/users altında User entity ve Pydantic schema'lar (CreateUser, UserResponse vb.) oluşturulacak. Auth henüz bağlanmayacak, sadece modelleme yapılacak."

gh issue create --title "Backend: Chatbot için ilk API endpoint'inin hazırlanması" --label "backend,api,phase-2" --body "Chatbot için basit bir POST endpoint oluşturulacak. Request olarak mesaj alacak, response olarak şimdilik sabit veya mock bir cevap dönecek. Amaç frontend-backend bağlantısını test etmek."

gh issue create --title "Frontend: API client ile backend'e bağlanan ilk chat isteği" --label "frontend,api,phase-2" --body "Frontend'de apiClient kullanılarak backend chatbot endpoint'ine istek atılacak. Response console.log veya basit state ile ekrana yazdırılacak."

gh issue create --title "Frontend: ChatWindow bileşeninin state ve message akışıyla güçlendirilmesi" --label "frontend,ui,phase-2" --body "ChatWindow component'i message state tutacak hale getirilecek. Kullanıcı mesajı ve bot mesajı ayrı ayrı render edilecek. Stil minimal olabilir."

gh issue create --title "Frontend: ChatInput submit -> API çağrısı -> response akışı" --label "frontend,logic,phase-2" --body "ChatInput submit edildiğinde backend'e mesaj gönderilecek. Gelen response ChatWindow'da gösterilecek. Loading durumu eklenebilir."

gh issue create --title "Auth hazırlığı: Login sayfası için dummy akış oluşturulması" --label "frontend,auth,phase-2" --body "Login sayfasında gerçek auth olmadan dummy login akışı kurulacak. Amaç routing, context ve kullanıcı state'inin test edilmesi."

gh issue create --title "Frontend: Global kullanıcı state (AuthContext) oluşturulması" --label "frontend,context,phase-2" --body "AuthContext oluşturulacak. Kullanıcı bilgisi, login/logout fonksiyonları burada tutulacak. Şimdilik fake data ile çalışabilir."

gh issue create --title "Proje genel temizlik: README güncelleme ve çalışma adımlarının yazılması" --label "docs,cleanup,phase-2" --body "README.md güncellenecek. Backend nasıl çalıştırılır, frontend nasıl ayağa kaldırılır, env örneği nedir adım adım yazılacak."

Write-Host "All sprint-2 issues created."
