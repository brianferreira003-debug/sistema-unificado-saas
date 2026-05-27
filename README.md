# Sistema Unificado SaaS v3.0

Sistema de gestión financiero multitenant para empresas. Cada cliente tiene su propia base de datos aislada.

## Inicio rápido

```bash
./iniciar_sistema.sh
```

Abre http://localhost:5000

**Login inicial:** `admin` / `admin123` (cambiar en producción)

## Deploy en Render

1. Fork/clone de este repo
2. [render.com](https://render.com) → New Web Service
3. Build: `pip install -r requirements.txt`
4. Start: `python app.py`
5. Variable de entorno: `SECRET_KEY` (generar con `python -c "import secrets; print(secrets.token_hex(32))"`)

## Stack

- Python 3 + Flask
- Flask-Login (sesiones)
- SQLite (multitenant: DB por empresa)
- Jinja2 templates
- openpyxl (Excel)
- pdfplumber (PDF bancario)

## Estructura

```
├── app.py                 # App principal
├── requirements.txt       # Dependencias
├── .env.example           # Template variables de entorno
├── .gitignore             # Credenciales excluidas
├── iniciar_sistema.sh     # Script de inicio Linux/Mac
├── data/
│   ├── master.db          # DB maestra (empresas + usuarios)
│   └── tenants/           # DBs individuales por empresa
└── templates/             # 18 templates Jinja2
```

## Seguridad

- Login requerido en todas las rutas
- Datos aislados por empresa (DB separada)
- Credenciales en .env (nunca en el código)
- Passwords hasheadas
- .gitignore para tokens y DBs

## Changelog

- **v3.0** (2026-05-26): Refactor SaaS — Login, multitenant, panel admin, .env
- **v2.0**: Sistema unificado original (monolítico)
