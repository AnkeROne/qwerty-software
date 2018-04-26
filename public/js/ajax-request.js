$(document).ready(function() {
    $.ajaxSetup(
    {
        headers:
        {
            'X-CSRF-Token': $('input[name="_token"]').val()
        }
    });

    $('#set-like').click(function(e){
        e.preventDefault();
        var post_id = parseInt($('#post_id').text());
        $('#set-like').toggleClass('show hidden');
        $('#unset-like').toggleClass('hidden show');
        str = $('#total-likes').text();
        count = str.split(':')
        count = parseInt(count[1]);
        newstr = 'Понравилось: <strong>' + (count + 1) + '</strong>';
        $('#total-likes').html(newstr);

        $.ajax({
            type: "POST",
            url: '/post/'+post_id+'/like',
            data: {post_id}
        });
    });

    $('#unset-like').click(function(e){
        e.preventDefault();
        var post_id = parseInt($('#post_id').text());
        $('#unset-like').toggleClass('show hidden');
        $('#set-like').toggleClass('hidden show');
        str = $('#total-likes').text();
        count = str.split(':')
        count = parseInt(count[1]);
        newstr = 'Понравилось: <strong>' + (count - 1) + '</strong>';
        $('#total-likes').html(newstr);

        $.ajax({
            type: "POST",
            url: '/post/'+post_id+'/dislike',
            data: {post_id}
        });
    });
});