[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/zahidayturan/okuur-book-tracker-mobile-app/blob/main/README.md)
[![tr](https://img.shields.io/badge/lang-tr-red.svg)](https://github.com/zahidayturan/okuur-book-tracker-mobile-app/blob/main/README.tr.md)
<h1 align="center">OKUUR</h1>
<p align="center"><img src="assets/banner.png"  width=90% height=90%/></p>

**Okuur / Dijital Kitaplık ve Okuma Takip Uygulaması**

Uygulama, kullanıcılara kitap okuma deneyimlerini daha verimli bir şekilde yönetebilmeleri için çeşitli özellikler sunmaktadır. 

Bu mobil uygulama ile kitaplığınızı dijitale taşıyarak okumlarınızı takip edebilir ve istatistiklerinizi görebilirsiniz. Diğer okurlar ile arkadaş olarak onların ne okuduğunu görebilir ve birlikte okuma yapabilirsiniz. Her okumanızı kayıt ederek okuma serisi yakalayabilirsiniz. Diğer okurların kitaplarını keşfedebilir ve yeni kitapları kitaplığınıza ekleyebilirsiniz.

Dijital kitaplık ve kitap okuma takip uygulması [**Flutter**](https://flutter.dev/) ile geliştirilmiştir. Aydınlık ve karanlık tema içermekte ve dil destekleri için çalışmalar yapılmaktadır. **Figma** ile UI/UX tasarımı yapılmıştır. Uygulama durum yönetimi için **Get** kullanılmıştır.Kullanıcı kimlik doğrulama işlemleri için **Firebase Auth** ve **Google Sign In** paketleri entegre edilmiştir. **Firestore** ile kullanıcı verileri gerçek zamanlı olarak senkronize edilerek, her cihazda tutarlı bir deneyim sunulmaktadır. Kitapların ve diğer dosyaların depolanması için **Firebase Storage** kullanılmıştır.


### Bağımlılıklar (Dependencies)

Bu proje, bir dizi harika açık kaynaklı kütüphane ve paket ile oluşturulmuştur.


* [get](https://pub.dev/packages/get) - Durum yönetimi (uygulama durumu yönetimi için hafif ve verimli)
* [get_storage](https://pub.dev/packages/get_storage) - Durum yönetimi (basit anahtar-değer çiftleri için kalıcı yerel depolama)
* [firebase_core](https://pub.dev/packages/firebase_core) - Firebase ile bağlantı kurmak için Firebase’i başlatmak için gereklidir
* [firebase_auth](https://pub.dev/packages/firebase_auth) - Kullanıcı girişi, kayıt ve kimlik doğrulama işlemleri için Firebase Kimlik Doğrulama
* [cloud_firestore](https://pub.dev/packages/cloud_firestore) - Gerçek zamanlı veritabanı ve veri yönetimi için Firestore
* [firebase_storage](https://pub.dev/packages/firebase_storage) - Dosya yükleme/indirme için Firebase Cloud Storage
* [google_sign_in](https://pub.dev/packages/firebase_messaging) - Firebase Kimlik Doğrulama ile Google ile giriş yapma
* [flutter_localization](https://pub.dev/packages/flutter_localization) - Uygulama içi yerelleştirme (çoklu dil desteği için önemli)
* [intl](https://pub.dev/packages/intl) - Uluslararasılaşma desteği (tarih formatlama, sayı formatlama vb. için faydalı)
* [image_picker](https://pub.dev/packages/image_picker) - Kullanıcıların galeriye resim seçmesine veya kamera ile çekim yapmasına olanak tanır
* [path_provider](https://pub.dev/packages/googleapis_auth) - Cihazın dosya sistemindeki dizinlere erişim sağlar (örneğin, dosya kaydetmek için)
* [cupertino_icons](https://pub.dev/packages/cupertino_icons) - Flutter uygulamalarında kullanmak için iOS tarzı simgeler sağlar
* [shimmer](https://pub.dev/packages/shimmer) - Widget'larınıza shimmer efekti eklemek için bir paket (yükleniyor göstergeleri için iyi)
* [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) - Özel açılış ekranı (uygulama markası ve sorunsuz başlatma için faydalıdır)



<table>
  <tr>
    <td colspan="2"><h3 align="center">Ana Sayfa</h3></td>
  </tr>
  <tr>
    <td align="center"><img src="readmeAssets/HomePageLight.png" width=85%></td>
    <td align="center"><img src="readmeAssets/HomePageDark.png" width=85%></td>
  </tr>
</table>

<table>
  <tr>
    <td colspan="2"><h3 align="center">İstatistik Sayfası</h3></td>
  </tr>
  <tr>
    <td align="center"><img src="readmeAssets/StatisticsLight.png" width=85%></td>
    <td align="center"><img src="readmeAssets/StatisticsDark.png" width=85%></td>
  </tr>
</table>


<table>
  <tr>
    <td><h3 align="center">Kitaplık Sayfası</h3></td>
    <td><h3 align="center">Profil Sayfası</h3></td>
  </tr>
  <tr>
    <td align="center"><img src="readmeAssets/MyBooksPageLight.png" width=85%></td>
    <td align="center"><img src="readmeAssets/ProfileLight.png" width=85%></td>
  </tr>
</table>


<table>
  <tr>
    <td><h3 align="center">Kitap Ekleme Sayfası</h3></td>
    <td><h3 align="center">Okuma Ekleme Sayfası</h3></td>
  </tr>
  <tr>
    <td align="center"><img src="readmeAssets/AddBookLight.png" width=85%></td>
    <td align="center"><img src="readmeAssets/AddLogLight.png" width=85%></td>
  </tr>
</table>

<table>
  <tr>
    <td><h3 align="center">Kitap Detay Sayfası</h3></td>
    <td><h3 align="center">Okumalar Sayfası</h3></td>
  </tr>
  <tr>
    <td align="center"><img src="readmeAssets/BookDetailLight.png" width=85%></td>
    <td align="center"><img src="readmeAssets/AllReadsDark.png" width=85%></td>
  </tr>
</table>

<table>
  <tr>
    <td colspan="2"><h3 align="center">Okuma Seri Sayfası</h3></td>
  </tr>
  <tr>
    <td align="center"><img src="readmeAssets/SeriesLight.png" width=85%></td>
    <td align="center"><img src="readmeAssets/SeriesDark.png" width=85%></td>
  </tr>
</table>


<table>
  <tr>
    <td><h3 align="center">Ayarlar Sayfası</h3></td>
    <td><h3 align="center">Okuma Modu Sayfası</h3></td>
  </tr>
  <tr>
    <td align="center"><img src="readmeAssets/SettingsLight.png" width=85%></td>
    <td align="center"><img src="readmeAssets/ReadModePageDark.png" width=85%></td>
  </tr>
</table>

<table>
  <tr>
    <td colspan="2"><h3 align="center">Karşılama Sayfası</h3></td>
  </tr>
  <tr>
    <td align="center"><img src="readmeAssets/WelcomePageL.png" width=85%></td>
    <td align="center"><img src="readmeAssets/WelcomePageD.png" width=85%></td>
  </tr>
</table>


<table>
  <tr>
    <td colspan="2"><h3 align="center">Hesap Oluşturma Sayfaları</h3></td>
  </tr>
  <tr>
    <td align="center"><img src="readmeAssets/WelcomePage1L.png" width=85%></td>
    <td align="center"><img src="readmeAssets/WelcomePage2L.png" width=85%></td>
  </tr>
</table>

<table>
  <tr>
    <td colspan="2"><h3 align="center">Kurulum Sayfaları</h3></td>
  </tr>
  <tr>
    <td align="center"><img src="readmeAssets/WelcomePage3L.png" width=85%></td>
    <td align="center"><img src="readmeAssets/WelcomePage4L.png" width=85%></td>
  </tr>
</table>


### Kurulum
```sh
$ pub get
```
**TODO**

## Geliştiricilere Nasıl Destek Olabilirim?
- GitHub repo'muza yıldız verin
- Pull request'ler oluşturun, hata bildirin, yeni özellikler veya dokümantasyon güncellemeleri önerin
- Çalışmalarımızı takip edin

## Başlarken

Bu proje, bir Flutter uygulaması için bir başlangıç noktasıdır.

Eğer bu sizin ilk Flutter projenizse, başlamak için bazı kaynaklar:

- [Laboratuvar: İlk Flutter uygulamanızı yazın](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Kullanışlı Flutter örnekleri](https://flutter.io/docs/cookbook)

Flutter ile başlamak için yardıma ihtiyacınız varsa,
[çevrimiçi dokümantasyona](https://flutter.io/docs), göz atabilirsiniz. Bu dokümantasyon, eğitimler, örnekler, mobil geliştirme ile ilgili rehberlik ve tam API referansı sunmaktadır.

