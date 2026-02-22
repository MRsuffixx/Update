#!/usr/bin/env bash
# ============================================================================
# locales/es.sh — Spanish Language Pack
# ============================================================================
# Todas las cadenas visibles para el usuario para el Script de Actualización Avanzada.
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# GENERAL / HEADER
# ──────────────────────────────────────────────────────────────────────────────
MSG_WELCOME="Bienvenido al Actualizador Avanzado del Sistema"
MSG_VERSION="Versión"
MSG_AUTHOR="Autor"
MSG_LICENSE="Licencia"
MSG_REPO="Repositorio"
MSG_SEPARATOR="══════════════════════════════════════════════════════════════════════════"
MSG_THIN_SEP="──────────────────────────────────────────────────────────────────────────"
MSG_STARTING="Iniciando el proceso de actualización del sistema..."
MSG_COMPLETED="¡Todas las operaciones se completaron con éxito!"
MSG_ABORTED="Operación abortada por el usuario."
MSG_FAILED="Operación FALLIDA. Revise el registro para más detalles."
MSG_TIMESTAMP="Marca de tiempo"
MSG_HOSTNAME="Nombre de host"
MSG_ELAPSED_TIME="Tiempo total transcurrido"
MSG_PRESS_ENTER="Presione [Enter] para continuar..."
MSG_YES="s"
MSG_NO="n"
MSG_YES_FULL="sí"
MSG_NO_FULL="no"
MSG_LOADING="Cargando..."
MSG_PLEASE_WAIT="Por favor, espere..."
MSG_DONE="Hecho"
MSG_SKIPPED="Omitido"
MSG_OK="Aceptar"
MSG_CANCEL="Cancelar"

# ──────────────────────────────────────────────────────────────────────────────
# ROOT / PERMISSIONS
# ──────────────────────────────────────────────────────────────────────────────
MSG_ROOT_CHECK="Comprobando privilegios de root..."
MSG_ROOT_ERROR="ERROR: ¡Este script debe ejecutarse como root!"
MSG_ROOT_HINT="Intente ejecutarlo con: sudo $0"
MSG_ROOT_OK="Ejecutando con privilegios de root."

# ──────────────────────────────────────────────────────────────────────────────
# LOCKFILE
# ──────────────────────────────────────────────────────────────────────────────
MSG_LOCK_ACQUIRED="Bloqueo adquirido. Procediendo..."
MSG_LOCK_EXISTS="¡Ya se está ejecutando otra instancia de este script!"
MSG_LOCK_PID="PID de la instancia en ejecución"
MSG_LOCK_STALE="Se detectó un archivo de bloqueo obsoleto, eliminando..."
MSG_LOCK_WAIT="Esperando a que termine la instancia existente..."
MSG_LOCK_TIMEOUT="Tiempo de espera agotado para el bloqueo. Saliendo."

# ──────────────────────────────────────────────────────────────────────────────
# SSH WARNING
# ──────────────────────────────────────────────────────────────────────────────
MSG_SSH_DETECTED="¡Se detectó una sesión SSH!"
MSG_SSH_WARNING="ADVERTENCIA: Está ejecutando este script a través de SSH."
MSG_SSH_WARNING_DETAIL="Una actualización de la distribución podría provocar la caída de su conexión SSH."
MSG_SSH_WARNING_ADVICE="Se recomienda ejecutar esto en una sesión de screen/tmux."
MSG_SSH_WARNING_SCREEN="Considere ejecutar: screen -S upgrade o tmux new -s upgrade"
MSG_SSH_CONTINUE="¿Desea continuar de todos modos?"

# ──────────────────────────────────────────────────────────────────────────────
# OS DETECTION
# ──────────────────────────────────────────────────────────────────────────────
MSG_DETECTING_OS="Detectando el sistema operativo..."
MSG_OS_DETECTED="Sistema operativo detectado"
MSG_OS_NAME="Distribución"
MSG_OS_VERSION="Versión"
MSG_OS_CODENAME="Nombre en clave"
MSG_OS_ARCH="Arquitectura"
MSG_OS_KERNEL="Kernel"
MSG_OS_UPTIME="Tiempo de actividad"
MSG_OS_UNSUPPORTED="ERROR: ¡Sistema operativo no soportado!"
MSG_OS_SUPPORTED_LIST="Distribuciones soportadas"
MSG_OS_VERSION_TOO_OLD="ERROR: La versión de su sistema operativo es demasiado antigua para este script."
MSG_OS_VERSION_LATEST="Su sistema ya se encuentra en la última versión soportada."
MSG_OS_RELEASE_FILE="No se pudo encontrar /etc/os-release. No se puede detectar el sistema operativo."

