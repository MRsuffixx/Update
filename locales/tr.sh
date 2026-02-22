#!/usr/bin/env bash
# ============================================================================
# locales/tr.sh — Türkçe Dil Paketi
# ============================================================================
# Gelişmiş Sistem Güncelleme Script'i için Türkçe çeviri dosyası.
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# GENEL / BAŞLIK
# ──────────────────────────────────────────────────────────────────────────────
MSG_WELCOME="Gelişmiş Sistem Güncelleyiciye Hoş Geldiniz"
MSG_VERSION="Sürüm"
MSG_AUTHOR="Yazar"
MSG_LICENSE="Lisans"
MSG_REPO="Depo"
MSG_SEPARATOR="══════════════════════════════════════════════════════════════════════════"
MSG_THIN_SEP="──────────────────────────────────────────────────────────────────────────"
MSG_STARTING="Sistem güncelleme işlemi başlatılıyor..."
MSG_COMPLETED="Tüm işlemler başarıyla tamamlandı!"
MSG_ABORTED="İşlem kullanıcı tarafından iptal edildi."
MSG_FAILED="İşlem BAŞARISIZ. Detaylar için logu kontrol edin."
MSG_TIMESTAMP="Zaman damgası"
MSG_HOSTNAME="Sunucu adı"
MSG_ELAPSED_TIME="Toplam geçen süre"
MSG_PRESS_ENTER="Devam etmek için [Enter] tuşuna basın..."
MSG_YES="e"
MSG_NO="h"
MSG_YES_FULL="evet"
MSG_NO_FULL="hayır"
MSG_LOADING="Yükleniyor..."
MSG_PLEASE_WAIT="Lütfen bekleyin..."
MSG_DONE="Tamam"
MSG_SKIPPED="Atlandı"
MSG_OK="Tamam"
MSG_CANCEL="İptal"

# ──────────────────────────────────────────────────────────────────────────────
# ROOT / İZİNLER
# ──────────────────────────────────────────────────────────────────────────────
MSG_ROOT_CHECK="Root yetkileri kontrol ediliyor..."
MSG_ROOT_ERROR="HATA: Bu script root olarak çalıştırılmalıdır!"
MSG_ROOT_HINT="Şu şekilde çalıştırmayı deneyin: sudo $0"
MSG_ROOT_OK="Root yetkileri ile çalışıyor."

# ──────────────────────────────────────────────────────────────────────────────
# KİLİT DOSYASI
# ──────────────────────────────────────────────────────────────────────────────
MSG_LOCK_ACQUIRED="Kilit alındı. Devam ediliyor..."
MSG_LOCK_EXISTS="Bu script'in başka bir örneği zaten çalışıyor!"
MSG_LOCK_PID="Çalışan örneğin PID'i"
MSG_LOCK_STALE="Eski kilit dosyası tespit edildi, kaldırılıyor..."
MSG_LOCK_WAIT="Mevcut örneğin bitmesi bekleniyor..."
MSG_LOCK_TIMEOUT="Kilit bekleme süresi doldu. Çıkılıyor."

# ──────────────────────────────────────────────────────────────────────────────
# SSH UYARISI
# ──────────────────────────────────────────────────────────────────────────────
MSG_SSH_DETECTED="SSH oturumu tespit edildi!"
MSG_SSH_WARNING="UYARI: Bu script'i SSH üzerinden çalıştırıyorsunuz."
MSG_SSH_WARNING_DETAIL="Dağıtım yükseltmesi SSH bağlantınızın kopmasına neden olabilir."
MSG_SSH_WARNING_ADVICE="Bu işlemi screen/tmux oturumunda çalıştırmanız önerilir."
MSG_SSH_WARNING_SCREEN="Şunu çalıştırmayı düşünün: screen -S upgrade  veya  tmux new -s upgrade"
MSG_SSH_CONTINUE="Yine de devam etmek istiyor musunuz?"

