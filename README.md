# Odoo 18.0 on Coolify v4 (Vultr VPS)

## Files
```
.
├── docker-compose.yml   ← paste into Coolify or connect via Git
├── odoo.conf            ← Odoo configuration
└── addons/              ← drop custom modules here
    └── .gitkeep
```

---

## Deployment Steps

### 1 — Prepare your Vultr VPS
- Minimum spec: **4 vCPU / 8 GB RAM** (Odoo 18 is heavier than older versions)
- Install Coolify v4 with the one-liner from [coolify.io/docs](https://coolify.io/docs)

### 2 — Add this project to Coolify

**Option A — Git repo (recommended)**
1. Push this folder to a GitHub/GitLab repo
2. Coolify → **New Resource → Docker Compose → From Git Repo**
3. Set the **Base Directory** to the folder containing `docker-compose.yml`

**Option B — Raw paste**
1. Coolify → **New Resource → Docker Compose → Raw Compose**
2. Paste the contents of `docker-compose.yml`
3. Upload `odoo.conf` via Coolify's **File Mounts** panel (mount to `/etc/odoo/odoo.conf`)
4. Create an `addons` mount pointing to `/mnt/extra-addons`

### 3 — Set Environment Variables in Coolify UI
| Variable | Example |
|---|---|
| `POSTGRES_DB` | `odoo` |
| `POSTGRES_USER` | `odoo` |
| `POSTGRES_PASSWORD` | `a_very_strong_password` |
| `ODOO_DOMAIN` | `odoo.yourdomain.com` |

Also update the `db_password` and `admin_passwd` in `odoo.conf` to match.

### 4 — Deploy
Hit **Deploy** in Coolify. First boot takes ~60 seconds as Odoo initialises.

### 5 — First login
Navigate to `https://odoo.yourdomain.com` → **Create Database** screen will appear.

---

## Custom Addons

1. Drop your module folder inside `addons/` (e.g. `addons/my_module/`)
2. Each module needs an `__init__.py` and `__manifest__.py`
3. In Odoo: **Settings → Activate Developer Mode → Apps → Update Apps List**
4. Search for and install your module

---

## Useful Commands (run on VPS)

```bash
# Tail Odoo logs
docker logs -f $(docker ps -qf name=odoo) 

# Update a specific module
docker exec -it $(docker ps -qf name=odoo) odoo -u my_module --stop-after-init

# Scaffold a new module skeleton
docker exec -it $(docker ps -qf name=odoo) odoo scaffold my_module /mnt/extra-addons
```
