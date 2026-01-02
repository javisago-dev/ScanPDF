# 🚀 CHECKLIST COMPLETO - PUBLICACIÓN EN GOOGLE PLAY STORE

## ✅ ESTADO ACTUAL

- [x] **Aplicación desarrollada** - ScanPDF funcional
- [x] **Sistema de monetización** - AdMob + In-App Purchases configurado
- [x] **App Bundle compilado** - `app-release.aab` (46.11 MB)
- [x] **Cuenta de desarrollador** - Pago realizado, **EN VERIFICACIÓN** ⏳
- [x] **Repositorio actualizado** - GitHub sincronizado
- [ ] **Cuenta verificada** - Esperando aprobación de Google (1-3 días)

---

## 📋 TAREAS PENDIENTES (HACER MIENTRAS ESPERAS)

### 1️⃣ POLÍTICA DE PRIVACIDAD ✅ LISTA

**Archivo:** `store_assets/privacy_policy.html`

**Acción necesaria:**
1. Abre el archivo y **reemplaza `[TU_EMAIL_AQUÍ]`** con tu email de contacto
2. Sube el archivo a un servidor web:
   
   **Opción A - GitHub Pages (Gratis):**
   ```bash
   # Crear nuevo repo público en GitHub llamado "privacy-policy"
   # Subir el archivo privacy_policy.html
   # Activar GitHub Pages en Settings
   # URL final: https://[tu-usuario].github.io/privacy-policy/privacy_policy.html
   ```
   
   **Opción B - Google Drive:**
   - Sube el HTML a Drive
   - Compartir → "Cualquiera con el enlace"
   - Copia la URL de compartir
   
   **Opción C - Firebase Hosting / Netlify / Vercel** (gratis)

3. **Copia la URL** para pegarla en Play Console

---

### 2️⃣ CAPTURAS DE PANTALLA 📸 PENDIENTE

**Mínimo:** 2 capturas | **Recomendado:** 4-5 capturas

**Instrucciones:** Ver archivo `store_assets/INSTRUCCIONES_CAPTURAS.md`

**Capturas necesarias:**
1. **Pantalla principal** con lista de documentos + banner de anuncios
2. **Proceso de escaneo** mostrando detección de bordes
3. **Pantalla Premium** (opcional pero recomendado)
4. **Diálogo de límite** alcanzado (opcional)
5. **PDF generado** (opcional)

**Cómo tomarlas:**
```
Botón Encendido + Volumen Abajo (simultáneos)
```

**Dónde guardarlas:**
```
store_assets/screenshots/
```

---

### 3️⃣ GRÁFICO DE FUNCIONES (FEATURE GRAPHIC) 🎨 PENDIENTE

**Tamaño requerido:** 1024 x 500 px

**Método 1 - Generador Automático (FÁCIL):**
1. Abre: `store_assets/generate_feature_graphic.html` en tu navegador
2. Carga tu icono: `ScanPDF_for_students_icon.png`
3. Click en "Generar Feature Graphic"
4. Descarga la imagen generada
5. Guarda como: `store_assets/feature_graphic.png`

**Método 2 - Diseño Personalizado:**
- Usa Canva: https://www.canva.com/ (plantilla 1024x500)
- O Photopea: https://www.photopea.com/

---

### 4️⃣ DESCRIPCIÓN DE LA APP ✅ LISTA

**Archivo:** `store_assets/app_description.md`

Contiene:
- ✅ Descripción corta (80 caracteres)
- ✅ Descripción completa (4000 caracteres)
- ✅ Notas de versión
- ✅ Palabras clave
- ✅ Categoría sugerida

**Acción:** Solo copiar/pegar cuando subas a Play Console

---

## 🎯 CUANDO GOOGLE VERIFIQUE TU CUENTA

### PASO 1: Completar ficha de la aplicación

1. **Accede a Play Console** → Tu app (borrador)

2. **Configurar la aplicación:**
   - Nombre: `ScanPDF`
   - Categoría: `Productividad`
   - Email de contacto: `[tu email]`
   - Política de privacidad: `[URL del archivo HTML]`

3. **Subir recursos gráficos:**
   - Icono: `ScanPDF_for_students_icon.png` (512x512)
   - Feature Graphic: `feature_graphic.png` (1024x500)
   - Capturas: Subir las 2-5 capturas de `screenshots/`

4. **Descripción:**
   - Copiar de `app_description.md`

5. **Clasificación de contenido:**
   - Completar cuestionario
   - Respuestas: Todo "No" (sin violencia, sexo, drogas, etc.)
   - Público: Todos (13+)

6. **Público objetivo:**
   - Marcar: Mayores de 13 años
   - NO dirigida principalmente a niños

---

### PASO 2: Crear versión de prueba interna

