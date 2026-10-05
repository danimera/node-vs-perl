#!/usr/bin/env perl
use Mojolicious::Lite -signatures;
use lib 'lib';
use Auth;
use JSON;

my $json = JSON->new->utf8;
my $auth = Auth->new;

# GET /status - public endpoint
get '/status' => sub ($c) {
  $c->render(json => { status => 'ok' });
};

# POST /login - issue JWT token
post '/login' => sub ($c) {
  my $data = $c->req->json || $c->req->body_params->to_hash;
  return $c->render(status => 400, json => { error => 'Invalid JSON' }) unless $data;

  my $username = $data->{'username'};
  my $password = $data->{'password'};

  return $c->render(status => 400, json => { error => 'username and password required' })
    unless $username && $password;


  # Simple hardcoded credentials for demo
  if ($username eq 'admin' && $password eq 'password') {
    my $token = $auth->issue_token($username);
    return $c->render(json => { token => $token });
  }

  return $c->render(status => 401, json => { error => 'Invalid credentials ' });
};

# Helper middleware for protected routes
helper check_jwt => sub ($c) {
  my $auth_header = $c->req->headers->authorization || '';

  return $c->render(status => 401, json => { error => 'No token provided' })
    unless $auth_header;

  my ($scheme, $token) = split ' ', $auth_header;

  return $c->render(status => 401, json => { error => 'Malformed token' })
    unless $scheme && $token && $scheme =~ /^Bearer$/i;

  my $payload = $auth->verify_token($token);

  return $c->render(status => 401, json => { error => 'Invalid token' })
    unless $payload;

  $c->stash(user => $payload);
  return 1;
};

# GET /products - protected, requires valid JWT
get '/products' => sub ($c) {
  return unless $c->check_jwt;

  my @products = (
    { id => 1, name => 'Producto A', price => 10.0 },
    { id => 2, name => 'Producto B', price => 20.5 },
    { id => 3, name => 'Producto C', price => 15.75 },
  );

  $c->render(json => {
    user     => $c->stash('user'),
    products => \@products,
  });
};

app->start;