# ──────────────────────────────────────────────────────────────────────────────
# İŞLETİM SİSTEMİ TESPİTİ
# ──────────────────────────────────────────────────────────────────────────────
MSG_DETECTING_OS="İşletim sistemi tespit ediliyor..."
MSG_OS_DETECTED="İşletim sistemi tespit edildi"
MSG_OS_NAME="Dağıtım"
MSG_OS_VERSION="Sürüm"
MSG_OS_CODENAME="Kod adı"
MSG_OS_ARCH="Mimari"
MSG_OS_KERNEL="Çekirdek"
MSG_OS_UPTIME="Çalışma süresi"
MSG_OS_UNSUPPORTED="HATA: Desteklenmeyen işletim sistemi!"
MSG_OS_SUPPORTED_LIST="Desteklenen dağıtımlar"
MSG_OS_VERSION_TOO_OLD="HATA: İşletim sistemi sürümünüz bu script için çok eski."
MSG_OS_VERSION_LATEST="Sisteminiz zaten desteklenen en son sürümde."
MSG_OS_RELEASE_FILE="/etc/os-release bulunamadı. İşletim sistemi tespit edilemiyor."

# ──────────────────────────────────────────────────────────────────────────────
# SİSTEM BİLGİSİ
# ──────────────────────────────────────────────────────────────────────────────
MSG_SYSINFO_HEADER="Sistem Bilgisi"
MSG_SYSINFO_RAM="Toplam RAM"
MSG_SYSINFO_DISK_ROOT="/ disk alanı"
MSG_SYSINFO_DISK_FREE="Boş disk alanı"
MSG_SYSINFO_DISK_USED="Kullanılan disk alanı"
MSG_SYSINFO_CPU="İşlemci"
MSG_SYSINFO_CORES="İşlemci Çekirdekleri"
MSG_SYSINFO_LOAD="Yük ortalaması"
MSG_SYSINFO_VIRTUAL="Sanallaştırma"
MSG_SYSINFO_VIRTUAL_YES="Sanal makine içinde çalışıyor"
MSG_SYSINFO_VIRTUAL_NO="Fiziksel donanım üzerinde çalışıyor"
MSG_SYSINFO_PACKAGES="Yüklü paketler"
MSG_SYSINFO_UPGRADABLE="Güncellenebilir paketler"

# ──────────────────────────────────────────────────────────────────────────────
# DİSK ALANI
# ──────────────────────────────────────────────────────────────────────────────
MSG_DISK_CHECK="Disk alanı kontrol ediliyor..."
MSG_DISK_SUFFICIENT="Yeterli disk alanı mevcut."
MSG_DISK_WARNING="UYARI: Düşük disk alanı tespit edildi!"
MSG_DISK_ERROR="HATA: İşleme devam etmek için yeterli disk alanı yok!"
MSG_DISK_REQUIRED="Minimum gerekli"
MSG_DISK_AVAILABLE="Mevcut"
MSG_DISK_DETAIL="Disk kullanım detayları:"
MSG_DISK_CLEAN_SUGGESTION="Alan açmak için önce temizlik yapmayı düşünün."

# ──────────────────────────────────────────────────────────────────────────────
# AĞ
# ──────────────────────────────────────────────────────────────────────────────
MSG_NETWORK_CHECK="Ağ bağlantısı kontrol ediliyor..."
MSG_NETWORK_OK="Ağ bağlantısı doğrulandı."
MSG_NETWORK_FAIL="HATA: Ağ bağlantısı tespit edilemedi!"
MSG_NETWORK_FAIL_DETAIL="Depo sunucularına ulaşılamıyor."
MSG_NETWORK_RETRY="Yeniden deneniyor... (Deneme %d / %d)"
MSG_NETWORK_DNS_CHECK="DNS çözümleme kontrol ediliyor..."
MSG_NETWORK_DNS_OK="DNS çözümleme çalışıyor."
MSG_NETWORK_DNS_FAIL="UYARI: DNS çözümleme başarısız!"