# ──────────────────────────────────────────────────────────────────────────────
# SYSTEM INFORMATION
# ──────────────────────────────────────────────────────────────────────────────
MSG_SYSINFO_HEADER="Información del Sistema"
MSG_SYSINFO_RAM="RAM Total"
MSG_SYSINFO_DISK_ROOT="Espacio en disco en /"
MSG_SYSINFO_DISK_FREE="Espacio libre en disco"
MSG_SYSINFO_DISK_USED="Espacio en disco utilizado"
MSG_SYSINFO_CPU="CPU"
MSG_SYSINFO_CORES="Núcleos de CPU"
MSG_SYSINFO_LOAD="Promedio de carga"
MSG_SYSINFO_VIRTUAL="Virtualización"
MSG_SYSINFO_VIRTUAL_YES="Ejecutándose dentro de una máquina virtual"
MSG_SYSINFO_VIRTUAL_NO="Ejecutándose en hardware físico (bare metal)"
MSG_SYSINFO_PACKAGES="Paquetes instalados"
MSG_SYSINFO_UPGRADABLE="Paquetes actualizables"

# ──────────────────────────────────────────────────────────────────────────────
# DISK SPACE
# ──────────────────────────────────────────────────────────────────────────────
MSG_DISK_CHECK="Comprobando el espacio en disco..."
MSG_DISK_SUFFICIENT="Espacio en disco suficiente."
MSG_DISK_WARNING="ADVERTENCIA: ¡Se detectó poco espacio en disco!"
MSG_DISK_ERROR="ERROR: ¡No hay suficiente espacio en disco para continuar!"
MSG_DISK_REQUIRED="Mínimo requerido"
MSG_DISK_AVAILABLE="Disponible"
MSG_DISK_DETAIL="Detalles de uso del disco:"
MSG_DISK_CLEAN_SUGGESTION="Considere ejecutar una limpieza primero para liberar espacio."

# ──────────────────────────────────────────────────────────────────────────────
# NETWORK
# ──────────────────────────────────────────────────────────────────────────────
MSG_NETWORK_CHECK="Comprobando la conectividad de red..."
MSG_NETWORK_OK="Conectividad de red verificada."
MSG_NETWORK_FAIL="ERROR: ¡No se detectó conectividad de red!"
MSG_NETWORK_FAIL_DETAIL="No se pudo acceder a los servidores de repositorios."
MSG_NETWORK_RETRY="Reintentando... (Intento %d de %d)"
MSG_NETWORK_DNS_CHECK="Comprobando la resolución DNS..."
MSG_NETWORK_DNS_OK="La resolución DNS está funcionando."
MSG_NETWORK_DNS_FAIL="ADVERTENCIA: ¡La resolución DNS falló!"

# ──────────────────────────────────────────────────────────────────────────────
# BACKUP
# ──────────────────────────────────────────────────────────────────────────────
MSG_BACKUP_HEADER="Proceso de Copia de Seguridad"
MSG_BACKUP_START="Creando copia de seguridad del sistema..."
MSG_BACKUP_SOURCES="Realizando copia de seguridad de sources.list..."
MSG_BACKUP_SOURCES_DONE="sources.list respaldado correctamente."
MSG_BACKUP_DPKG="Creando instantánea de paquetes dpkg..."
MSG_BACKUP_DPKG_DONE="Instantánea de dpkg guardada."
MSG_BACKUP_ARCHIVE="Creando archivo de copia de seguridad..."
MSG_BACKUP_ARCHIVE_DONE="Archivo de copia de seguridad creado."
MSG_BACKUP_DIR_CREATE="Creando directorio de copia de seguridad: %s"
MSG_BACKUP_ESTIMATING="Estimando el tamaño de la copia de seguridad..."
MSG_BACKUP_SIZE="Tamaño estimado de la copia de seguridad"
MSG_BACKUP_SIZE_WARNING="ADVERTENCIA: ¡El tamaño de la copia de seguridad supera el límite máximo!"
MSG_BACKUP_SIZE_CONFIRM="¿Desea continuar con la copia de seguridad?"
MSG_BACKUP_DISK_SPACE="Comprobando espacio en disco del destino de la copia de seguridad..."
MSG_BACKUP_DISK_FAIL="ERROR: ¡No hay suficiente espacio en el destino de la copia de seguridad!"
MSG_BACKUP_SKIP="Omitiendo la copia de seguridad según la configuración."
MSG_BACKUP_SUCCESS="¡Copia de seguridad completada con éxito!"
MSG_BACKUP_FAIL="ERROR: ¡La copia de seguridad falló!"
MSG_BACKUP_LOCATION="Copia de seguridad guardada en"
MSG_BACKUP_VERIFY="Verificando la integridad de la copia de seguridad..."
MSG_BACKUP_VERIFY_OK="Integridad de la copia de seguridad verificada."
MSG_BACKUP_VERIFY_FAIL="ADVERTENCIA: ¡La comprobación de integridad de la copia de seguridad falló!"

