jQuery(function($){
    $("#comment_to_game").bind('ajax:success', function(status, data, xhr) {
        var comments_div = $('#comments_to_game_div');
        var comment_body = $('#comment_body');

        comments_div.prepend(data);
        comment_body.val('');
    });

    $("#comment_to_game").bind('ajax:failure', function(xhr, status, error) {
        alert("failure!");
    });

    $("#comment_to_game").bind('ajax:before', function(data, status, xhr) {
       // add a spinner
    });
});