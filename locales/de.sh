#!/usr/bin/env bash
# ============================================================================
# locales/de.sh — German Language Pack
# ============================================================================
# Alle benutzerbezogenen Zeichenfolgen für das Erweiterte System-Update-Skript.
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# GENERAL / HEADER
# ──────────────────────────────────────────────────────────────────────────────
MSG_WELCOME="Willkommen beim Erweiterten System-Updater"
MSG_VERSION="Version"
MSG_AUTHOR="Autor"
MSG_LICENSE="Lizenz"
MSG_REPO="Repository"
MSG_SEPARATOR="══════════════════════════════════════════════════════════════════════════"
MSG_THIN_SEP="──────────────────────────────────────────────────────────────────────────"
MSG_STARTING="Starte Systemaktualisierung..."
MSG_COMPLETED="Alle Vorgänge erfolgreich abgeschlossen!"
MSG_ABORTED="Vorgang durch den Benutzer abgebrochen."
MSG_FAILED="Vorgang FEHLGESCHLAGEN. Überprüfen Sie das Protokoll auf Details."
MSG_TIMESTAMP="Zeitstempel"
MSG_HOSTNAME="Hostname"
MSG_ELAPSED_TIME="Gesamtverstrichene Zeit"
MSG_PRESS_ENTER="Drücken Sie [Enter], um fortzufahren..."
MSG_YES="j"
MSG_NO="n"
MSG_YES_FULL="ja"
MSG_NO_FULL="nein"
MSG_LOADING="Laden..."
MSG_PLEASE_WAIT="Bitte warten..."
MSG_DONE="Erledigt"
MSG_SKIPPED="Übersprungen"
MSG_OK="OK"
MSG_CANCEL="Abbrechen"

# ──────────────────────────────────────────────────────────────────────────────
# ROOT / PERMISSIONS
# ──────────────────────────────────────────────────────────────────────────────
MSG_ROOT_CHECK="Überprüfe Root-Rechte..."
MSG_ROOT_ERROR="FEHLER: Dieses Skript muss als root ausgeführt werden!"
MSG_ROOT_HINT="Versuchen Sie es mit: sudo $0"
MSG_ROOT_OK="Ausführung mit Root-Rechten."

# ──────────────────────────────────────────────────────────────────────────────
# LOCKFILE
# ──────────────────────────────────────────────────────────────────────────────
MSG_LOCK_ACQUIRED="Sperre erhalten. Fortfahren..."
MSG_LOCK_EXISTS="Eine andere Instanz dieses Skripts wird bereits ausgeführt!"
MSG_LOCK_PID="PID der laufenden Instanz"
MSG_LOCK_STALE="Veraltete Sperrdatei erkannt, wird entfernt..."
MSG_LOCK_WAIT="Warten auf Beendigung der bestehenden Instanz..."
MSG_LOCK_TIMEOUT="Zeitüberschreitung beim Warten auf die Sperre. Beenden."

# ──────────────────────────────────────────────────────────────────────────────
# SSH WARNING
# ──────────────────────────────────────────────────────────────────────────────
MSG_SSH_DETECTED="SSH-Sitzung erkannt!"
MSG_SSH_WARNING="WARNUNG: Sie führen dieses Skript über SSH aus."
MSG_SSH_WARNING_DETAIL="Ein Distributions-Upgrade könnte zum Abbruch der SSH-Verbindung führen."
MSG_SSH_WARNING_ADVICE="Es wird empfohlen, dies in einer screen/tmux-Sitzung auszuführen."
MSG_SSH_WARNING_SCREEN="Erwägen Sie die Ausführung von: screen -S upgrade  oder  tmux new -s upgrade"
MSG_SSH_CONTINUE="Möchten Sie trotzdem fortfahren?"

