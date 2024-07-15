/** @type {import('tailwindcss').Config} */
const defaultTheme = require('tailwindcss/defaultTheme')
module.exports = {
	content: {
		relative: true,
		files: [
			"./**/*.{html,js}",
		],
	},
	theme: {
		screens: {
			'xs': '475px',
			...defaultTheme.screens,
			'3xl': '1600px',
		},
		extend: {},
	},
	plugins: [],
}

