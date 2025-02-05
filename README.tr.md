[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/zahidayturan/okuur-book-tracker-mobile-app/blob/main/README.md)
[![tr](https://img.shields.io/badge/lang-tr-red.svg)](https://github.com/zahidayturan/okuur-book-tracker-mobile-app/blob/main/README.tr.md)


<h1 align="center">OKUUR</h1>
<p align="center"><img src="assets/banner.png"  width=90% height=90%/></p>

Okuur / Dijital Kitaplık ve Kitap Takip Uygulaması

**Bu mobil uygulama [Flutter](https://flutter.dev/) ile geliştirilmiştir**.

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



<style>
  @media (min-width: 800px) {
    .table-container {
      display: flex;
      justify-content: space-between;
    }
    .table-container table {
      width: 47%;
    }
  }


  @media (max-width: 799px) {
    .table-container {
      display: block;
    }
    .table-container table {
      width: 100%;
      margin-bottom: 12px;
    }
  }
</style>

<div class="table-container">
  <table>
    <tr>
      <td colspan="2" style="text-align: center;"><h3>Ana Sayfa</h3></td>
    </tr>
    <tr>
      <td><img src="readmeAssets/HomePageLight.png"></td>
      <td><img src="readmeAssets/HomePageDark.png"></td>
    </tr>
  </table>

  <table>
    <tr>
      <td colspan="2" style="text-align: center;"><h3>İstatistik Sayfası</h3></td>
    </tr>
    <tr>
      <td><img src="readmeAssets/StatisticsLight.png"></td>
      <td><img src="readmeAssets/StatisticsDark.png"></td>
    </tr>
  </table>
</div>


<div class="table-container">
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Kitaplık    Sayfası</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/MyBooksPageLight.png"></td>
        <td><img src="readmeAssets/MyBooksPageDark.png"></td>
      </tr>
    </table>
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Profil Sayfası</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/ProfileLight.png"></td>
        <td><img src="readmeAssets/ProfileDark.png"></td>
      </tr>
    </table>
</div>


<div class="table-container">
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Kitap Ekleme Sayfası</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/AddBookLight.png"></td>
        <td><img src="readmeAssets/AddBookDark.png"></td>
      </tr>
    </table>
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Okuma Ekleme Sayfası</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/AddLogLight.png"></td>
        <td><img src="readmeAssets/AddLogDark.png"></td>
      </tr>
    </table>
</div>

<div class="table-container">
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Kitap Detay Sayfası</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/BookDetailLight.png"></td>
        <td><img src="readmeAssets/BookDetailDark.png"></td>
      </tr>
    </table>
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Okuma Seri Sayfası</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/SeriesLight.png"></td>
        <td><img src="readmeAssets/SeriesDark.png"></td>
      </tr>
    </table>
</div>

<div class="table-container">
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Ayarlar Sayfası</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/SettingsLight.png"></td>
        <td><img src="readmeAssets/SettingsDark.png"></td>
      </tr>
    </table>
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Karşılama Sayfası</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/WelcomePageL.png"></td>
        <td><img src="readmeAssets/WelcomePageD.png"></td>
      </tr>
    </table>
</div>

<div class="table-container">
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Hesap Oluşturma Sayfaları</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/WelcomePage1L.png"></td>
        <td><img src="readmeAssets/WelcomePage2L.png"></td>
      </tr>
    </table>
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Kurulum Sayfaları</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/WelcomePage3L.png"></td>
        <td><img src="readmeAssets/WelcomePage4L.png"></td>
      </tr>
    </table>
</div>

<div class="table-container">
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Okumalar Sayfası</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/AllReadsLight.png"></td>
        <td><img src="readmeAssets/AllReadsDark.png"></td>
      </tr>
    </table>
    <table>
      <tr>
        <td colspan="2" style="text-align: center;"><h3>Okuma Modu Sayfası</h3></td>
      </tr>
      <tr>
        <td><img src="readmeAssets/ReadModePageLight.png"></td>
        <td><img src="readmeAssets/ReadModePageDark.png"></td>
      </tr>
    </table>
</div>


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