# ──────────────────────────────────────────────────────────────────────────────
# OS DETECTION
# ──────────────────────────────────────────────────────────────────────────────
MSG_DETECTING_OS="Erkenne Betriebssystem..."
MSG_OS_DETECTED="Betriebssystem erkannt"
MSG_OS_NAME="Distribution"
MSG_OS_VERSION="Version"
MSG_OS_CODENAME="Codename"
MSG_OS_ARCH="Architektur"
MSG_OS_KERNEL="Kernel"
MSG_OS_UPTIME="Betriebszeit"
MSG_OS_UNSUPPORTED="FEHLER: Nicht unterstütztes Betriebssystem!"
MSG_OS_SUPPORTED_LIST="Unterstützte Distributionen"
MSG_OS_VERSION_TOO_OLD="FEHLER: Ihre Betriebssystemversion ist zu alt für dieses Skript."
MSG_OS_VERSION_LATEST="Ihr System ist bereits auf der neuesten unterstützten Version."
MSG_OS_RELEASE_FILE="/etc/os-release konnte nicht gefunden werden. Betriebssystem kann nicht erkannt werden."

# ──────────────────────────────────────────────────────────────────────────────
# SYSTEM INFORMATION
# ──────────────────────────────────────────────────────────────────────────────
MSG_SYSINFO_HEADER="Systeminformationen"
MSG_SYSINFO_RAM="Gesamter RAM"
MSG_SYSINFO_DISK_ROOT="Festplattenspeicher auf /"
MSG_SYSINFO_DISK_FREE="Freier Festplattenspeicher"
MSG_SYSINFO_DISK_USED="Belegter Festplattenspeicher"
MSG_SYSINFO_CPU="CPU"
MSG_SYSINFO_CORES="CPU-Kerne"
MSG_SYSINFO_LOAD="Auslastung (Load Average)"
MSG_SYSINFO_VIRTUAL="Virtualisierung"
MSG_SYSINFO_VIRTUAL_YES="Läuft in einer virtuellen Maschine"
MSG_SYSINFO_VIRTUAL_NO="Läuft auf physischer Hardware (Bare-Metal)"
MSG_SYSINFO_PACKAGES="Installierte Pakete"
MSG_SYSINFO_UPGRADABLE="Aktualisierbare Pakete"

# ──────────────────────────────────────────────────────────────────────────────
# DISK SPACE
# ──────────────────────────────────────────────────────────────────────────────
MSG_DISK_CHECK="Überprüfe Festplattenspeicher..."
MSG_DISK_SUFFICIENT="Ausreichend Festplattenspeicher verfügbar."
MSG_DISK_WARNING="WARNUNG: Wenig Festplattenspeicher erkannt!"
MSG_DISK_ERROR="FEHLER: Nicht genug Festplattenspeicher, um fortzufahren!"
MSG_DISK_REQUIRED="Erforderliches Minimum"
MSG_DISK_AVAILABLE="Verfügbar"
MSG_DISK_DETAIL="Details zur Festplattennutzung:"
MSG_DISK_CLEAN_SUGGESTION="Erwägen Sie zunächst eine Bereinigung, um Speicherplatz freizugeben."

# ──────────────────────────────────────────────────────────────────────────────
# NETWORK
# ──────────────────────────────────────────────────────────────────────────────
MSG_NETWORK_CHECK="Überprüfe Netzwerkverbindung..."
MSG_NETWORK_OK="Netzwerkverbindung verifiziert."
MSG_NETWORK_FAIL="FEHLER: Keine Netzwerkverbindung erkannt!"
MSG_NETWORK_FAIL_DETAIL="Repository-Server konnten nicht erreicht werden."
MSG_NETWORK_RETRY="Wiederhole... (Versuch %d von %d)"
MSG_NETWORK_DNS_CHECK="Überprüfe DNS-Auflösung..."
MSG_NETWORK_DNS_OK="DNS-Auflösung funktioniert."
MSG_NETWORK_DNS_FAIL="WARNUNG: DNS-Auflösung fehlgeschlagen!"

