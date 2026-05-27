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
- Passwords hasheadas (SHA-256) — **Pendiente migrar a bcrypt**
- Aislamiento de datos por empresa

### Rediseño Mobile-First v3.1 (2025-05-27)
**Cambios principales:**
- Layout mobile-first real (no desktop comprimido)
- Bottom navigation bar (5 secciones: Inicio, Cobros, Facturas, Pagos, Más)
- Header compacto 52px con logo + título centrado
- Inputs mínimo 48px alto, 16px font-size (evita zoom iOS)
- Botones mínimo 44px alto (área táctil)
- Cards con border-radius 14-18px, sombras suaves
- Segmented control iOS-style (Cobro/Pago)
- Tablas reemplazadas por cards en móvil (historial, facturas, proveedores)
- FAB (+) para registro rápido de cobros/pagos
- Dropzone completo → compacto (botón simple)
- Nombre sugerido Drive → acordeón colapsable
- Últimos registros → acordeón colapsable
- Modales → bottom sheet en móvil
- "Más" menú overlay con backdrop (informes, sistema, config)
- Sidebar desktop se mantiene intacta (>768px)
- Diseño system: Inter + JetBrains Mono
- Colores: verde oscuro #1C3829 como accent, superficies blancas

**Templates actualizados:**
- base.html → Layout completo mobile-first
- index.html → Dashboard con KPIs en grids de 2, secciones apiladas
- cobros_registrar.html → Segmented control, dropzone compacto, acordeones
- cobros_historial.html → Cards en móvil + tabla desktop
- facturas.html → Cards en móvil + tabla desktop
- proveedores.html → Cards con grid de datos
- informe.html → Cards apilados, resumen en grid
- login.html → Centrado, limpio, sin bottom nav
- factura_form.html → Campos full-width en móvil
- proveedor_form.html → Secciones claras, una columna
- pagar_form.html → Botones full-width apilados
- editar_pago.html → Layout limpio

### Pendientes
- [ ] Migrar hashing de passwords a bcrypt/scrypt
- [ ] Agregar rate limiting en login
- [ ] CSRF protection (Flask-WTF)
- [ ] Deploy en Render/Railway
- [ ] Cambiar credenciales por defecto de admin
- [ ] Agregar tests
- [ ] PWA manifest (instalable como app)
- [ ] Notificaciones push (opcional)
