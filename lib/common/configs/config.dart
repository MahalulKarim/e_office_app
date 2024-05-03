class Config {
  static const base1 = 'https://app.eoffice.my.id/';
  // static const base1 = "http://192.168.40.19/eoffice_web/";
  // ganti API

  static const baseUrl = '${base1}xapi/v2/';
  static const baseUrlp = '${base1}xapi/';
  static const baseUrlLogoSponsor = '${base1}assets/images/logo_sponsor/';
  static const baseUrlToko = '${base1}assets/images/toko/logo/';
  static const baseUrlThumbnails = '${base1}assets/images/thumbnail/';
  static const baseUrlThumb = '${base1}assets/images/thumbnail/thumb/';
  static const baseUrlIconNew = '${base1}assets/images/icon/';
  static const baseUrlCarousel = '${base1}assets/images/carousel/5/';
  static const baseUrlAds = '${base1}assets/images/iklan_samping/';
  static const baseUrlCarouselSponsor =
      '${base1}assets/images/carousel_sponsor/';

  static const baseUrlv3 = '${base1}xapi/v3/';

  static const baseUrlArtikel = "https://diengcyber.com/wp-json/wp/v2";

  static const baseUrlOffice = "https://app.eoffice.my.id";
  // static const baseUrlOffice = "http://192.168.40.19/eoffice_web";

  static String idKantor = "id_kantor";
  static String namaKantor = "nama_kantor";

  static void setIdKantor(String newIdKantor) {
    idKantor = newIdKantor;
  }

  static void setNamaKantor(String newNamaKantor) {
    namaKantor = newNamaKantor;
  }
}