# ──────────────────────────────────────────────────────────────────────────────
# YEDEKLEME
# ──────────────────────────────────────────────────────────────────────────────
MSG_BACKUP_HEADER="Yedekleme İşlemi"
MSG_BACKUP_START="Sistem yedeği oluşturuluyor..."
MSG_BACKUP_SOURCES="sources.list yedekleniyor..."
MSG_BACKUP_SOURCES_DONE="sources.list başarıyla yedeklendi."
MSG_BACKUP_DPKG="dpkg paket anlık görüntüsü oluşturuluyor..."
MSG_BACKUP_DPKG_DONE="dpkg anlık görüntüsü kaydedildi."
MSG_BACKUP_ARCHIVE="Yedek arşivi oluşturuluyor..."
MSG_BACKUP_ARCHIVE_DONE="Yedek arşivi oluşturuldu."
MSG_BACKUP_DIR_CREATE="Yedek dizini oluşturuluyor: %s"
MSG_BACKUP_ESTIMATING="Yedek boyutu tahmin ediliyor..."
MSG_BACKUP_SIZE="Tahmini yedek boyutu"
MSG_BACKUP_SIZE_WARNING="UYARI: Yedek boyutu maksimum eşiği aşıyor!"
MSG_BACKUP_SIZE_CONFIRM="Yedeklemeye devam etmek istiyor musunuz?"
MSG_BACKUP_DISK_SPACE="Yedek hedefi disk alanı kontrol ediliyor..."
MSG_BACKUP_DISK_FAIL="HATA: Yedek hedefinde yeterli alan yok!"
MSG_BACKUP_SKIP="Yapılandırmaya göre yedekleme atlanıyor."
MSG_BACKUP_SUCCESS="Yedekleme başarıyla tamamlandı!"
MSG_BACKUP_FAIL="HATA: Yedekleme başarısız!"
MSG_BACKUP_LOCATION="Yedek şuraya kaydedildi"
MSG_BACKUP_VERIFY="Yedek bütünlüğü doğrulanıyor..."
MSG_BACKUP_VERIFY_OK="Yedek bütünlüğü doğrulandı."
MSG_BACKUP_VERIFY_FAIL="UYARI: Yedek bütünlük kontrolü başarısız!"

# ──────────────────────────────────────────────────────────────────────────────
# GÜNCELLEME (apt update + upgrade)
# ──────────────────────────────────────────────────────────────────────────────
MSG_UPDATE_HEADER="Sistem Güncellemesi"
MSG_UPDATE_START="Sistem güncellemesi çalıştırılıyor..."
MSG_UPDATE_APT_UPDATE="Paket listeleri güncelleniyor..."
MSG_UPDATE_APT_UPDATE_DONE="Paket listeleri güncellendi."
MSG_UPDATE_APT_UPGRADE="Yüklü paketler yükseltiliyor..."
MSG_UPDATE_APT_UPGRADE_DONE="Paket yükseltmesi tamamlandı."
MSG_UPDATE_APT_FULL_UPGRADE="Tam yükseltme çalıştırılıyor..."
MSG_UPDATE_APT_FULL_UPGRADE_DONE="Tam yükseltme tamamlandı."
MSG_UPDATE_FIXING_BROKEN="Bozuk paketler onarılıyor..."
MSG_UPDATE_FIXING_DONE="Bozuk paketler onarıldı."
MSG_UPDATE_SUCCESS="Sistem güncellemesi başarıyla tamamlandı!"
MSG_UPDATE_FAIL="Sistem güncellemesinde hatalar oluştu."
MSG_UPDATE_NO_UPDATES="Sistem zaten güncel."
MSG_UPDATE_COUNT="Yükseltilecek: %d, Yeni: %d, Kaldırılacak: %d"

