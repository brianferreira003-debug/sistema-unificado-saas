#!/bin/bash
# ═══════════════════════════════════════════════════
# Sistema Unificado SaaS v3.0 - Iniciar en Linux/Mac
# ═══════════════════════════════════════════════════

echo ""
echo "┌─────────────────────────────────────────┐"
echo "│  Sistema Unificado SaaS v3.0            │"
echo "│  Iniciando...                           │"
echo "└─────────────────────────────────────────┘"
echo ""

cd "$(dirname "$0")"

# Verificar Python 3
if ! command -v python3 &> /dev/null; then
    echo "ERROR: python3 no encontrado. Instalalo primero."
    exit 1
fi

# Crear .env si no existe
if [ ! -f .env ]; then
    echo "⚠ No existe .env - Copiando desde .env.example"
    echo "  Completalo con tus valores reales."
    cp .env.example .env
    SECRET=$(python3 -c "import secrets; print(secrets.token_hex(32))")
    sed -i "s/cambiar-esto-por-un-token-aleatorio/$SECRET/" .env
    echo "  SECRET_KEY generado automáticamente."
    echo ""
fi

# Crear venv si no existe
if [ ! -d "venv" ]; then
    echo "▽ Creando entorno virtual..."
    python3 -m venv venv
fi

# Activar venv e instalar deps
source venv/bin/activate
echo "▽ Instalando dependencias..."
pip install -q -r requirements.txt

echo ""
echo "✅ Todo listo. Abriendo http://localhost:5000"
echo ""

# Abrir navegador (Linux)
xdg-open http://localhost:5000 2>/dev/null &

# Iniciar app
python3 app.py
