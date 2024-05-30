module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        jungle_green: 'rgb(42, 157, 144)',
        shamrock: 'rgb(46, 194, 179)',
        bermuda: 'rgb(127, 206, 215)',
        aqua_island: 'rgb(159, 210, 219)',
        alice_blue: 'rgb(240, 249, 255)',
        cameo: 'rgb(218, 183, 160)',
        linen: 'rgb(248, 233, 227)',
        mandys_pink:'rgb(244, 210, 199)'
      },
    },
  },
  plugins: [require("daisyui")],
}
