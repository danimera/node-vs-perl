package Auth;
use Mojo::Base -base;
use JSON::WebToken;
use Digest::SHA qw(sha256_hex);

has secret => sub { $ENV{JWT_SECRET} || 'change_this_secret' };

sub issue_token {
  my ($self, $username) = @_;
  my $payload = {
    username => $username,
    iat      => time,
    exp      => time + 3600,
  };
  return JSON::WebToken->encode($payload, $self->secret, 'HS256');
}

sub verify_token {
  my ($self, $token) = @_;
  return eval { JSON::WebToken->decode($token, $self->secret) };
}

1;
