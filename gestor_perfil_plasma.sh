#!/bin/bash

# Directorio donde guardar los backups
BACKUP_DIR="$HOME/plasma_backups"
mkdir -p "$BACKUP_DIR"

# Función para crear copia de seguridad
backup_plasma() {
    DATE=$(date +%Y-%m-%d_%H-%M-%S)
    BACKUP_FILE="$BACKUP_DIR/perfil_de_plasma-$DATE.tar.gz"

    echo "Creando copia de seguridad en $BACKUP_FILE..."

    tar -czvf "$BACKUP_FILE" \
        "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" \
        "$HOME/.config/plasmanotesrc" \
        "$HOME/.config/kdeglobals" \
        "$HOME/.config/kwinrc" \
        "$HOME/.config/kscreenlockerrc" \
        "$HOME/.config/ksmserverrc" \
        "$HOME/.local/share/wallpapers" \
        2>/dev/null

    echo "✅ Copia de seguridad completada: $BACKUP_FILE"
}

# Función para restaurar copia de seguridad
restore_plasma() {
    echo "Copias de seguridad disponibles en $BACKUP_DIR:"
    ls "$BACKUP_DIR"/*.tar.gz

    echo -e "\nIntroduce el nombre exacto del archivo que quieres restaurar:"
    read BACKUP_FILE

    if [ -f "$BACKUP_DIR/$BACKUP_FILE" ]; then
        echo "Restaurando desde $BACKUP_FILE..."

        tar -xzvf "$BACKUP_DIR/$BACKUP_FILE" -C $HOME

        echo "✅ Restauración completada. Reinicia la sesión de Plasma para aplicar los cambios."
    else
        echo "❌ Archivo no encontrado."
    fi
}

# Menú principal
echo "=========================="
echo "  📦 Gestor de Perfil Plasma"
echo "=========================="
echo "1. Crear copia de seguridad"
echo "2. Restaurar copia de seguridad"
echo "3. Salir"
echo -n "Elige una opción [1-3]: "
read opcion

case $opcion in
    1)
        backup_plasma
        ;;
    2)
        restore_plasma
        ;;
    3)
        echo "Saliendo..."
        ;;
    *)
        echo "Opción inválida."
        ;;
esac