# ──────────────────────────────────────────────────────────────────────────────
# BACKUP
# ──────────────────────────────────────────────────────────────────────────────
MSG_BACKUP_HEADER="Sicherungsvorgang"
MSG_BACKUP_START="Erstelle Systemsicherung..."
MSG_BACKUP_SOURCES="Sichere sources.list..."
MSG_BACKUP_SOURCES_DONE="sources.list erfolgreich gesichert."
MSG_BACKUP_DPKG="Erstelle dpkg-Paket-Schnappschuss..."
MSG_BACKUP_DPKG_DONE="dpkg-Schnappschuss gespeichert."
MSG_BACKUP_ARCHIVE="Erstelle Sicherungsarchiv..."
MSG_BACKUP_ARCHIVE_DONE="Sicherungsarchiv erstellt."
MSG_BACKUP_DIR_CREATE="Erstelle Sicherungsverzeichnis: %s"
MSG_BACKUP_ESTIMATING="Schätze Sicherungsgröße..."
MSG_BACKUP_SIZE="Geschätzte Sicherungsgröße"
MSG_BACKUP_SIZE_WARNING="WARNUNG: Sicherungsgröße überschreitet den maximalen Schwellenwert!"
MSG_BACKUP_SIZE_CONFIRM="Möchten Sie mit der Sicherung fortfahren?"
MSG_BACKUP_DISK_SPACE="Überprüfe Speicherplatz am Sicherungsziel..."
MSG_BACKUP_DISK_FAIL="FEHLER: Nicht genug Platz am Sicherungsziel!"
MSG_BACKUP_SKIP="Sicherung wird gemäß Konfiguration übersprungen."
MSG_BACKUP_SUCCESS="Sicherung erfolgreich abgeschlossen!"
MSG_BACKUP_FAIL="FEHLER: Sicherung fehlgeschlagen!"
MSG_BACKUP_LOCATION="Sicherung gespeichert in"
MSG_BACKUP_VERIFY="Überprüfe Integrität der Sicherung..."
MSG_BACKUP_VERIFY_OK="Integrität der Sicherung verifiziert."
MSG_BACKUP_VERIFY_FAIL="WARNUNG: Überprüfung der Sicherungsintegrität fehlgeschlagen!"

# ──────────────────────────────────────────────────────────────────────────────
# UPDATE (apt update + upgrade)
# ──────────────────────────────────────────────────────────────────────────────
MSG_UPDATE_HEADER="Systemaktualisierung"
MSG_UPDATE_START="Führe Systemaktualisierung aus..."
MSG_UPDATE_APT_UPDATE="Aktualisiere Paketlisten..."
MSG_UPDATE_APT_UPDATE_DONE="Paketlisten aktualisiert."
MSG_UPDATE_APT_UPGRADE="Aktualisiere installierte Pakete..."
MSG_UPDATE_APT_UPGRADE_DONE="Paketaktualisierung abgeschlossen."
MSG_UPDATE_APT_FULL_UPGRADE="Führe vollständiges Upgrade aus..."
MSG_UPDATE_APT_FULL_UPGRADE_DONE="Vollständiges Upgrade abgeschlossen."
MSG_UPDATE_FIXING_BROKEN="Repariere fehlerhafte Pakete..."
MSG_UPDATE_FIXING_DONE="Fehlerhafte Pakete repariert."
MSG_UPDATE_SUCCESS="Systemaktualisierung erfolgreich abgeschlossen!"
MSG_UPDATE_FAIL="Systemaktualisierung ist auf Fehler gestoßen."
MSG_UPDATE_NO_UPDATES="Das System ist bereits auf dem neuesten Stand."
MSG_UPDATE_COUNT="Zu aktualisierende Pakete: %d, Neu: %d, Entfernen: %d"

