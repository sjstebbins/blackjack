class window.GraphView extends Backbone.View
  className: 'graph'

  template: _.template '<div id="chart"></div>'

  initialize: ->
    @render()
    chart = c3.generate({
    bindto: '#chart',
    data: {
      columns: [
        ['data1'].concat(@model.get('scoreHistory')),
      ]
    }
    });

  render: ->
    (@$el.html @template).fadeIn(1000)


