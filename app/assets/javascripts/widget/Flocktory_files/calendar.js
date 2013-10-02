h.Calendar = function(element, options) {
  this.options = _.extend({}, this.options, options || {});
  this.element = element;

  this.element.datepicker(this.options);
};

h.Calendar.prototype.options = {
  monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
  dayNamesMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'] ,
  firstDay: 1,
  dateFormat: 'dd.mm.y',
  prevText: '←',
  nextText: '→'
};