# ──────────────────────────────────────────────────────────────────────────────
# DAĞITIM YÜKSELTMESİ
# ──────────────────────────────────────────────────────────────────────────────
MSG_UPGRADE_HEADER="Dağıtım Yükseltmesi"
MSG_UPGRADE_PROMPT="Dağıtımınızı yükseltmek istiyor musunuz?"
MSG_UPGRADE_FROM_TO="Yükseltme yolu: %s %s (%s) → %s (%s)"
MSG_UPGRADE_WARNING="UYARI: Dağıtım yükseltmesi büyük bir işlemdir!"
MSG_UPGRADE_WARNING_DATA="Devam etmeden önce tam yedeğiniz olduğundan emin olun."
MSG_UPGRADE_WARNING_SSH="Yükseltme sırasında SSH bağlantıları kesintiye uğrayabilir."
MSG_UPGRADE_WARNING_SERVICES="Çalışan servisler yeniden başlatılabilir."
MSG_UPGRADE_WARNING_TIME="Bu işlem 30 dakika ile birkaç saat arasında sürebilir."
MSG_UPGRADE_CONFIRM="Dağıtım yükseltmesini onaylamak için 'EVET' (büyük harfle) yazın:"
MSG_UPGRADE_CANCELLED="Dağıtım yükseltmesi iptal edildi."
MSG_UPGRADE_START="Dağıtım yükseltmesi başlatılıyor..."
MSG_UPGRADE_DEBIAN_SOURCES="Debian sources.list güncelleniyor..."
MSG_UPGRADE_DEBIAN_SOURCES_DONE="sources.list hedef sürüme güncellendi."
MSG_UPGRADE_UBUNTU_MANAGER="Ubuntu sürüm yükseltme yöneticisi yapılandırılıyor..."
MSG_UPGRADE_UBUNTU_DO="do-release-upgrade çalıştırılıyor..."
MSG_UPGRADE_THIRD_PARTY_DISABLE="Üçüncü parti depolar devre dışı bırakılıyor..."
MSG_UPGRADE_THIRD_PARTY_DONE="Üçüncü parti depolar devre dışı bırakıldı."
MSG_UPGRADE_THIRD_PARTY_REENABLE="Üçüncü parti depolar yeniden etkinleştiriliyor..."
MSG_UPGRADE_THIRD_PARTY_REENABLE_DONE="Üçüncü parti depolar yeniden etkinleştirildi."
MSG_UPGRADE_HELD_PACKAGES="Tutulan paketler kontrol ediliyor..."
MSG_UPGRADE_HELD_FOUND="UYARI: Tutulan paketler tespit edildi! Sorun çıkarabilirler:"
MSG_UPGRADE_HELD_NONE="Tutulan paket bulunamadı."
MSG_UPGRADE_SUCCESS="Dağıtım yükseltmesi başarıyla tamamlandı!"
MSG_UPGRADE_FAIL="Dağıtım yükseltmesinde hatalar oluştu!"
MSG_UPGRADE_VERIFY="Yükseltme sonuçları doğrulanıyor..."
MSG_UPGRADE_VERIFY_OK="Yükseltme doğrulaması başarılı."
MSG_UPGRADE_VERIFY_FAIL="UYARI: Yükseltme doğrulamasında sorunlar tespit edildi."
MSG_UPGRADE_SKIP_MULTI="Doğrudan çoklu sürüm yükseltmeleri desteklenmiyor!"
MSG_UPGRADE_SKIP_MULTI_DETAIL="Bir seferde bir sürüm yükseltmelisiniz: %s → %s → %s"
MSG_UPGRADE_DRY_RUN="[KURU ÇALIŞTIRMA] %s'den %s'ye yükseltme yapılacak"
MSG_UPGRADE_SECURITY_ONLY="Sadece güvenlik güncellemeleri uygulanıyor..."

# ──────────────────────────────────────────────────────────────────────────────
# SÜRÜM SEÇİMİ (Debian için)
# ──────────────────────────────────────────────────────────────────────────────
MSG_VERSION_SELECT="Hedef sürümü seçin:"
MSG_VERSION_CURRENT="(mevcut)"
MSG_VERSION_LATEST="(en son)"
MSG_VERSION_NOT_SUPPORTED="Bu sürüm yükseltme için desteklenmiyor."
MSG_VERSION_RISK_HIGH="YÜKSEK RİSK: Sürüm atlama önerilmez!"

