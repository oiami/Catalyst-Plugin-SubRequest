package TestApp;

use Catalyst qw[-Engine=Test SubRequest];

__PACKAGE__->config(
    name=>"subrequest test"
);

__PACKAGE__->setup();

    sub begin : Private {
        my ( $self, $c ) = @_;
        $c->res->body($c->res->body().'1');
    }

    sub subreq : Global {
        my ( $self, $c ) = @_;
        $c->log->info("self is ".  ref $self);
        $c->log->info("Context is ". ref $c);
        my $subreq= $c->res->body() .
                        $c->subreq('/normal');
        $c->res->body($subreq);
    }
  
    sub normal : Global {
        my ( $self, $c ) = @_;
        $c->res->body($c->res->body().'2');
    }
    
    sub end : Private {
        my ( $self, $c ) = @_;
        $c->res->body($c->res->body().'3');
    }


1;
