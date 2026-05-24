<div align="center">

<img src="src/es/assets/cover.jpg" alt="The Art of Asking Why Cover" width="400" style="border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.25); margin: 20px 0;">

# The Art of Asking Why

**A technical book and personal specialization project by Miguel Velez**

This book is about developing engineering judgment: learning to ask why technologies exist, what problems they solve, what trade-offs they introduce, and when they are actually worth using.

### 🔗 [Read the book here!](https://mvelezg99.github.io/the-art-of-asking-why/)

</div>

---

## Structure

This repository uses one root landing book and two separate mdBook editions:

- `book.toml`: root landing page configuration.
- `src/README.md`: main landing page and language selector.
- `src/SUMMARY.md`: root landing page summary.
- `src/es`: Spanish edition.
- `src/en`: English edition.

Each language has its own `book.toml` and `SUMMARY.md` so the editions do not share the same sidebar.

## Commands

Build:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1
```

Serve locally:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\serve.ps1
```

The serve script opens the landing page at `http://localhost:3000`, serves the generated `book/` directory, and rebuilds the books when files change under `src/`.

## GitHub Pages

The workflow in `.github/workflows/pages.yml` builds and publishes the generated `book/` directory on every push to `main`.

In the repository settings, configure GitHub Pages to deploy from **GitHub Actions**.

Published routes:

- `/`: root landing page.
- `/es/`: Spanish edition.
- `/en/`: English edition.

The `book/` directory is generated and should not be committed.


