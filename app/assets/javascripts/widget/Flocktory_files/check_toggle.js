h.check_toggle = function(_input) {
    (function(input) {
        var url = input.data('url') ||
            input.closest('form').attr('action');

        var data = {
            '_method': 'put',
            'authenticity_token': h.current.authenticity_token
        };

        data[input.attr('name')] = input.prop('checked');

        input.prop('disabled', true);

        $.ajax({
            'url': url,
            'type': 'post',
            'dataType': 'json',
            'data': data
        }).complete(function() {
            input.prop('disabled', false);
        });
    })(_input);
};
