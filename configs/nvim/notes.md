2023-12-01

- `nvim-ufo` is set to `main` branch as the latest release (v1.3.0) does not incorporate
  the fix to the annoying `UnhandledPromiseRejection` caused by `nvim-ufo` when writing Haskell
  with HLS
  - Change branches here: "/Users/rdayabhai/.local/share/nvim/lazy/nvim-ufo"
  - Fix here: https://github.com/kevinhwang91/nvim-ufo/pull/159
- Don't update `nvim-ufo` using Mason (or wait until next `nvim-ufo` release); otherwise manually switch branch back to main
