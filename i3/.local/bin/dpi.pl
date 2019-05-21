#!env perl

use common::sense;

my ($optimal_x_dpi, $optimal_y_dpi) = optimal_dpi();

say 'Current DPI: ', current_dpi();
say 'Optimal DPI: ', $optimal_x_dpi, ' x ', $optimal_y_dpi;

sub current_dpi {
  my $current_dpi = `xrdb -query | grep dpi`;
  $current_dpi =~ s/^Xft.dpi:\s+//;
  return $current_dpi;
}

sub optimal_dpi {
  my (
    undef,
    undef,
    undef,
    $resolution,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    $phys_x_inches,
    undef,
    $phys_y_inches
    ) = split(/ /, `xrandr | grep eDP1`);

  $phys_x_inches =~ s/m//g;
  $phys_y_inches =~ s/m//g;
  $phys_x_inches = $phys_x_inches / 25.4 ;
  $phys_y_inches = $phys_y_inches / 25.4 ;

  my (
    $resolution_x,
    $resolution_y,
    undef,
    undef
    ) = split(/[^\d]/, $resolution);

  my $optimal_x_dpi = $resolution_x / $phys_x_inches;
  my $optimal_y_dpi = $resolution_y / $phys_y_inches;

  return ($optimal_x_dpi, $optimal_y_dpi);
}