# ──────────────────────────────────────────────────────────────────────────────
# UPDATE (apt update + upgrade)
# ──────────────────────────────────────────────────────────────────────────────
MSG_UPDATE_HEADER="Actualización del Sistema"
MSG_UPDATE_START="Ejecutando la actualización del sistema..."
MSG_UPDATE_APT_UPDATE="Actualizando la lista de paquetes..."
MSG_UPDATE_APT_UPDATE_DONE="Listas de paquetes actualizadas."
MSG_UPDATE_APT_UPGRADE="Actualizando los paquetes instalados..."
MSG_UPDATE_APT_UPGRADE_DONE="Actualización de paquetes completada."
MSG_UPDATE_APT_FULL_UPGRADE="Ejecutando actualización completa..."
MSG_UPDATE_APT_FULL_UPGRADE_DONE="Actualización completa finalizada."
MSG_UPDATE_FIXING_BROKEN="Reparando paquetes rotos..."
MSG_UPDATE_FIXING_DONE="Paquetes rotos reparados."
MSG_UPDATE_SUCCESS="¡Actualización del sistema completada con éxito!"
MSG_UPDATE_FAIL="La actualización del sistema encontró errores."
MSG_UPDATE_NO_UPDATES="El sistema ya está actualizado."
MSG_UPDATE_COUNT="Paquetes a actualizar: %d, Nuevos: %d, Eliminar: %d"

# ──────────────────────────────────────────────────────────────────────────────
# DISTRIBUTION UPGRADE
# ──────────────────────────────────────────────────────────────────────────────
MSG_UPGRADE_HEADER="Actualización de la Distribución"
MSG_UPGRADE_PROMPT="¿Desea actualizar su distribución?"
MSG_UPGRADE_FROM_TO="Ruta de actualización: %s %s (%s) → %s (%s)"
MSG_UPGRADE_WARNING="ADVERTENCIA: ¡La actualización de la distribución es una operación importante!"
MSG_UPGRADE_WARNING_DATA="Asegúrese de tener una copia de seguridad completa antes de continuar."
MSG_UPGRADE_WARNING_SSH="Las conexiones SSH pueden interrumpirse durante la actualización."
MSG_UPGRADE_WARNING_SERVICES="Los servicios en ejecución pueden reiniciarse."
MSG_UPGRADE_WARNING_TIME="Este proceso puede tardar de 30 minutos a varias horas."
MSG_UPGRADE_CONFIRM="Escriba 'SÍ' (en mayúsculas) para confirmar la actualización de la distribución:"
MSG_UPGRADE_CANCELLED="Actualización de la distribución cancelada."
MSG_UPGRADE_START="Iniciando la actualización de la distribución..."
MSG_UPGRADE_DEBIAN_SOURCES="Actualizando sources.list de Debian..."
MSG_UPGRADE_DEBIAN_SOURCES_DONE="sources.list actualizado a la versión de destino."
MSG_UPGRADE_UBUNTU_MANAGER="Configurando el administrador de actualización de la versión de Ubuntu..."
MSG_UPGRADE_UBUNTU_DO="Ejecutando do-release-upgrade..."
MSG_UPGRADE_THIRD_PARTY_DISABLE="Deshabilitando repositorios de terceros..."
MSG_UPGRADE_THIRD_PARTY_DONE="Repositorios de terceros deshabilitados."
MSG_UPGRADE_THIRD_PARTY_REENABLE="Volviendo a habilitar los repositorios de terceros..."
MSG_UPGRADE_THIRD_PARTY_REENABLE_DONE="Repositorios de terceros rehabilitados."
MSG_UPGRADE_HELD_PACKAGES="Buscando paquetes retenidos..."
MSG_UPGRADE_HELD_FOUND="ADVERTENCIA: ¡Se detectaron paquetes retenidos! Estos podrían causar problemas:"
MSG_UPGRADE_HELD_NONE="No se encontraron paquetes retenidos."
MSG_UPGRADE_SUCCESS="¡La actualización de la distribución se completó con éxito!"
MSG_UPGRADE_FAIL="¡La actualización de la distribución encontró errores!"
MSG_UPGRADE_VERIFY="Verificando los resultados de la actualización..."
MSG_UPGRADE_VERIFY_OK="La verificación de la actualización pasó."
MSG_UPGRADE_VERIFY_FAIL="ADVERTENCIA: La verificación de la actualización detectó problemas."
MSG_UPGRADE_SKIP_MULTI="¡Las actualizaciones directas multiversión no son compatibles!"
MSG_UPGRADE_SKIP_MULTI_DETAIL="Debe actualizar una versión a la vez: %s → %s → %s"
MSG_UPGRADE_DRY_RUN="[SIMULACIÓN] Se actualizaría de %s a %s"
MSG_UPGRADE_SECURITY_ONLY="Aplicando solo actualizaciones de seguridad..."

