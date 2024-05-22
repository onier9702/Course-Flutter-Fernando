# Flutter - Authenticated CRUD App - TesloShop

Este es un proyecto para trabajar con:

* Cámara
* Tokens de acceso
* CRUD (Create Read Update Delete) Rest API Endpoints
* Riverpod
* GoRouter


## El backend lo pueden obtener de aquí

[Teslo Backend - Nest RestServer](https://hub.docker.com/repository/docker/klerith/flutter-backend-teslo-shop/general)

# Importante
Recuerden leer y seguir la guía para montar el backend localmente.

## Installations
1. Formz
```formz```

2. Riverpod (state managment) Remember to use the ProviderScope in your MainApp() to have it at top level
```flutter_riverpod```

3. Dotenv
```flutter_dotenv```

4. Dio to make http request to server
```dio```

5. Shared Preferences (to store simple data on local devide)
```shared_preferences```

6. Masonry ( to display grid reparated products in screen )
```flutter_staggered_grid_view```

7. Image selector
```image_picker```
__NEED__ to write explanation of permissions on IOS to can access resources of camera on apple devices 
path: /ios/Runner/Info.plist

8. Bardcode scanner
```flutter_barcode_scanner```
