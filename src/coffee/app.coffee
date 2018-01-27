# import * as d3 from "d3"
# import "d3-selection-multi"
window.d3 = require 'd3'
import 'd3-selection-multi'

# Create a categorical scale with custom colors
colorCatScale = d3.scaleOrdinal()
  .range ['#FB514E', '#2d82ca', '#49af37', '#9065c8']

# Create linear scale with custom colors
colorLinearScale = d3.scaleLinear()
  .range ['#FB514E', '#49af37']

width = window.innerWidth
height = window.innerHeight

# Basic D3 visualization skeleton
svg = d3.select('#container')
  .append('svg')
    .attr('id', 'viz-svg')
    .attr('width', width)
    .attr('height', height)

svg.append('rect')
  .attr('width', 600)
  .attr('height', 100)
  .attr('fill', 'blue')

svg.append('rect')
    .attrs {
      width: 200,
      height: 200,
      fill: 'red'
    }

###
# Load data and call initialize() function
d3.queue()
  .defer(d3.csv, 'data/data.csv')
  .awaitAll initialize
###
