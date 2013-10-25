package Webistrano::Lite::Schema;

use utf8;
use strict;
use warnings;
use DBIx::Schema::DSL;
use FindBin qw($Bin);
use File::Spec::Functions qw(catfile);

database 'SQLite';

default_unsigned;
default_not_null;

create_table 'stages' => columns {
    integer 'id', pk, auto_increment;
    varchar 'name', size => [ 1, 128 ];
    timestamp 'updated_on';
    datetime 'created_on';
};

create_table 'tasks' => columns {
    integer 'id', pk, auto_increment;
    text 'name';
    timestamp 'updated_on';
    datetime 'created_on';
};

1;