# ──────────────────────────────────────────────────────────────────────────────
# DISTRIBUTION UPGRADE
# ──────────────────────────────────────────────────────────────────────────────
MSG_UPGRADE_HEADER="Distributions-Upgrade"
MSG_UPGRADE_PROMPT="Möchten Sie Ihre Distribution aktualisieren?"
MSG_UPGRADE_FROM_TO="Upgrade-Pfad: %s %s (%s) → %s (%s)"
MSG_UPGRADE_WARNING="WARNUNG: Ein Distributions-Upgrade ist ein größerer Eingriff!"
MSG_UPGRADE_WARNING_DATA="Stellen Sie sicher, dass Sie ein vollständiges Backup haben, bevor Sie fortfahren."
MSG_UPGRADE_WARNING_SSH="SSH-Verbindungen können während des Upgrades unterbrochen werden."
MSG_UPGRADE_WARNING_SERVICES="Laufende Dienste können neu gestartet werden."
MSG_UPGRADE_WARNING_TIME="Dieser Vorgang kann 30 Minuten bis mehrere Stunden dauern."
MSG_UPGRADE_CONFIRM="Geben Sie 'JA' (in Großbuchstaben) ein, um das Distributions-Upgrade zu bestätigen:"
MSG_UPGRADE_CANCELLED="Distributions-Upgrade abgebrochen."
MSG_UPGRADE_START="Starte Distributions-Upgrade..."
MSG_UPGRADE_DEBIAN_SOURCES="Aktualisiere Debian sources.list..."
MSG_UPGRADE_DEBIAN_SOURCES_DONE="sources.list auf Ziel-Release aktualisiert."
MSG_UPGRADE_UBUNTU_MANAGER="Konfiguriere Ubuntu Release-Upgrade-Manager..."
MSG_UPGRADE_UBUNTU_DO="Führe do-release-upgrade aus..."
MSG_UPGRADE_THIRD_PARTY_DISABLE="Deaktiviere Drittanbieter-Repositorys..."
MSG_UPGRADE_THIRD_PARTY_DONE="Drittanbieter-Repositorys deaktiviert."
MSG_UPGRADE_THIRD_PARTY_REENABLE="Reaktiviere Drittanbieter-Repositorys..."
MSG_UPGRADE_THIRD_PARTY_REENABLE_DONE="Drittanbieter-Repositorys reaktiviert."
MSG_UPGRADE_HELD_PACKAGES="Überprüfe auf zurückgehaltene (held) Pakete..."
MSG_UPGRADE_HELD_FOUND="WARNUNG: Zurückgehaltene Pakete erkannt! Diese könnten Probleme verursachen:"
MSG_UPGRADE_HELD_NONE="Keine zurückgehaltenen Pakete gefunden."
MSG_UPGRADE_SUCCESS="Distributions-Upgrade erfolgreich abgeschlossen!"
MSG_UPGRADE_FAIL="Distributions-Upgrade ist auf Fehler gestoßen!"
MSG_UPGRADE_VERIFY="Überprüfe Upgrade-Ergebnisse..."
MSG_UPGRADE_VERIFY_OK="Upgrade-Überprüfung bestanden."
MSG_UPGRADE_VERIFY_FAIL="WARNUNG: Upgrade-Überprüfung hat Probleme erkannt."
MSG_UPGRADE_SKIP_MULTI="Direkte Multi-Versions-Upgrades werden nicht unterstützt!"
MSG_UPGRADE_SKIP_MULTI_DETAIL="Sie müssen Version für Version aktualisieren: %s → %s → %s"
MSG_UPGRADE_DRY_RUN="[TESTLAUF] Würde von %s auf %s aktualisieren"
MSG_UPGRADE_SECURITY_ONLY="Wende nur Sicherheitsupdates an..."

# ──────────────────────────────────────────────────────────────────────────────
# VERSION SELECTION (for Debian)
# ──────────────────────────────────────────────────────────────────────────────
MSG_VERSION_SELECT="Wählen Sie die Zielversion:"
MSG_VERSION_CURRENT="(aktuell)"
MSG_VERSION_LATEST="(neueste)"
MSG_VERSION_NOT_SUPPORTED="Diese Version wird für das Upgrade nicht unterstützt."
MSG_VERSION_RISK_HIGH="HOHES RISIKO: Das Überspringen von Versionen wird nicht empfohlen!"