# ──────────────────────────────────────────────────────────────────────────────
# TEMİZLİK
# ──────────────────────────────────────────────────────────────────────────────
MSG_CLEANUP_HEADER="Sistem Temizliği"
MSG_CLEANUP_START="Sistem temizliği başlatılıyor..."
MSG_CLEANUP_AUTOREMOVE="Gereksiz paketler kaldırılıyor..."
MSG_CLEANUP_AUTOREMOVE_DONE="Gereksiz paketler kaldırıldı."
MSG_CLEANUP_AUTOCLEAN="Kısmi paket önbelleği temizleniyor..."
MSG_CLEANUP_AUTOCLEAN_DONE="Kısmi paket önbelleği temizlendi."
MSG_CLEANUP_CLEAN="Tam paket önbelleği temizleniyor..."
MSG_CLEANUP_CLEAN_DONE="Tam paket önbelleği temizlendi."
MSG_CLEANUP_KERNELS="Eski çekirdekler kaldırılıyor..."
MSG_CLEANUP_KERNELS_KEEPING="%d çekirdek tutuluyor, diğerleri kaldırılıyor."
MSG_CLEANUP_KERNELS_DONE="Eski çekirdekler kaldırıldı."
MSG_CLEANUP_KERNELS_NONE="Kaldırılacak eski çekirdek yok."
MSG_CLEANUP_ORPHANS="Yetim paketler kontrol ediliyor..."
MSG_CLEANUP_ORPHANS_FOUND="%d yetim paket bulundu."
MSG_CLEANUP_ORPHANS_REMOVE="Yetim paketleri kaldırmak istiyor musunuz?"
MSG_CLEANUP_ORPHANS_NONE="Yetim paket bulunamadı."
MSG_CLEANUP_LOGS="Eski log dosyaları temizleniyor..."
MSG_CLEANUP_LOGS_DONE="Eski log dosyaları temizlendi."
MSG_CLEANUP_LOGS_ROTATED="Sistem logları döndürülüyor..."
MSG_CLEANUP_JOURNAL="systemd günlüğü temizleniyor..."
MSG_CLEANUP_JOURNAL_DONE="systemd günlüğü temizlendi."
MSG_CLEANUP_THUMBNAIL="Küçük resim önbelleği temizleniyor..."
MSG_CLEANUP_THUMBNAIL_DONE="Küçük resim önbelleği temizlendi."
MSG_CLEANUP_TRASH="Çöp kutusu boşaltılıyor..."
MSG_CLEANUP_TRASH_DONE="Çöp kutusu boşaltıldı."
MSG_CLEANUP_SUCCESS="Sistem temizliği tamamlandı!"
MSG_CLEANUP_FREED="Toplam boşaltılan alan"
MSG_CLEANUP_SKIP="Temizlik atlanıyor."

# ──────────────────────────────────────────────────────────────────────────────
# SERVİSLER
# ──────────────────────────────────────────────────────────────────────────────
MSG_SERVICES_HEADER="Servis Durum Kontrolü"
MSG_SERVICES_CHECK="Kritik servisler kontrol ediliyor..."
MSG_SERVICES_RUNNING="çalışıyor"
MSG_SERVICES_STOPPED="DURDU!"
MSG_SERVICES_NOT_FOUND="yüklü değil"
MSG_SERVICES_RESTART="%s yeniden başlatılmaya çalışılıyor"
MSG_SERVICES_RESTART_OK="%s başarıyla yeniden başlatıldı."
MSG_SERVICES_RESTART_FAIL="HATA: %s yeniden başlatılamadı!"
MSG_SERVICES_ALL_OK="Tüm kritik servisler çalışıyor."
MSG_SERVICES_ISSUES="Bazı servislerde sorun var. Yukarıyı kontrol edin."

