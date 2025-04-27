return require('telescope').register_extension {
  exports = {
    scoped_crate = require('telescope-scoped-crate').scoped_crate_files,
  },
}
