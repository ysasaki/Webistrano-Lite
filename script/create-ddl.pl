#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use feature qw(say);
use FindBin qw($Bin);
use File::Spec;
use lib File::Spec->catdir($Bin, '..', 'lib');
use Webistrano::Lite::Schema;

say Webistrano::Lite::Schema->output;
