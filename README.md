# 🚀 Ministack Mock CI/CD

[![CI/CD Pipeline](https://github.com/lukmanulhakimdevops/devops_practical_test_ministack-local-ci-cd-aws-mock/actions/workflows/dotnet.yml/badge.svg)](https://github.com/lukmanulhakimdevops/devops_practical_test_ministack-local-ci-cd-aws-mock/actions)

Proyek ini merupakan simulasi pipeline **CI/CD** menggunakan **GitHub Actions** dalam lingkungan **mock (Ministack)**. Seluruh layanan seperti **S3, EC2, dan RDS** hanya disimulasikan melalui file dummy dan log proses, sehingga tidak membutuhkan akun AWS nyata.

---

## 📌 Daftar Isi

- [Tentang Proyek](#tentang-proyek)
- [Arsitektur Pipeline](#arsitektur-pipeline)
- [Teknologi yang Digunakan](#teknologi-yang-digunakan)
- [Prasyarat](#prasyarat)
- [Cara Menggunakan](#cara-menggunakan)
  - [1. Clone Repository](#1-clone-repository)
  - [2. Atur Secrets dengan GitHub CLI](#2-atur-secrets-dengan-github-cli)
  - [3. Jalankan Workflow](#3-jalankan-workflow)
- [Struktur Direktori](#struktur-direktori)
- [Penjelasan Workflow](#penjelasan-workflow)
- [Kontribusi](#kontribusi)
- [Lisensi](#lisensi)

---

## Tentang Proyek

**Ministack Mock CI/CD** adalah implementasi pipeline DevOps sederhana yang mensimulasikan alur berikut:

1. Mengunduh source code dari **S3** (mock).
2. Melakukan proses **build** dan **publish** aplikasi **.NET 8**.
3. Membuat artifact `webapp-binaries.zip`.
4. Mengunggah artifact ke **S3** (mock).
5. Melakukan deployment ke **EC2** (mock) melalui SSH.
6. Memperbarui connection string database **RDS** (mock).

Pipeline ini cocok digunakan untuk **pembelajaran**, **demonstrasi**, dan **pengujian konsep CI/CD** tanpa ketergantungan pada infrastruktur cloud sungguhan.

---

## Arsitektur Pipeline

```mermaid
flowchart LR
    A["GitHub Repo<br>(Source)"] --> B["GitHub Actions<br>(Runner)"]
    B --> C["Mock AWS Stack<br>(S3, EC2, RDS)"]
    B --> D["Artifact<br>.zip"]

    %% Styling taktis untuk visibilitas (Opsional)
    style A fill:#2b3137,stroke:#fafbfc,stroke-width:2px,color:#fff
    style B fill:#2088FF,stroke:#fafbfc,stroke-width:2px,color:#fff
    style C fill:#FF9900,stroke:#232F3E,stroke-width:2px,color:#232F3E
    style D fill:#ececec,stroke:#333,stroke-width:2px,color:#333

---

## Teknologi yang Digunakan

| Komponen       | Teknologi / Tools           |
| -------------- | --------------------------- |
| CI/CD          | GitHub Actions              |
| Bahasa         | .NET 8 (C#)                 |
| Cloud (Mock)   | AWS CLI (dummy credentials) |
| Secret Manager | GitHub Secrets + `gh` CLI   |
| OS Runner      | Ubuntu Latest               |

---

## Prasyarat

Sebelum menjalankan proyek ini, pastikan Anda memiliki:

* Akun **GitHub**
* **Git** yang sudah terinstal
* **GitHub CLI (`gh`)** yang sudah login
* **.NET 8 SDK** apabila ingin build secara lokal

---

## Cara Menggunakan

### 1. Clone Repository

```bash
git clone git@github.com:lukmanulhakimdevops/devops_practical_test_ministack-local-ci-cd-aws-mock.git
cd devops_practical_test_ministack-local-ci-cd-aws-mock
```

### 2. Atur Secrets dengan GitHub CLI

Gunakan perintah berikut untuk menambahkan secret yang dibutuhkan:

```bash
gh auth login

gh secret set AWS_ACCESS_KEY_ID     --body "dummy"
gh secret set AWS_SECRET_ACCESS_KEY --body "dummy"
gh secret set S3_BUCKET             --body "mock-bucket"
gh secret set EC2_HOST              --body "localhost"
gh secret set RDS_ENDPOINT          --body "localhost:3306"
gh secret set DB_NAME               --body "mockdb"
gh secret set DB_USER               --body "mockuser"
gh secret set DB_PASSWORD           --body "mockpass"

gh secret list
```

> **Catatan:** Semua credential di atas hanya digunakan untuk simulasi dan tidak akan terhubung ke AWS sungguhan.

### 3. Jalankan Workflow

Workflow akan berjalan otomatis setiap ada **push** ke branch `main`.

Untuk menjalankan secara manual melalui GitHub:

1. Buka tab **Actions**
2. Pilih workflow **🚀 Ministack Mock CI/CD**
3. Klik **Run workflow**

Atau melalui GitHub CLI:

```bash
gh workflow run "🚀 Ministack Mock CI/CD"
```

---

## Struktur Direktori

```text
.
├── .github
│   └── workflows
│       └── ministack-mock-ci-cd.yml
├── artifacts
│   └── binaries
│       └── git
├── linux-x64
├── .gitignore
└── README.md
```

---

## Penjelasan Workflow

Pipeline ini terdiri dari 8 tahapan utama:

| Step | Nama Step                   | Deskripsi                                                |
| ---- | --------------------------- | -------------------------------------------------------- |
| 1    | 📥 Checkout Repository      | Mengambil source code dari repository                    |
| 2    | 🔧 Setup .NET 8             | Menginstal .NET SDK 8.x di runner                        |
| 3    | ☁️ Configure AWS CLI (Mock) | Membuat file konfigurasi AWS dengan nilai dummy          |
| 4    | 📦 Download Source from S3  | Mensimulasikan pengambilan source code dari S3           |
| 5    | 🔨 Build and Publish        | Menjalankan `dotnet restore` dan `dotnet publish`        |
| 6    | 📤 Package and Upload to S3 | Membuat artifact `.zip` dan mensimulasikan upload        |
| 7    | 🚀 Deploy to EC2 (Mock)     | Mensimulasikan deployment ke EC2 serta update koneksi DB |
| 8    | 📋 Pipeline Summary         | Menampilkan ringkasan hasil pipeline                     |

---

## Kontribusi

Kontribusi sangat terbuka. Untuk menambahkan fitur atau memperbaiki bug:

1. Fork repository ini
2. Buat branch baru

   ```bash
   git checkout -b fitur-baru
   ```
3. Commit perubahan

   ```bash
   git commit -m "Menambahkan fitur baru"
   ```
4. Push ke branch

   ```bash
   git push origin fitur-baru
   ```
5. Buat Pull Request

---

## Lisensi

Proyek ini menggunakan lisensi [MIT License](LICENSE).

---

Dibuat untuk kebutuhan pembelajaran dan simulasi implementasi **DevOps CI/CD**.