# ──────────────────────────────────────────────────────────────────────────────
# CLEANUP
# ──────────────────────────────────────────────────────────────────────────────
MSG_CLEANUP_HEADER="Systembereinigung"
MSG_CLEANUP_START="Starte Systembereinigung..."
MSG_CLEANUP_AUTOREMOVE="Entferne nicht mehr benötigte Pakete..."
MSG_CLEANUP_AUTOREMOVE_DONE="Nicht mehr benötigte Pakete entfernt."
MSG_CLEANUP_AUTOCLEAN="Bereinige teilweisen Paket-Cache..."
MSG_CLEANUP_AUTOCLEAN_DONE="Teilweiser Paket-Cache bereinigt."
MSG_CLEANUP_CLEAN="Bereinige vollständigen Paket-Cache..."
MSG_CLEANUP_CLEAN_DONE="Vollständiger Paket-Cache bereinigt."
MSG_CLEANUP_KERNELS="Entferne alte Kernel..."
MSG_CLEANUP_KERNELS_KEEPING="Behalte %d Kernel, entferne die anderen."
MSG_CLEANUP_KERNELS_DONE="Alte Kernel entfernt."
MSG_CLEANUP_KERNELS_NONE="Keine alten Kernel zu entfernen."
MSG_CLEANUP_ORPHANS="Überprüfe auf verwaiste Pakete..."
MSG_CLEANUP_ORPHANS_FOUND="%d verwaiste(s) Paket(e) gefunden."
MSG_CLEANUP_ORPHANS_REMOVE="Möchten Sie verwaiste Pakete entfernen?"
MSG_CLEANUP_ORPHANS_NONE="Keine verwaisten Pakete gefunden."
MSG_CLEANUP_LOGS="Bereinige alte Protokolldateien (Logs)..."
MSG_CLEANUP_LOGS_DONE="Alte Protokolldateien bereinigt."
MSG_CLEANUP_LOGS_ROTATED="Rotiere Systemprotokolle..."
MSG_CLEANUP_JOURNAL="Bereinige systemd-Journal..."
MSG_CLEANUP_JOURNAL_DONE="systemd-Journal bereinigt."
MSG_CLEANUP_THUMBNAIL="Bereinige Thumbnail-Cache..."
MSG_CLEANUP_THUMBNAIL_DONE="Thumbnail-Cache bereinigt."
MSG_CLEANUP_TRASH="Leere Papierkorb..."
MSG_CLEANUP_TRASH_DONE="Papierkorb geleert."
MSG_CLEANUP_SUCCESS="Systembereinigung abgeschlossen!"
MSG_CLEANUP_FREED="Gesamter freigegebener Speicherplatz"
MSG_CLEANUP_SKIP="Bereinigung wird übersprungen."

# ──────────────────────────────────────────────────────────────────────────────
# SERVICES
# ──────────────────────────────────────────────────────────────────────────────
MSG_SERVICES_HEADER="Dienststatusüberprüfung"
MSG_SERVICES_CHECK="Überprüfe kritische Dienste..."
MSG_SERVICES_RUNNING="läuft"
MSG_SERVICES_STOPPED="ist GESTOPPT!"
MSG_SERVICES_NOT_FOUND="nicht installiert"
MSG_SERVICES_RESTART="Versuche Neustart von: %s"
MSG_SERVICES_RESTART_OK="%s erfolgreich neu gestartet."
MSG_SERVICES_RESTART_FAIL="FEHLER: %s konnte nicht neu gestartet werden!"
MSG_SERVICES_ALL_OK="Alle kritischen Dienste laufen."
MSG_SERVICES_ISSUES="Einige Dienste haben Probleme. Überprüfen Sie oben."

