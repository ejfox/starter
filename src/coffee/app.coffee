d3 = require('d3')

# Create a categorical scale with custom colors
colorCatScale = d3.scaleOrdinal()
  .range(['#FB514E', '#2d82ca', '#49af37', '#9065c8'])

width = 200
height = 200

# Basic D3 visualization skeleton
svg = d3.select('#container')
  .append('svg')
    .attr('id', 'viz-svg')
    .attr('width', width)
    .attr('height', height)
  .append('rect')
    .attr('width', width)
    .attr('height', height)
    .attr('fill', 'red')