1. **Testing → Internal testing**
2. **Create new release**
3. **Subir:** `build/app/outputs/bundle/release/app-release.aab`
4. **Release name:** v1.0
5. **Release notes:** Copiar de `app_description.md` (sección "Notas de Versión")
6. **Review and roll out** → **Start rollout to Internal testing**

---

### PASO 3: Configurar producto Premium

1. **Monetize → In-app products**
2. **Create product:**
   - Product ID: `premium_no_ads` ← **EXACTO** (no cambies ni una letra)
   - Name: `Premium - Sin Anuncios`
   - Description: `Elimina anuncios y desbloquea todas las funciones premium`
   - Price: `€2.99`
   - Type: `One-time purchase` (compra única)
3. **Activate** ✅
4. **Esperar 2-4 horas** para propagación

---

### PASO 4: Añadir testers

1. En **Internal testing** → **Testers**
2. **Create email list** → Añade tu email
3. **Save**
4. **Copia el link de testing** y ábrelo en tu móvil
5. **Descarga e instala** la app desde Play Store

---

### PASO 5: Probar la app

✅ **Probar:**
- Escaneo de documentos
- Banner de anuncios
- Intersticial (después de 3 docs)
- Límite de 10 documentos
- **Botón Premium** → Ahora SÍ funcionará
- Proceso de compra (puedes cancelar antes de pagar)

---

### PASO 6: Publicación final (cuando esté todo OK)

1. **Production → Create new release**
2. Sube el mismo `app-release.aab`
3. **Submit for review**
4. **Espera aprobación de Google** (1-7 días)
5. 🎉 **¡App publicada!**

---

## 📞 CONTACTO Y SOPORTE

### Información necesaria en Play Console:
- **Email de contacto:** [Añade tu email]
- **Sitio web:** [Opcional - tu GitHub o web personal]
- **Dirección física:** [Requerido por Google - tu dirección]

### Para soporte de usuarios:
- Email que pongas debe estar activo
- Responder consultas de usuarios

---

## 🔧 ANTES DEL LANZAMIENTO FINAL

**IMPORTANTE:** Cuando estés listo para producción, avísame para:

1. **Cambiar ads de testing a producción:**
   - Editar `lib/services/ad_service.dart`
   - Cambiar `_useTesting = true` → `_useTesting = false`
   - Recompilar AAB
   - Subir nueva versión

2. **Actualizar versión:**
   - Incrementar en `pubspec.yaml`: `version: 1.0.1+2`

---

## ⏱️ TIMELINE ESTIMADO

| Tarea | Tiempo estimado | Estado |
|-------|----------------|--------|
| Verificación cuenta Google | 1-3 días | ⏳ En espera |
| Tomar capturas | 10 minutos | ⏱️ Pendiente |
| Generar feature graphic | 5 minutos | ⏱️ Pendiente |
| Subir política privacidad | 10 minutos | ⏱️ Pendiente |
| Completar ficha Play Console | 20 minutos | ⏱️ Bloqueado |
| Subir AAB y configurar | 15 minutos | ⏱️ Bloqueado |
| Revisión de Google (producción) | 1-7 días | ⏱️ Bloqueado |
| **TOTAL (después de verificación)** | **~1 hora + espera Google** | |

---

## 📁 ARCHIVOS IMPORTANTES

```
C:\WS\Flutter\ScanPDF\
├── build/app/outputs/bundle/release/
│   └── app-release.aab ← SUBIR ESTE A PLAY CONSOLE
├── ScanPDF_for_students_icon.png ← ICONO 512x512
└── store_assets/
    ├── privacy_policy.html ← SUBIR A WEB
    ├── app_description.md ← COPIAR TEXTO
    ├── generate_feature_graphic.html ← ABRIR EN NAVEGADOR
    ├── INSTRUCCIONES_CAPTURAS.md ← LEER
    └── screenshots/ ← GUARDAR CAPTURAS AQUÍ
```

---

## ✅ PRÓXIMOS PASOS INMEDIATOS

1. **AHORA:** Toma las capturas de pantalla (10 min)
2. **AHORA:** Genera el feature graphic (5 min)
3. **AHORA:** Sube privacy_policy.html a GitHub Pages (15 min)
4. **ESPERAR:** Verificación de Google (1-3 días)
5. **DESPUÉS:** Completar Play Console y subir AAB

---

## 🆘 ¿NECESITAS AYUDA?

Si tienes dudas en cualquier paso, pregúntame y te ayudo con:
- Subir política de privacidad
- Generar gráficos
- Configurar Play Console
- Resolver errores
- Lo que necesites

---

**📌 IMPORTANTE:** Guarda este archivo y los de `store_assets/` como referencia.

**🚀 ¡Estás a pocos días de tener tu app en Google Play Store!**
