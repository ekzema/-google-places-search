(function( $ ) {
    $.widget( "app.autocomplete", $.ui.autocomplete, {
        _renderItem: function( ul, item ) {
            const result = this._super( ul, item );

            if ( item.logo ) {
                result.find( "div" )
                    .prepend(' ')
                    .addClass(item.logo)
                    .addClass(function(){
                        return item.disabled > 0 ? item.logo + ' ui-red ' : item.logo;
                    });
            }

            return result;
        }
    });
})( jQuery );

$(function() {
    $('#searchInput').autocomplete({
        minLength: 3,
        source: function(request, response)
        {
            $.ajax({
                url: '/businesses/autocomplete',
                dataType: "json",
                data: {type: $('input[name=type_search]:checked', '#business_form').val(), q: $('input[name=q]', '#business_form').val()},
                success: response
            });
        },
        select: function (e, ui) {
            if (ui.item.disabled > 0) return false;

            $('#place_id').val(ui.item.place_id);
            $('#id').val(ui.item.id);
            $('#submit_btn').prop('disabled', false);

            return true;
        },
    }).on('input', function(){
        $('#submit_btn').prop('disabled', true);
        $('#place_id').val('');
        $('#id').val('');
    });
});
