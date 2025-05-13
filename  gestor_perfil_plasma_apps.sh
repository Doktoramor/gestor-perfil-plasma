#!/bin/bash

# Carpeta de trabajo: donde se ejecuta el script
SCRIPT_DIR="$(pwd)"

# Definir las rutas de configuración

# Config de Plasma
PLASMA_CONFIG=(
    "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
    "$HOME/.config/plasmanotesrc"
    "$HOME/.config/kdeglobals"
    "$HOME/.config/kscreenlockerrc"
    "$HOME/.config/kwinrc"
    "$HOME/.config/gtkrc"
    "$HOME/.config/gtkrc-2.0"
    "$HOME/.config/gtk-4.0"
    "$HOME/.config/gtk-3.0"
    "$HOME/.config/ksplashrc"
    "$HOME/.config/plasmarc"
    "$HOME/.config/Trolltech.conf"
    "$HOME/.config/breezerc"
    "$HOME/.config/kcminputrc"
    "$HOME/.config/klaunchrc"
    "$HOME/.config/kfontinstuirc"
    "$HOME/.config/kactivitymanagerdrc"
    "$HOME/.config/kactivitymanagerd-switcher"
    "$HOME/.config/kactivitymanagerd-statsrc"
    "$HOME/.config/kactivitymanagerd-pluginsrc"
    "$HOME/.config/kglobalshortcutsrc"
    "$HOME/.config/kwinrulesrc"
    "$HOME/.config/khotkeysrc"
    "$HOME/.config/kded5rc"
    "$HOME/.config/ksmserverrc"
    "$HOME/.config/krunnerrc"
    "$HOME/.config/baloofilerc"
    "$HOME/.config/kuriikwsfiltersrc"
    "$HOME/.local/share/kservices5/searchproviders"
    "$HOME/.local/share/plasma-systemmonitor"
    "$HOME/.config/plasmanotifyrc"
    "$HOME/.config/plasma-localerc"
    "$HOME/.config/ktimezonedrc"
    "$HOME/.config/kaccessrc"
    "$HOME/.config/mimeapps.list"
    "$HOME/.config/user-dirs.dirs"
    "$HOME/.local/share/user-places.xbel"
    "$HOME/.config/powermanagementprofilesrc"
    "$HOME/.config/bluedevilglobalrc"
    "$HOME/.config/kdeconnect"
    "$HOME/.config/device_automounter_kcmrc"
    "$HOME/.config/kded_device_automounterrc"
    "$HOME/.config/kgammarc"
)

# Config de aplicaciones KDE
APPS_CONFIG=(
    "$HOME/.config/arkrc"
    "$HOME/.config/dolphinrc"
    "$HOME/.config/filelightrc"
    "$HOME/.config/gwenviewrc"
    "$HOME/.config/katerc"
    "$HOME/.config/katevirc"
    "$HOME/.config/kate-externaltoolspluginrc"
    "$HOME/.config/kcalcrc"
    "$HOME/.config/partitionmanagerrc"
    "$HOME/.config/konsolerc"
    "$HOME/.config/konsolesshconfig"
    "$HOME/.config/krusaderrc"
    "$HOME/.config/spectaclerc"
    "$HOME/.config/systemmonitorrc"
    "$HOME/.config/systemsettingsrc"
)

# Función para crear copia
backup_config() {
    local TYPE=$1
    local DATE=$(date +%Y-%m-%d_%H-%M-%S)
    local BACKUP_FILE="$SCRIPT_DIR/$TYPE-$DATE.tar.gz"
    local -n CONFIG_ARRAY=$2

    echo "📝 Creando copia de seguridad: $BACKUP_FILE"

    tar -czvf "$BACKUP_FILE" --ignore-failed-read "${CONFIG_ARRAY[@]}"

    echo "✅ Copia completada: $BACKUP_FILE"
}

# Función para restaurar
restore_backup() {
    echo -e "\n📦 Copias de seguridad detectadas:"
    ls "$SCRIPT_DIR"/*.tar.gz 2>/dev/null || { echo "❌ No hay copias en $SCRIPT_DIR"; return; }

    echo -e "\nIntroduce el nombre exacto del archivo a restaurar:"
    read BACKUP_FILE

    if [ -f "$SCRIPT_DIR/$BACKUP_FILE" ]; then
        echo "🔄 Restaurando desde $BACKUP_FILE..."
        tar -xzvf "$SCRIPT_DIR/$BACKUP_FILE" -C /
        echo "✅ Restauración completada. Reinicia sesión de Plasma para aplicar cambios."
    else
        echo "❌ Archivo no encontrado."
    fi
}

# Menú principal
while true; do
    echo -e "\n=========================="
    echo "   📦 Gestor Perfil KDE"
    echo "=========================="
    echo "1. Copia solo configuración Plasma"
    echo "2. Copia solo configuración Apps KDE"
    echo "3. Copia de ambas (Plasma + Apps)"
    echo "4. Restaurar copia de seguridad"
    echo "5. Salir"
    echo -n "Elige una opción [1-5]: "
    read opcion

    case $opcion in
        1)
            backup_config "plasma_backup" PLASMA_CONFIG
            ;;
        2)
            backup_config "apps_kde_backup" APPS_CONFIG
            ;;
        3)
            COMBINED_CONFIG=("${PLASMA_CONFIG[@]}" "${APPS_CONFIG[@]}")
            backup_config "plasma_y_apps_backup" COMBINED_CONFIG
            ;;
        4)
            restore_backup
            ;;
        5)
            echo "👋 Saliendo..."
            break
            ;;
        *)
            echo "❌ Opción inválida."
            ;;
    esac
done