# ──────────────────────────────────────────────────────────────────────────────
# VERSION SELECTION (for Debian)
# ──────────────────────────────────────────────────────────────────────────────
MSG_VERSION_SELECT="Seleccione la versión de destino:"
MSG_VERSION_CURRENT="(actual)"
MSG_VERSION_LATEST="(última)"
MSG_VERSION_NOT_SUPPORTED="Esta versión no es compatible para la actualización."
MSG_VERSION_RISK_HIGH="ALTO RIESGO: ¡No se recomienda omitir versiones!"

# ──────────────────────────────────────────────────────────────────────────────
# CLEANUP
# ──────────────────────────────────────────────────────────────────────────────
MSG_CLEANUP_HEADER="Limpieza del Sistema"
MSG_CLEANUP_START="Iniciando la limpieza del sistema..."
MSG_CLEANUP_AUTOREMOVE="Eliminando paquetes innecesarios..."
MSG_CLEANUP_AUTOREMOVE_DONE="Paquetes innecesarios eliminados."
MSG_CLEANUP_AUTOCLEAN="Limpiando la caché de paquetes parciales..."
MSG_CLEANUP_AUTOCLEAN_DONE="Caché de paquetes parciales limpiada."
MSG_CLEANUP_CLEAN="Limpiando la caché completa de paquetes..."
MSG_CLEANUP_CLEAN_DONE="Caché completa de paquetes limpiada."
MSG_CLEANUP_KERNELS="Eliminando kernels antiguos..."
MSG_CLEANUP_KERNELS_KEEPING="Manteniendo %d kernel(s), eliminando los demás."
MSG_CLEANUP_KERNELS_DONE="Kernels antiguos eliminados."
MSG_CLEANUP_KERNELS_NONE="No hay kernels antiguos para eliminar."
MSG_CLEANUP_ORPHANS="Buscando paquetes huérfanos..."
MSG_CLEANUP_ORPHANS_FOUND="Se encontraron %d paquete(s) huérfano(s)."
MSG_CLEANUP_ORPHANS_REMOVE="¿Desea eliminar los paquetes huérfanos?"
MSG_CLEANUP_ORPHANS_NONE="No se encontraron paquetes huérfanos."
MSG_CLEANUP_LOGS="Limpiando archivos de registro (logs) antiguos..."
MSG_CLEANUP_LOGS_DONE="Archivos de registro antiguos limpiados."
MSG_CLEANUP_LOGS_ROTATED="Rotando registros del sistema..."
MSG_CLEANUP_JOURNAL="Limpiando el journal de systemd..."
MSG_CLEANUP_JOURNAL_DONE="Journal de systemd limpiado."
MSG_CLEANUP_THUMBNAIL="Limpiando caché de miniaturas..."
MSG_CLEANUP_THUMBNAIL_DONE="Caché de miniaturas limpiada."
MSG_CLEANUP_TRASH="Vaciando la papelera..."
MSG_CLEANUP_TRASH_DONE="Papelera vaciada."
MSG_CLEANUP_SUCCESS="¡Limpieza del sistema completada!"
MSG_CLEANUP_FREED="Espacio total liberado"
MSG_CLEANUP_SKIP="Omitiendo limpieza."

