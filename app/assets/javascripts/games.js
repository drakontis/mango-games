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

function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".nested_fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).after(content.replace(regexp, new_id));
}