# ──────────────────────────────────────────────────────────────────────────────
# REBOOT
# ──────────────────────────────────────────────────────────────────────────────
MSG_REBOOT_HEADER="Neustart"
MSG_REBOOT_REQUIRED="Ein Systemneustart ist erforderlich!"
MSG_REBOOT_REQUIRED_PKGS="Pakete, die einen Neustart erfordern:"
MSG_REBOOT_NOT_REQUIRED="Kein Neustart erforderlich."
MSG_REBOOT_PROMPT="Möchten Sie jetzt neu starten?"
MSG_REBOOT_AUTO="Automatischer Neustart ist aktiviert. Neustart in %d Sekunden..."
MSG_REBOOT_CANCEL="Drücken Sie Strg+C, um den Neustart abzubrechen."
MSG_REBOOT_NOW="Starte jetzt neu..."
MSG_REBOOT_SKIP="Neustart übersprungen. Denken Sie daran, manuell neu zu starten."
MSG_REBOOT_SCHEDULED="Neustart geplant."

# ──────────────────────────────────────────────────────────────────────────────
# DRY-RUN
# ──────────────────────────────────────────────────────────────────────────────
MSG_DRY_RUN_ENABLED="TESTLAUF-MODUS AKTIVIERT"
MSG_DRY_RUN_NOTICE="Es werden keine Änderungen am System vorgenommen."
MSG_DRY_RUN_PREFIX="[TESTLAUF]"
MSG_DRY_RUN_WOULD="Würde ausführen:"

# ──────────────────────────────────────────────────────────────────────────────
# HOOKS
# ──────────────────────────────────────────────────────────────────────────────
MSG_HOOKS_PRE_UPDATE="Führe Pre-Update-Hooks aus..."
MSG_HOOKS_POST_UPDATE="Führe Post-Update-Hooks aus..."
MSG_HOOKS_PRE_UPGRADE="Führe Pre-Upgrade-Hooks aus..."
MSG_HOOKS_POST_UPGRADE="Führe Post-Upgrade-Hooks aus..."
MSG_HOOKS_PRE_REBOOT="Führe Pre-Reboot-Hooks aus..."
MSG_HOOKS_RUNNING="Führe Hook aus: %s"
MSG_HOOKS_SUCCESS="Hook abgeschlossen: %s"
MSG_HOOKS_FAIL="Hook FEHLGESCHLAGEN: %s (Exit-Code: %d)"
MSG_HOOKS_NONE="Keine Hooks in %s gefunden"

# ──────────────────────────────────────────────────────────────────────────────
# SUMMARY
# ──────────────────────────────────────────────────────────────────────────────
MSG_SUMMARY_HEADER="Zusammenfassung des Vorgangs"
MSG_SUMMARY_STARTED="Gestartet am"
MSG_SUMMARY_FINISHED="Beendet am"
MSG_SUMMARY_DURATION="Dauer"
MSG_SUMMARY_OS_BEFORE="OS davor"
MSG_SUMMARY_OS_AFTER="OS danach"
MSG_SUMMARY_UPGRADED="Aktualisierte Pakete"
MSG_SUMMARY_INSTALLED="Neu installierte Pakete"
MSG_SUMMARY_REMOVED="Entfernte Pakete"
MSG_SUMMARY_ERRORS="Aufgetretene Fehler"
MSG_SUMMARY_WARNINGS="Aufgetretene Warnungen"
MSG_SUMMARY_LOG="Vollständige Protokolldatei"
MSG_SUMMARY_BACKUP="Sicherungsort"
MSG_SUMMARY_STATUS="Endgültiger Status"
MSG_SUMMARY_SUCCESS="ERFOLGREICH"
MSG_SUMMARY_PARTIAL="MIT WARNUNGEN ABGESCHLOSSEN"
MSG_SUMMARY_FAILED="FEHLGESCHLAGEN"

# ──────────────────────────────────────────────────────────────────────────────
# EMAIL NOTIFICATION
# ──────────────────────────────────────────────────────────────────────────────
MSG_EMAIL_SENDING="Sende E-Mail-Benachrichtigung..."
MSG_EMAIL_SENT="E-Mail-Benachrichtigung gesendet an %s"
MSG_EMAIL_FAIL="E-Mail-Benachrichtigung konnte nicht gesendet werden."
MSG_EMAIL_SKIP="E-Mail-Benachrichtigungen deaktiviert."