# ──────────────────────────────────────────────────────────────────────────────
# SERVICES
# ──────────────────────────────────────────────────────────────────────────────
MSG_SERVICES_HEADER="Comprobación del Estado de los Servicios"
MSG_SERVICES_CHECK="Comprobando servicios críticos..."
MSG_SERVICES_RUNNING="se está ejecutando"
MSG_SERVICES_STOPPED="¡está DETENIDO!"
MSG_SERVICES_NOT_FOUND="no instalado"
MSG_SERVICES_RESTART="Intentando reiniciar: %s"
MSG_SERVICES_RESTART_OK="%s reiniciado correctamente."
MSG_SERVICES_RESTART_FAIL="ERROR: ¡No se pudo reiniciar %s!"
MSG_SERVICES_ALL_OK="Todos los servicios críticos se están ejecutando."
MSG_SERVICES_ISSUES="Algunos servicios tienen problemas. Compruebe arriba."

# ──────────────────────────────────────────────────────────────────────────────
# REBOOT
# ──────────────────────────────────────────────────────────────────────────────
MSG_REBOOT_HEADER="Reinicio"
MSG_REBOOT_REQUIRED="¡Se requiere reiniciar el sistema!"
MSG_REBOOT_REQUIRED_PKGS="Paquetes que requieren reinicio:"
MSG_REBOOT_NOT_REQUIRED="No se requiere reiniciar."
MSG_REBOOT_PROMPT="¿Desea reiniciar ahora?"
MSG_REBOOT_AUTO="Reinicio automático habilitado. Reiniciando en %d segundos..."
MSG_REBOOT_CANCEL="Presione Ctrl+C para cancelar el reinicio."
MSG_REBOOT_NOW="Reiniciando ahora..."
MSG_REBOOT_SKIP="Reinicio omitido. Recuerde reiniciar manualmente."
MSG_REBOOT_SCHEDULED="Reinicio programado."

# ──────────────────────────────────────────────────────────────────────────────
# DRY-RUN
# ──────────────────────────────────────────────────────────────────────────────
MSG_DRY_RUN_ENABLED="MODO DE SIMULACIÓN HABILITADO"
MSG_DRY_RUN_NOTICE="No se realizarán cambios en el sistema."
MSG_DRY_RUN_PREFIX="[SIMULACIÓN]"
MSG_DRY_RUN_WOULD="Se ejecutaría:"

# ──────────────────────────────────────────────────────────────────────────────
# HOOKS
# ──────────────────────────────────────────────────────────────────────────────
MSG_HOOKS_PRE_UPDATE="Ejecutando ganchos (hooks) previos a la actualización..."
MSG_HOOKS_POST_UPDATE="Ejecutando ganchos posteriores a la actualización..."
MSG_HOOKS_PRE_UPGRADE="Ejecutando ganchos previos a la actualización de distribución..."
MSG_HOOKS_POST_UPGRADE="Ejecutando ganchos posteriores a la actualización de distribución..."
MSG_HOOKS_PRE_REBOOT="Ejecutando ganchos previos al reinicio..."
MSG_HOOKS_RUNNING="Ejecutando gancho: %s"
MSG_HOOKS_SUCCESS="Gancho completado: %s"
MSG_HOOKS_FAIL="Gancho FALLIDO: %s (código de salida: %d)"
MSG_HOOKS_NONE="No se encontraron ganchos en %s"

# ──────────────────────────────────────────────────────────────────────────────
# SUMMARY
# ──────────────────────────────────────────────────────────────────────────────
MSG_SUMMARY_HEADER="Resumen de la Operación"
MSG_SUMMARY_STARTED="Iniciado a las"
MSG_SUMMARY_FINISHED="Finalizado a las"
MSG_SUMMARY_DURATION="Duración"
MSG_SUMMARY_OS_BEFORE="SO antes"
MSG_SUMMARY_OS_AFTER="SO después"
MSG_SUMMARY_UPGRADED="Paquetes actualizados"
MSG_SUMMARY_INSTALLED="Nuevos paquetes instalados"
MSG_SUMMARY_REMOVED="Paquetes eliminados"
MSG_SUMMARY_ERRORS="Errores encontrados"
MSG_SUMMARY_WARNINGS="Advertencias encontradas"
MSG_SUMMARY_LOG="Archivo de registro completo"
MSG_SUMMARY_BACKUP="Ubicación de la copia de seguridad"
MSG_SUMMARY_STATUS="Estado final"
MSG_SUMMARY_SUCCESS="ÉXITO"
MSG_SUMMARY_PARTIAL="COMPLETADO CON ADVERTENCIAS"
MSG_SUMMARY_FAILED="FALLIDO"

