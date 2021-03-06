package CatalystX::SimpleLogin;
use Moose::Role;
use CatalystX::InjectComponent;
use namespace::autoclean;

after 'setup_components' => sub {
    my $class = shift;
    CatalystX::InjectComponent->inject(
        into => $class,
        component => 'CatalystX::SimpleLogin::Controller::Login',
        as => 'Controller::Login'
    );
};

=head1 NAME

CatalystX::SimpleLogin - Provide a simple Login controller which can be reused

=head1 SYNOPSIS

    package MyApp;
    use Moose;
    use namespace::autoclean;

    use Catalyst qw/
        +CatalystX::SimpleLogin
        Authentication
        Session
        Session::State::Cookie
        Session::Store::File
    /;
    extends 'Catalyst';

    __PACKAGE__->config(
        'Plugin::Authentication' => { # Auth config here }
    );

    __PACKAGE__->setup;

=head1 DESCRIPTION

CatalystX::SimpleLogin is an application class L<Moose::Role|role> which will
inject a L<Catalyst::Controller|controller>
which is an instance of L<CatalystX::SimpleLogin::Controller::Login> into your
application. This provides a simple login and logout page with only one line of code.

=head1 REQUIREMENTS

=over

=item A Catalyst application

=item Working authentication configuration

=item Working session configuration

=item A TT view

=back

=head1 CUSTOMISATION

CatalystX::SimpleLogin is a prototype for CatalystX::Elements. As such, one of the goals
is to make it easy for users to customise the provided component to the maximum degree
possible, and also, to main a linear relationship between effort invested and level of
customisation achieved.

=head1 COMPONENTS

=over

=item *

L<CatalystX::SimpleLogin::Controller::Login> - first point of call for customisation.
Override the action configs to reconfigure the paths of the login or logout actions.
Subclass to be able to apply method modifiers to run before / after the login or
logout actions or override methods.

=item *

L<CatalystX::SimpleLogin::ControllerRole::Login> - provides the C<login> action
and associated methods. you can compose this manually yourself if you want just that
action.

=item *

L<CatalystX::SimpleLogin::ControllerRole::Login::WithRedirect> - provides the C<login>
action with a wrapper to redirect to a page which needs authentication, from which the
user was previously redirected. Goes hand in hand with L<Catalyst::ActionRole::NeedsLogin>

=item *

L<CatalystX::SimpleLogin::Form::Login> - the L<HTML::FormHandler> form for the login form.

=item *

L<Catalyst::ActionRole::NeedsLogin> - Used to cause a specific path to redirect to the login
page if a user is not authenticated.

=back

=head1 TODO

Here's a list of what I think needs working on, in no particular order.

Please feel free to add to or re-arrange this list :)

=over

=item Fix the Template including - breaks if native templating has .tt2 extension

=item Fix wrappers with templates

=item Form templating - enable per form template + per field type and per field templates

=item Fix extension documentation

=item Document all this stuff.

=item Examples of use / customisation in documentation

=item Fixing one uninitialized value warning in LoginRedirect

=item Disable the use of NeedsLogin ActionRole when theoginRedirect is not loaded

=back

=head1 SOURCE CODE

    http://github.com/bobtfish/catalyst-actionrole-acl/tree/master

    git://github.com/bobtfish/catalyst-actionrole-acl.git

Forks and patches are welcome. Please speak to t0m or zby on #catalyst (irc.perl.org)
if you want to hack on something and need a hand. :)

=head1 SEE ALSO

=over

=item L<Catalyst>

=item L<Moose> and L<Moose::Role>

=item L<MooseX::MethodAttributes::Role::Meta::Role>

=item L<CatalystX::InjectComponent>

=item L<HTML::FormHandler>

=item L<Catalyst::View::TT>

=item L<Catalyst::Plugin::Authentication>

=item L<Catalyst::Plugin::Session>

=item L<Catalyst::Controller::ActionRole>

=back

=head1 AUTHORS

=over

=item Tomas Doran (t0m) C<< <bobtfish@bobtfish.net> >>

=item Zbigniew Lukasiak

=item Stephan Jauernick (stephan48) C<< <stephan@stejau.de> >>

=item Gerda Shank (gshank) C<< gshank@cpan.org >>

=back

=head1 LICENSE

Copyright 2009 Tomas Doran. Some rights reserved.

This sofware is free software, and is licensed under the same terms as perl itself.

=cut

1;

