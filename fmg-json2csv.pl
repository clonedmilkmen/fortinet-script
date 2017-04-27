#!/usr/bin/perl
use JSON;

##
## usage: fmg-json2csv.pl > output.csv

$json = JSON->new->allow_nonref;

local $/ = undef;
open FILE, 'data.json' or die "Could not open data.json";
binmode FILE;
$data = <FILE>;
close FILE;

$fmg = $json->decode($data);

@cols = ('name', 'sn', 'ip', 'platform_str');

printf("%s\n",
  join ',', @cols
  );

foreach $device (@{$fmg->{'params'}->[0]->{'data'}}) {
  @vals = ();
  foreach $col (@cols) {
    push @vals, $device->{$col};
  }
  printf("%s\n",
    join ',', @vals
    );
}
