# Deploy en Render

algoviz se despliega con **Docker** (el `Dockerfile` que genera Rails 8) usando
el Blueprint [`render.yaml`](render.yaml).

## Requisito previo: subir el repo a GitHub/GitLab

El repo ya está inicializado con un commit local. Falta crear el remoto y pushear:

```bash
git remote add origin git@github.com:TU_USUARIO/algoviz.git
git push -u origin main
```

> `config/master.key` **no** se sube (está en `.gitignore`). Su contenido lo vas
> a cargar como variable de entorno en Render.

## Pasos en Render

1. Render → **New +** → **Blueprint**.
2. Elegí el repo `algoviz`. Render detecta `render.yaml` y propone el servicio web.
3. Antes de crear, cargá la variable secreta:
   - **`RAILS_MASTER_KEY`** = el contenido de tu `config/master.key` local
     (`cat config/master.key`).
4. **Apply** / **Create**. Render buildea la imagen Docker, corre
   `db:prepare && db:seed` y levanta el server en el `PORT` que asigna.
5. El health check pega a `/up`; cuando da 200, queda público.

## Notas

- **Free tier = filesystem efímero.** La SQLite se regenera en cada deploy. No es
  problema: el contenido es de sólo lectura y se reconstruye desde
  `db/seeds.rb` (idempotente) en el arranque.
- **Para persistir datos entre deploys:** pasá a un plan pago y descomentá el
  bloque `disk:` en `render.yaml` (monta un disco en `/rails/storage`).
- **SSL:** Render termina TLS y reenvía `X-Forwarded-Proto`; el default de Rails 8
  (`force_ssl`) funciona sin tocar nada.
- **Assets:** se precompilan en el build de Docker; `RAILS_SERVE_STATIC_FILES=true`
  hace que Rails los sirva (no hay nginx delante).