# ──────────────────────────────────────────────────────────────────────────────
# YENİDEN BAŞLATMA
# ──────────────────────────────────────────────────────────────────────────────
MSG_REBOOT_HEADER="Yeniden Başlatma"
MSG_REBOOT_REQUIRED="Sistem yeniden başlatması gerekiyor!"
MSG_REBOOT_REQUIRED_PKGS="Yeniden başlatma gerektiren paketler:"
MSG_REBOOT_NOT_REQUIRED="Yeniden başlatma gerekmiyor."
MSG_REBOOT_PROMPT="Şimdi yeniden başlatmak istiyor musunuz?"
MSG_REBOOT_AUTO="Otomatik yeniden başlatma etkin. %d saniye içinde yeniden başlatılıyor..."
MSG_REBOOT_CANCEL="Yeniden başlatmayı iptal etmek için Ctrl+C'ye basın."
MSG_REBOOT_NOW="Şimdi yeniden başlatılıyor..."
MSG_REBOOT_SKIP="Yeniden başlatma atlandı. Manuel olarak yeniden başlatmayı unutmayın."
MSG_REBOOT_SCHEDULED="Yeniden başlatma planlandı."

# ──────────────────────────────────────────────────────────────────────────────
# KURU ÇALIŞTIRMA
# ──────────────────────────────────────────────────────────────────────────────
MSG_DRY_RUN_ENABLED="KURU ÇALIŞTIRMA MODU ETKİN"
MSG_DRY_RUN_NOTICE="Sistemde hiçbir değişiklik yapılmayacak."
MSG_DRY_RUN_PREFIX="[KURU ÇALIŞTIRMA]"
MSG_DRY_RUN_WOULD="Çalıştırılacak komut:"

# ──────────────────────────────────────────────────────────────────────────────
# KANCALAR
# ──────────────────────────────────────────────────────────────────────────────
MSG_HOOKS_PRE_UPDATE="Güncelleme öncesi kancalar çalıştırılıyor..."
MSG_HOOKS_POST_UPDATE="Güncelleme sonrası kancalar çalıştırılıyor..."
MSG_HOOKS_PRE_UPGRADE="Yükseltme öncesi kancalar çalıştırılıyor..."
MSG_HOOKS_POST_UPGRADE="Yükseltme sonrası kancalar çalıştırılıyor..."
MSG_HOOKS_PRE_REBOOT="Yeniden başlatma öncesi kancalar çalıştırılıyor..."
MSG_HOOKS_RUNNING="Kanca çalıştırılıyor: %s"
MSG_HOOKS_SUCCESS="Kanca tamamlandı: %s"
MSG_HOOKS_FAIL="Kanca BAŞARISIZ: %s (çıkış kodu: %d)"
MSG_HOOKS_NONE="%s içinde kanca bulunamadı"

# ──────────────────────────────────────────────────────────────────────────────
# ÖZET
# ──────────────────────────────────────────────────────────────────────────────
MSG_SUMMARY_HEADER="İşlem Özeti"
MSG_SUMMARY_STARTED="Başlangıç zamanı"
MSG_SUMMARY_FINISHED="Bitiş zamanı"
MSG_SUMMARY_DURATION="Süre"
MSG_SUMMARY_OS_BEFORE="Önceki işletim sistemi"
MSG_SUMMARY_OS_AFTER="Sonraki işletim sistemi"
MSG_SUMMARY_UPGRADED="Yükseltilen paketler"
MSG_SUMMARY_INSTALLED="Yeni yüklenen paketler"
MSG_SUMMARY_REMOVED="Kaldırılan paketler"
MSG_SUMMARY_ERRORS="Karşılaşılan hatalar"
MSG_SUMMARY_WARNINGS="Karşılaşılan uyarılar"
MSG_SUMMARY_LOG="Tam log dosyası"
MSG_SUMMARY_BACKUP="Yedek konumu"
MSG_SUMMARY_STATUS="Son durum"
MSG_SUMMARY_SUCCESS="BAŞARILI"
MSG_SUMMARY_PARTIAL="UYARILARLA TAMAMLANDI"
MSG_SUMMARY_FAILED="BAŞARISIZ"

