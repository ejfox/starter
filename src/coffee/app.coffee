width = window.innerWidth
height = window.innerHeight

# Basic D3 visualization skeleton
svg = d3.select('#container')
  .append('svg')
    .attr('id', 'viz-svg')
    .attrs {
      width: 500,
      height: 500
    }
  .append('rect')
    .attr('width', 500)
    .attr('height', 500)
    .attr('fill', 'red')

###
# Load data and call initialize() function
d3.queue()
  .defer(d3.csv, 'data/data.csv')
  .awaitAll initialize

initialize = (data) =>
  console.log 'data loaded', data
###
