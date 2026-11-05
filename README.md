# Recargas electrónicas

Aplicación Flutter de demostración para iniciar sesión, configurar una recarga y generar su comprobante. La interfaz usa una paleta azul y lima, componentes reutilizables y tipografía Nunito.

## Ejecutar

```sh
flutter pub get
flutter run
```

Acceso de demostración: usuario `fabian`, contraseña `1234`.

## Estructura

- `lib/models`: operadoras, paquetes, usuario y comprobante de recarga.
- `lib/controllers`: autenticación, validación y cálculos de comisión.
- `lib/views/atoms`: controles visuales básicos y tema.
- `lib/views/molecules`: campos etiquetados, chips y tarjeta de paquete.
- `lib/views/organisms`: encabezado del inicio y lista de paquetes.
- `lib/views/pages`: inicio de sesión, nueva recarga y comprobante.

Las rutas nombradas son `/login`, `/home` y `/receipt`. Las comisiones de demostración son 3% para Movistar, 4% para Claro y 5% para CNT; la ganancia del establecimiento se calcula al 2% del valor del paquete. Estos valores y el inicio de sesión son locales de demostración, no están conectados a un servicio real.

## Pruebas

```sh
flutter test
flutter analyze
```
