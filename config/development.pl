use File::Spec::Functions qw(catdir catfile rel2abs);
use File::Basename qw(dirname);
my $basedir = rel2abs(catdir(dirname(__FILE__), '..'));
my $dbpath = catfile($basedir, 'db', 'development.db');
+{
    'DBI' => [
        "dbi:SQLite:dbname=$dbpath", '', '',
        +{
            sqlite_unicode => 1,
        }
    ],
    'capistrano' => {
        PATH => '/Users/ysasaki/.rbenv/shims:/usr/local/bin:/usr/bin:/bin',
        project_dir => "/tmp/my-project", # cap must be installed by 'gem install --binstubs'
        env => {
            ENVS_YOU_NEED  => 'FOOBAR',
        }
    }
};
