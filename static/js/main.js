if (typeof(window.console) == "undefined") { console = {}; console.log = console.warn = console.error = function(a) {}; }

$(function () {
    var $form = $('#select_task');
    var $submit = $('#run_task');
    var $status = $('#current_status');
    var $console_log = $('#console');
    var interval_ms = 1000

    var set_status = function(status, class_name) {
        console.log("status " + status);
        if (class_name) {
            $status.html('<span class="text-' + class_name + '">' + status + '</span>');
        } else {
            $status.text(status);
        }
    };

    var update_console_log = function(output, last_pos) {
        if (output && output.length - 1 !== last_pos) {
            var current_output = output.substr(last_pos);
            $console_log.append(_.escape(current_output));
            return output.length - 1;
        } else {
            return last_pos;
        }
    };

    $submit.click(function(event){
        $submit.attr('disabled','disabled');
        var timer;
        var last_pos = 0;

        $.ajax({
            url: '/console',
            type: 'post',
            data: $form.serialize(),
            xhrFields: {
                onloadstart: function() {
                    set_status('Running', 'info');
                    $console_log.text('');

                    var xhr = this;
                    timer = setInterval(function(){
                        last_pos = update_console_log(xhr.responseText, last_pos);
                    }, interval_ms);
                }
            },
            success: function() {
                // TODO
            },
            error: function() {
                // TODO
            },
            complete: function() {
                var xhr = this;
                setTimeout(function() {
                    clearInterval(timer);
                    update_console_log(xhr.responseText, last_pos);
                    var exit_code = $console_log.text().match(/\[EXIT CODE: (\d+)\]/);
                    console.log(exit_code);
                    if (exit_code[1] && exit_code[1] == 0) {
                        set_status('Success', 'success');
                    } else {
                        set_status('Error', 'danger');
                    }
                    $submit.removeAttr('disabled');
                }, interval_ms);
            }
        });
    });
});