# ──────────────────────────────────────────────────────────────────────────────
# EMAIL NOTIFICATION
# ──────────────────────────────────────────────────────────────────────────────
MSG_EMAIL_SENDING="Enviando notificación por correo electrónico..."
MSG_EMAIL_SENT="Notificación por correo electrónico enviada a %s"
MSG_EMAIL_FAIL="Error al enviar la notificación por correo electrónico."
MSG_EMAIL_SKIP="Notificaciones por correo electrónico deshabilitadas."

# ──────────────────────────────────────────────────────────────────────────────
# MENU OPTIONS
# ──────────────────────────────────────────────────────────────────────────────
MSG_MENU_TITLE="Menú Principal — Seleccione una Operación"
MSG_MENU_UPDATE="Actualizar Sistema (apt update + upgrade)"
MSG_MENU_FULL_UPGRADE="Actualización Completa (update + dist-upgrade)"
MSG_MENU_DIST_UPGRADE="Actualización de Distribución (siguiente versión principal)"
MSG_MENU_SECURITY="Solo Actualizaciones de Seguridad"
MSG_MENU_CLEANUP="Limpieza del Sistema"
MSG_MENU_BACKUP="Crear Solo Copia de Seguridad"
MSG_MENU_SYSINFO="Mostrar Información del Sistema"
MSG_MENU_SERVICES="Comprobar Estado de los Servicios"
MSG_MENU_LOG="Ver el Último Archivo de Registro"
MSG_MENU_SETTINGS="Configuración del Script"
MSG_MENU_EXIT="Salir"
MSG_MENU_CHOICE="Ingrese su elección"
MSG_MENU_INVALID="Elección no válida. Por favor, inténtelo de nuevo."

# ──────────────────────────────────────────────────────────────────────────────
# ERROR MESSAGES
# ──────────────────────────────────────────────────────────────────────────────
MSG_ERR_GENERIC="Ocurrió un error inesperado."
MSG_ERR_APT_LOCK="ERROR: ¡APT está bloqueado por otro proceso!"
MSG_ERR_APT_LOCK_DETAIL="Otro administrador de paquetes (apt/dpkg/unattended-upgrades) se está ejecutando actualmente."
MSG_ERR_APT_LOCK_WAIT="Esperando a que se libere el bloqueo de APT... (Intento %d)"
MSG_ERR_APT_LOCK_TIMEOUT="Tiempo de espera agotado para el bloqueo de APT."
MSG_ERR_SOURCES_LIST="ERROR: ¡No se pudo modificar sources.list!"
MSG_ERR_SOURCES_BACKUP="ERROR: ¡No se pudo hacer una copia de seguridad de sources.list!"
MSG_ERR_PERMISSION="ERROR: ¡Permiso denegado!"
MSG_ERR_DISK_FULL="ERROR: ¡El disco está lleno!"
MSG_ERR_DOWNLOAD="ERROR: ¡Falló la descarga del paquete!"
MSG_ERR_DPKG_INTERRUPTED="dpkg fue interrumpido. Intentando arreglarlo..."
MSG_ERR_DPKG_FIX="Ejecutando dpkg --configure -a..."
MSG_ERR_DEPENDENCY="ERROR: ¡Se detectaron dependencias incumplidas!"
MSG_ERR_DEPENDENCY_FIX="Intentando arreglar las dependencias..."
MSG_ERR_KERNEL_PANIC="CRÍTICO: ¡Se detectó un error relacionado con el kernel!"
MSG_ERR_SIGNAL="Señal %s recibida. Limpiando..."
MSG_ERR_INTERRUPTED="Operación interrumpida por el usuario."
MSG_ERR_ROLLBACK="Intentando revertir los cambios..."
MSG_ERR_ROLLBACK_SOURCES="Restaurando el sources.list original desde la copia de seguridad..."
MSG_ERR_ROLLBACK_DONE="Reversión completada."
MSG_ERR_ROLLBACK_FAIL="ADVERTENCIA: ¡La reversión falló! Puede requerir intervención manual."