$('#header').each(function () {
  var container = $(this);

  container.find('.menu .dropdown').parent().hover(
    function () {
      $(this).find('.dropdown').fadeIn(150);
    },
    function () {
      $(this).find('.dropdown').fadeOut(150);
    }
  ).
    addClass('javascripted');
});
