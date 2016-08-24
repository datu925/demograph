$(function() {

  var svgContainer = d3.select("#percent-chart")
                       .append("svg")
                       .attr("width", 500)
                       .attr("height", 100);

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
    .attr("cy", 40)
    .attr("r", 8)
    .style("fill", "gray")

  var xAxisGroup = svgContainer.append("g")
                               .attr("transform", "translate(0, 50)")
                               .attr("class", "axis")
                               .call(xAxis)
                               .style("fill","url(#MyGradient)");

  var gradient = svgContainer.append("svg:defs")
              .append("svg:linearGradient")
              .attr("id", "MyGradient")
              // .attr("x1", "0%")
              // .attr("y1", "0%")
              // .attr("x2", "100%")
              // .attr("y2", "100%")
              .attr("spreadMethod", "pad");

  // Define the gradient colors
  gradient.append("svg:stop")
      .attr("offset", "0%")
      .attr("stop-color", "Pink")
      .attr("stop-opacity", 1);

  gradient.append("svg:stop")
      .attr("offset", "100%")
      .attr("stop-color", "DeepSkyBlue")
      .attr("stop-opacity", 1);



  svgContainer.append("text")
              .attr("x", 55 )
              .attr("y", 85 )
              .style("text-anchor", "middle")
              .style("fill", "Pink")
              .text("all women");

  svgContainer.append("text")
              .attr("x", 445 )
              .attr("y", 85 )
              .style("text-anchor", "middle")
              .style("fill", "DeepSkyBlue")
              .text("all men");


})
