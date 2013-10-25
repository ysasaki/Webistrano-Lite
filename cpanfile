requires 'Amon2', '5.11';
requires 'AnyEvent';
requires 'AnyEvent::Run';
requires 'DBD::SQLite', '1.33';
requires 'DBIx::Schmae::DSL', '0.08';
requires 'EV';
requires 'HTML::FillInForm::Lite', '1.11';
requires 'JSON', '2.50';
requires 'Log::Minimal';
requires 'Module::Functions', '2';
requires 'Plack::Middleware::Session';
requires 'Plack::Middleware::Assets::RailsLike', '0.13';
requires 'Plack::Session', '0.14';
requires 'Router::Boom', '0.06';
requires 'Twiggy', '0.20';
requires 'Teng', '0.20';
requires 'Test::WWW::Mechanize::PSGI';
requires 'Text::Xslate', '2.0009';
requires 'Time::Piece', '1.20';
requires 'perl', '5.010_001';

on configure => sub {
    requires 'Module::Build', '0.38';
    requires 'Module::CPANfile', '0.9010';
};

on test => sub {
    requires 'Test::More', '0.98';
};
