# 📸 INSTRUCCIONES PARA CAPTURAS DE PANTALLA

## Requisitos de Google Play Store

### CAPTURAS DE PANTALLA (Obligatorio - Mínimo 2, Máximo 8)

**Tamaños aceptados:**
- **Teléfono:** 16:9 o 9:16
- **Resolución recomendada:** 1080x1920 px (vertical) o 1920x1080 px (horizontal)

### CÓMO HACER LAS CAPTURAS

1. **Abre la app en tu móvil Android**
2. **Toma capturas de estas pantallas:**

#### Captura 1: Pantalla principal con documentos
- Muestra la lista de documentos escaneados
- Debe verse el botón flotante "Escanear Documento"
- Debe verse el banner de anuncios (si estás en versión gratuita)

#### Captura 2: Proceso de escaneo
- Toma una foto mientras estás escaneando un documento
- Debe verse la detección de bordes en acción
- Muestra la interfaz del escáner

#### Captura 3 (Opcional): Vista del PDF generado
- Muestra un documento escaneado abierto
- Debe verse el botón de compartir

#### Captura 4 (Opcional): Pantalla Premium
- Captura la pantalla de "Get Premium"
- Muestra las características premium

#### Captura 5 (Opcional): Diálogo de límite alcanzado
- Muestra el diálogo cuando se alcanza el límite de 10 docs

### CÓMO TOMAR LAS CAPTURAS EN ANDROID

**Método 1: Botones físicos**
```
Presiona simultáneamente: Botón de Encendido + Volumen Abajo
```

**Método 2: Desde ADB (si tu móvil está conectado al PC)**
```powershell
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png C:\WS\Flutter\ScanPDF\store_assets\
```

### DÓNDE GUARDAR LAS CAPTURAS

Guarda todas las capturas en:
```
C:\WS\Flutter\ScanPDF\store_assets\screenshots\
```

Nombre sugerido:
- `screenshot_1_home.png`
- `screenshot_2_scanning.png`
- `screenshot_3_pdf_view.png`
- `screenshot_4_premium.png`
- `screenshot_5_limit.png`

---

## 🎨 GRÁFICO DE FUNCIONES (Feature Graphic)

**Obligatorio:** Sí  
**Tamaño:** 1024 x 500 px  
**Formato:** PNG o JPG

Este gráfico aparece en la parte superior de tu ficha en Play Store.

### Opción 1: Diseño Simple (te lo creo yo)
Dime y te genero un diseño profesional con:
- Logo/Icono de la app
- Nombre "ScanPDF"
- Slogan: "Escanea. Convierte. Comparte."
- Colores morado/azul (tema de la app)

### Opción 2: Diseño Personalizado
Usa herramientas online:
- Canva: https://www.canva.com/
- Figma: https://www.figma.com/
- Photopea: https://www.photopea.com/

---

## 📋 CHECKLIST ANTES DE SUBIR A PLAY CONSOLE

- [ ] Política de privacidad subida a un servidor (o GitHub Pages)
- [ ] Mínimo 2 capturas de pantalla (recomendado 4-5)
- [ ] Gráfico de funciones (1024x500)
- [ ] Ícono de app 512x512 (ya lo tienes: `assets/icon/icon.png`)
- [ ] Descripción corta y completa escritas
- [ ] Clasificación de contenido completada
- [ ] Correo de contacto configurado
- [ ] App Bundle (AAB) compilado (ya lo tienes: `app-release.aab`)

---

## ⏭️ PRÓXIMOS PASOS

1. **Toma las capturas de pantalla** siguiendo las instrucciones de arriba
2. **Guárdalas en** `store_assets/screenshots/`
3. **Avísame** cuando las tengas y te ayudo con el gráfico de funciones
4. **Sube todo a Play Console** cuando Google verifique tu cuenta
