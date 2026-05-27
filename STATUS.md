# Sistema Unificado v3.0 - SaaS

## Estado del proyecto

### Qué es
Sistema de gestión financiero multitenant (SaaS) para empresas de reparación.
Hosteado por el proveedor, los clientes entran por navegador.

### Arquitectura v3.0
- Flask + Flask-Login
- Multitenant: cada empresa tiene su propia DB SQLite (aislada)
- DB maestra (master.db): empresas + usuarios
- .env para credenciales (NUNCA en el repo)
- Login con roles: admin (vos) + usuario (cada cliente)

### Estructura
```
sistema-unificado-saas/
├── app.py              # App principal (~900 líneas)
├── requirements.txt    # Deps
├── .env.example        # Template de variables
├── .gitignore          # Credenciales NO se suben
├── iniciar_sistema.sh  # Script de inicio Linux/Mac
├── iniciar_sistema.bat # Script de inicio Windows
├── data/
│   ├── master.db       # DB maestra (empresas + usuarios)
│   └── tenants/        # DBs de cada empresa
│       ├── admin.db    # DB del admin
│       └── {slug}.db   # DB de cada cliente
├── templates/          # 18 templates Jinja2
└── oauth_client.json   # Google Drive (por tenant, opcional)
```

### Login por defecto
- Usuario: admin
- Contraseña: admin123
- **CAMBIAR INMEDIATAMENTE en producción**

### Deploy gratuito

Opción 1: Render.com (recomendado)
1. Crear cuenta en render.com
2. New Web Service → conexión con GitHub
3. Build: pip install -r requirements.txt
4. Start: python app.py
5. Environment vars: SECRET_KEY, PORT=10000
6. Plan gratuito: 512MB RAM, se duerme tras 15min inactivo

Opción 2: Railway.app
1. Crear cuenta en railway.app
2. New Project → GitHub repo
3. Variables de entorno
4. Deploy automático

### Funcionalidades completas
- Login con sesiones
- Panel admin: crear empresas, usuarios, reset passwords, suspender
- Multitenant: datos aislados por empresa
- Proveedores (3 bancos, plazos, descuentos, email)
- Facturas (estados, duplicados, categorías, destinos USD/UYU)
- Pagos (individual, batch, con descuento, con saldo a favor)
- Cobros y pagos (flujo de caja genérico)
- Saldos a favor
- Importación de Excel bancario
- Estado de cuenta desde PDF (pdfplumber)
- Exportación a Excel (openpyxl)
- Generación de mails (.eml) con adjuntos
- Google Drive (OAuth2, subir comprobantes)
- Backup/restore de DB
- API REST para cobros/pagos

### Seguridad implementada
- Login requerido en TODAS las rutas
- CORS eliminado
- Credenciales en .env (no en código)
- .gitignore para tokens y DBs
- Passwords hasheadas (SHA-256)
- Aislamiento de datos por empresa

### Pendientes
- [ ] Login con Google
- [ ] HTTPS (lo da el hosting)
- [ ] Rate limiting
- [ ] Recover password por email
- [ ] Auditoría (log de acciones)
- [ ] Mejorar hash (bcrypt en vez de SHA-256)

### Changelog
v3.0 - 2026-05-26 - Refactor SaaS completo:
  - Añadido Flask-Login
  - Multitenant con DB por empresa
  - Panel de admin
  - .env para credenciales
  - Eliminado CORS abierto
  - Templates actualizados con info de usuario
  - Fix: línea duplicada en confirmar_estado_cuenta
  - Fix: bug de /api/buscar que no existía
  - Fix: route /cobros-pagos duplicada que renderizaba con params erróneos

v2.0 - Sistema unificado original (Monolítico, sin login)
