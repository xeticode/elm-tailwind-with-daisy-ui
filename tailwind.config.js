/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{html,js}'],
  plugins: [require("daisyui")],
  theme: {
    extend: {
      colors: {
        i_am_blue: '#5F9EA0'
      }
    },
  },
  plugins: [],
}

