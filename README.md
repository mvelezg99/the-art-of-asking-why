# Become a Real Senior Software Engineer

Official repository for the technical book and personal specialization project by **Miguel Velez**.

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

The `book/` directory is generated and should not be committed.
