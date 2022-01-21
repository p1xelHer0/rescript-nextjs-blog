const plugins = {
  "@tailwindcss/jit": {},
  autoprefixer: {},
};

if (process.env.NODE_ENV === "production") {
  plugins.cssnano = {};
}

module.exports = {
  plugins: plugins,
};
