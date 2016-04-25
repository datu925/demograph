$(function() {

  var svgContainer = d3.select("#percent-chart")
                       .append("svg")
                       .attr("width", 500)
                       .attr("height", 200);

  var linearScale = d3.scale.linear()
                      .domain([0,100])
                      .range([50,450]);

  var xAxis = d3.svg.axis()
                    .scale(linearScale);

  var percMale = 100 * $("#percent-male").attr("data-percent");

  var circles = svgContainer.selectAll("circle")
    .data([percMale])
    .enter()
    .append("circle")
    .attr("cx", function(d) { return linearScale(d) })
    .attr("cy", 75)
    .attr("r", 10)
    .style("fill", "black")

  var xAxisGroup = svgContainer.append("g")
                               .attr("transform", "translate(0, 100)")
                               .call(xAxis)
                               .style("stroke-width","1px");


  svgContainer.append("text")
              .attr("x", 75 )
              .attr("y", 165 )
              .style("text-anchor", "middle")
              .text("all women");

  svgContainer.append("text")
              .attr("x", 425 )
              .attr("y", 165 )
              .style("text-anchor", "middle")
              .text("all men");


})
