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
        # cap must be installed by 'gem install --binstubs'
        project_dir => "/tmp/my-project",
        env => {
            PATH => '/Users/ysasaki/.rbenv/shims:/usr/local/bin:/usr/bin:/bin',
            ENVS_YOU_NEED  => 'FOOBAR',
        }
    }
};
