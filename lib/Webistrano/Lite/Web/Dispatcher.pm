package Webistrano::Lite::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use AnyEvent;
use AnyEvent::Util qw(run_cmd fork_call);
use Log::Minimal;

any '/' => sub {
    my ($c) = @_;
    my $stages
        = $c->db->search( 'stages', undef, { order_by => { id => 'asc' } } );
    my $tasks
        = $c->db->search( 'tasks', undef, { order_by => { id => 'asc' } } );
    return $c->render(
        'index.tx',
        {   version => $Webistrano::Lite::VERSION,
            stages  => $stages,
            tasks   => $tasks,
        }
    );
};

post '/console' => sub {
    my ($c) = @_;

    my $req        = $c->request;
    my $cap_config = $c->config->{capistrano};

    return $c->streaming(
        sub {
            my $responder = shift;
            my $writer    = $responder->(
                [   200,
                    [   'Content-Type'      => 'text/plain; charset=utf-8',
                        'Transfer-Encoding' => 'chunked'
                    ]
                ]
            );

            # Exec a shell command
            my @binds = (
                $cap_config->{PATH},  $cap_config->{project_dir},
                $req->param('stage'), $req->param('task')
            );
            my $cmd = sprintf( <<EOM, @binds );
env - PATH=%s TERM=xterm sh -c '
exec 2>&1
cd %s
./bin/cap %s %s'
EOM

            my $cv = run_cmd $cmd,
                '<' => '/dev/null',
                '>' => sub {
                my ($data) = @_;
                if ( defined $data ) {
                    $writer->write($data);
                }
                };

            $cv->cb(
                sub {
                    my $cv        = shift;
                    my $exit_code = $cv->recv;
                    $writer->write("[EXIT CODE: $exit_code]\n");
                    $writer->close;
                }
            );
        }
    );
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};

1;