# ──────────────────────────────────────────────────────────────────────────────
# MENU OPTIONS
# ──────────────────────────────────────────────────────────────────────────────
MSG_MENU_TITLE="Hauptmenü — Wählen Sie einen Vorgang"
MSG_MENU_UPDATE="System aktualisieren (apt update + upgrade)"
MSG_MENU_FULL_UPGRADE="Vollständiges Upgrade (update + dist-upgrade)"
MSG_MENU_DIST_UPGRADE="Distributions-Upgrade (nächste Hauptversion)"
MSG_MENU_SECURITY="Nur Sicherheitsupdates"
MSG_MENU_CLEANUP="Systembereinigung"
MSG_MENU_BACKUP="Nur Sicherung erstellen"
MSG_MENU_SYSINFO="Systeminformationen anzeigen"
MSG_MENU_SERVICES="Dienststatus überprüfen"
MSG_MENU_LOG="Letzte Protokolldatei anzeigen"
MSG_MENU_SETTINGS="Skripteinstellungen"
MSG_MENU_EXIT="Beenden"
MSG_MENU_CHOICE="Geben Sie Ihre Auswahl ein"
MSG_MENU_INVALID="Ungültige Auswahl. Bitte versuchen Sie es erneut."

# ──────────────────────────────────────────────────────────────────────────────
# ERROR MESSAGES
# ──────────────────────────────────────────────────────────────────────────────
MSG_ERR_GENERIC="Ein unerwarteter Fehler ist aufgetreten."
MSG_ERR_APT_LOCK="FEHLER: APT ist durch einen anderen Prozess gesperrt!"
MSG_ERR_APT_LOCK_DETAIL="Ein anderer Paketmanager (apt/dpkg/unattended-upgrades) wird derzeit ausgeführt."
MSG_ERR_APT_LOCK_WAIT="Warten auf Freigabe der APT-Sperre... (Versuch %d)"
MSG_ERR_APT_LOCK_TIMEOUT="Zeitüberschreitung beim Warten auf die APT-Sperre."
MSG_ERR_SOURCES_LIST="FEHLER: sources.list konnte nicht geändert werden!"
MSG_ERR_SOURCES_BACKUP="FEHLER: sources.list konnte nicht gesichert werden!"
MSG_ERR_PERMISSION="FEHLER: Zugriff verweigert!"
MSG_ERR_DISK_FULL="FEHLER: Festplatte ist voll!"
MSG_ERR_DOWNLOAD="FEHLER: Paket-Download fehlgeschlagen!"
MSG_ERR_DPKG_INTERRUPTED="dpkg wurde unterbrochen. Versuche Reparatur..."
MSG_ERR_DPKG_FIX="Führe dpkg --configure -a aus..."
MSG_ERR_DEPENDENCY="FEHLER: Unerfüllte Abhängigkeiten erkannt!"
MSG_ERR_DEPENDENCY_FIX="Versuche Abhängigkeiten zu reparieren..."
MSG_ERR_KERNEL_PANIC="KRITISCH: Kernel-bezogener Fehler erkannt!"
MSG_ERR_SIGNAL="Signal %s empfangen. Bereinige..."
MSG_ERR_INTERRUPTED="Vorgang durch den Benutzer unterbrochen."
MSG_ERR_ROLLBACK="Versuche Änderungen rückgängig zu machen..."
MSG_ERR_ROLLBACK_SOURCES="Stelle ursprüngliche sources.list aus Sicherung wieder her..."
MSG_ERR_ROLLBACK_DONE="Rückgängigmachen abgeschlossen."
MSG_ERR_ROLLBACK_FAIL="WARNUNG: Rückgängigmachen fehlgeschlagen! Manueller Eingriff könnte erforderlich sein."