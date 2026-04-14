# Taller: vistas de autenticación (Flutter)

Proyecto de interfaz para un flujo típico de app móvil: iniciar sesión, registrarse, recuperar contraseña y un acceso con Google **solo a nivel visual** (no hay servidor ni Firebase detrás).

## Qué incluye

Pantallas conectadas por rutas nombradas, formularios con validación y mensajes simulados (SnackBars y diálogos) para que se pueda recorrer el flujo completo sin credenciales reales.

## Cómo ejecutarlo

Necesitas el SDK de Flutter instalado y un emulador o dispositivo conectado.

```bash
cd taller_flutter_cortedos
flutter pub get
flutter run
```

Si prefieres un navegador:

```bash
flutter run -d chrome
```

## Recorrido de pantallas

La app arranca en **login** (`/`). Desde ahí puedes:

- Ir a **registro** (`/register`), completar el formulario y, al aceptar el diálogo de confirmación, vuelves al login con un aviso en la parte inferior.
- Abrir **olvidé mi contraseña** (`/forgot`), “enviar” el enlace simulado y regresar al login desde el diálogo o con el botón de volver.
- Tras un login válido (o Google en modo éxito en login), puedes entrar a la pantalla de **inicio** (`/home`), que es un placeholder con un botón para cerrar sesión y volver al login.

El botón de Google muestra primero un estado de carga y después un resultado simulado (éxito o cancelado), según lo que elijas en el diálogo.

## Estructura del código (resumen)

- `lib/screens` — login, registro, recuperación e inicio placeholder.
- `lib/widgets` — campos de texto, botón principal, botón social y logo reutilizables.
- `lib/theme` — colores, espaciados y estilo de los campos (incluidos errores).
- `lib/utils` — validadores y simulación del flujo de Google.

## Alcance

**Solo frontend.** No hay autenticación real, ni persistencia de usuarios, ni integración con Google Sign-In: todo lo que ves son pantallas y comportamiento simulado para el taller.

## Evidencia (opcional)

Si el curso pide capturas, conviene guardar unas pocas en una carpeta (por ejemplo `docs/`) mostrando: login con error de validación, registro con contraseñas que no coinciden, diálogo de “cargando” de Google y la pantalla de inicio tras un acceso simulado.