# ──────────────────────────────────────────────────────────────────────────────
# E-POSTA BİLDİRİMİ
# ──────────────────────────────────────────────────────────────────────────────
MSG_EMAIL_SENDING="E-posta bildirimi gönderiliyor..."
MSG_EMAIL_SENT="%s adresine e-posta bildirimi gönderildi"
MSG_EMAIL_FAIL="E-posta bildirimi gönderilemedi."
MSG_EMAIL_SKIP="E-posta bildirimleri devre dışı."

# ──────────────────────────────────────────────────────────────────────────────
# MENÜ SEÇENEKLERİ
# ──────────────────────────────────────────────────────────────────────────────
MSG_MENU_TITLE="Ana Menü — Bir İşlem Seçin"
MSG_MENU_UPDATE="Sistemi Güncelle (apt update + upgrade)"
MSG_MENU_FULL_UPGRADE="Tam Yükseltme (update + dist-upgrade)"
MSG_MENU_DIST_UPGRADE="Dağıtım Yükseltmesi (sonraki ana sürüm)"
MSG_MENU_SECURITY="Sadece Güvenlik Güncellemeleri"
MSG_MENU_CLEANUP="Sistem Temizliği"
MSG_MENU_BACKUP="Sadece Yedek Oluştur"
MSG_MENU_SYSINFO="Sistem Bilgisini Göster"
MSG_MENU_SERVICES="Servis Durumunu Kontrol Et"
MSG_MENU_LOG="Son Log Dosyasını Görüntüle"
MSG_MENU_SETTINGS="Script Ayarları"
MSG_MENU_EXIT="Çıkış"
MSG_MENU_CHOICE="Seçiminizi girin"
MSG_MENU_INVALID="Geçersiz seçim. Lütfen tekrar deneyin."

# ──────────────────────────────────────────────────────────────────────────────
# HATA MESAJLARI
# ──────────────────────────────────────────────────────────────────────────────
MSG_ERR_GENERIC="Beklenmeyen bir hata oluştu."
MSG_ERR_APT_LOCK="HATA: APT başka bir işlem tarafından kilitlenmiş!"
MSG_ERR_APT_LOCK_DETAIL="Başka bir paket yöneticisi (apt/dpkg/unattended-upgrades) şu anda çalışıyor."
MSG_ERR_APT_LOCK_WAIT="APT kilidinin açılması bekleniyor... (Deneme %d)"
MSG_ERR_APT_LOCK_TIMEOUT="APT kilidi bekleme süresi doldu."
MSG_ERR_SOURCES_LIST="HATA: sources.list değiştirilemedi!"
MSG_ERR_SOURCES_BACKUP="HATA: sources.list yedeklenemedi!"
MSG_ERR_PERMISSION="HATA: İzin reddedildi!"
MSG_ERR_DISK_FULL="HATA: Disk dolu!"
MSG_ERR_DOWNLOAD="HATA: Paket indirme başarısız!"
MSG_ERR_DPKG_INTERRUPTED="dpkg kesintiye uğradı. Onarılmaya çalışılıyor..."
MSG_ERR_DPKG_FIX="dpkg --configure -a çalıştırılıyor..."
MSG_ERR_DEPENDENCY="HATA: Karşılanmamış bağımlılıklar tespit edildi!"
MSG_ERR_DEPENDENCY_FIX="Bağımlılıklar onarılmaya çalışılıyor..."
MSG_ERR_KERNEL_PANIC="KRİTİK: Çekirdek ile ilgili hata tespit edildi!"
MSG_ERR_SIGNAL="%s sinyali alındı. Temizleniyor..."
MSG_ERR_INTERRUPTED="İşlem kullanıcı tarafından kesildi."
MSG_ERR_ROLLBACK="Değişiklikler geri alınmaya çalışılıyor..."
MSG_ERR_ROLLBACK_SOURCES="Orijinal sources.list yedekten geri yükleniyor..."
MSG_ERR_ROLLBACK_DONE="Geri alma tamamlandı."
MSG_ERR_ROLLBACK_FAIL="UYARI: Geri alma başarısız! Manuel müdahale gerekebilir."
