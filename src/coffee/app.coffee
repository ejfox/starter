import * as d3 from 'd3'
import 'd3-selection-multi'
# import 'd3-jetpack'

# Create a categorical scale with custom colors
# colorCatScale = d3.scaleOrdinal()
#   .range ['#FB514E', '#2d82ca', '#49af37', '#9065c8']
#
# # Create linear scale with custom colors
# colorLinearScale = d3.scaleLinear()
#   .range ['#FB514E', '#49af37']

width = window.innerWidth
height = window.innerHeight

# Basic D3 visualization skeleton
svg = d3.select('#container')
  .append('svg')
    .attr('id', 'viz-svg')
    .attrs {
      width: 150,
      height: 150
    }
  .append('rect')
    .attr('width', 200)
    .attr('height', 200)
    .attr('fill', 'blue')

###
# Load data and call initialize() function
d3.queue()
  .defer(d3.csv, 'data/data.csv')
  .awaitAll initialize

initialize = (data) =>
  console.log 'data loaded', data
###
