#!/usr/bin/perl -w
use Tk;
use strict;

my $mw;
my $menu_main;
my $menu_appis;
my $menu_entrees;
my $menu_desserts;
my $menu_beers;
my $menu_wines;
my $navigation;
my $am;
my $em;
my $dm;
my $wm;
my $bm,
my $tm;
my $op_flg = 0;

my $n_menu_main;
my $n_menu_appis;
my $n_menu_entrees;
my $n_menu_desserts;
my $n_menu_beers;
my $n_menu_wines;
#my @ma;

my @menu_frames;

my $footer_fr;
my $orders_fr;
my $msg;
my $list;
my $mname_len = 0;
my $sign;

my @beers;
my @entrees;
my @appis;
my @desserts;
my @wines;
my @nav_menu;
my $current_frame;
my $total;
my @order_list;
my @orders_hlist;

my %menu = (
     # APPETIZERS
    'caprese_pltr'	=> { mname => 'Capreses Platter', price => 14, ksym => 'Caprese'},
    'sausage'		=> { mname => 'Sausage Small Plate', price => 9.5, ksym => 'Sausage S/P'},
    'soup'		=> { mname => 'Soup', price => 8, ksym => 'Soup'},
    'cheese_pltr'	=> { mname => 'Cheese Platter', price => 14, ksym => 'Cheese Plt'},
    'house_salad'	=> { mname => 'House Salad', price => 12, ksym => 'House Salad'},
    'caesar_salad'	=> { mname => 'Caesar Salad', price => 12, ksym => 'Caesar'},
    'paprika_pltr'	=> { mname => 'Paprika Platter', price => 18, ksym => 'Paprika Pltr'},
    'vegan_sausage' 	=> { mname => 'Vegan Sausage', price => 9.5, ksym => 'Vegan Ssg'},

    # ENTREES 
    'paprika_goulash'		=> { mname => 'Paprika Goulash', price => 21.5, ksym => 'Pap Glsh'},
    'chicken_paprikash'		=> { mname => 'Chicken Paprikash', price => 22, ksym => 'Chicken Pap'},
    'szeged_goulash'		=> { mname => 'Szeged Goulash', price => 22.5, ksym => 'Szeged G'},
    'vegetable_goulash'		=> { mname => 'Vegetable Goulash', price => 20, ksym => 'Vege G'},
    'polish_kielbasa_2'		=> { mname => 'Polish Kielbasa_2', price => 18, ksym => '2 Kielbasa'},
    'sausages_choice_2'		=> { mname => 'Sausages 2', price => 18.5, ksym => 'Sausages 2'},

    # DESSERTS
    'strudel'			=> { mname => 'Apple Strudel', price => 9, ksym => 'strudl'},
    'chocolate_cake'		=> { mname => 'Chocolate Cake', price => 9.5, ksym => 'choc cake'},
    'cheese_cake'		=> { mname => 'Cheese Cake', price=> 9.5, ksym => 'cheesecake'},

    # WINES
    'hahn_cabernet_gls' 	=> { mname => 'Hahn Cabernet Gls', price => 9, ksym => 'Glas'},
    'hahn_cabernet_bot' 	=> { mname => 'Hahn Cabernet Gls', price => 36, ksym => 'Bot'},
    'herman_kadarka_gls'	=> { mname => 'Herman Kadarka Gls', price => 13, ksym => 'Glas'},
    'herman_kadarka_bot'	=> { mname => 'Herman Kadarka Bot', price => 52, ksym => 'Bot'},
    'kekfrankos_gls'		=> { mname => 'Kekfrankos Gls', price => 13, ksym => 'Glas'},
    'kekfrankos_bot'		=> { mname => 'Kekfrankos Bot', price => 52, ksym => 'Bot'},
    'santa_julia_malbec_gls'	=> { mname => 'Santa Julia Malbec Gls', price => 8, ksym => 'Glas'},
    'santa_julia_malbec_bot'	=> { mname => 'Santa Julia Malbec Bot', price => 32, ksym => 'Bot'},
    'doqi_saperavi_gls'		=> { mname => 'Doqi Saperavi Gls', price => 12, ksym => 'Glas'},
    'doqi_saperavi_bot'		=> { mname => 'Doqi Saperavi Bot', price => 48, ksym => 'Bot'},
    'pratsch_grunervelt_gls'	=> { mname => 'Pratsch Gruner Velt Gls', price => 8, ksym => 'Glas'},
    'pratsch_grunervelt_bot'	=> { mname => 'Pratsch Gruner Velt Bot', price => 32, ksym => 'Bot'},
    'patricius_tikaji_gls'	=> { mname => 'Patricius Tikaji Gls', price => 12, ksym => 'Glas'},
    'patricius_tikaji_bot'	=> { mname => 'Patricius Tikaji Bot', price => 48, ksym => 'Bot'},
    'annabella_chardonnay_gls'	=> { mname => 'Annabella Chardonnay Gls', price => 9, ksym => 'Glas'},
    'annabella_chardonnay_bot'	=> { mname => 'Annabella Chardonnay Bot', price => 36, ksym => 'Bot'},
    'sziegl_olaszrizling_gls'	=> { mname => 'Sziegll Olaszrizling Gls', price => 12, ksym => 'Glas'},
    'sziegl_olaszrizling_bot'	=> { mname => 'Sziegll Olaszrizling Bot', price => 44, ksym => 'Bot'},
    'fuleke_pallas_takaji_gls'	=> { mname => 'Fuleke Pallas Takaji Gls', price => 52, ksym => 'Bot'},
    'sparkling_wine_gls'	=> { mname => 'Sparkling Wine Gls', price => 7, ksym => 'Glas'},
    'sparkling_wine_bot'	=> { mname => 'Sparkling Wine Bot', price => 28, ksym => 'Bot'},

    # BEERS
    'czechvar_16'		=> { mname => 'Czechvar 16oz', price => 8, ksym => '16oz'},
    'czechvar_32'		=> { mname => 'Czechvar 32oz', price => 15, ksym => '32oz'},
    'czechvar_boot'		=> { mname => 'Czechvar Boot', price => 16, ksym => 'boot'},
    'pilsner_16'		=> { mname => 'Pilsner 16oz', price => 7.5, ksym => '16oz'},
    'pilsner_32'		=> { mname => 'Pilsner 32oz', price => 14, ksym => '32oz'},
    'pilsner_boot'		=> { mname => 'Pilsner Boot', price => 15, ksym => 'boot'},
    'erdinger_16'		=> { mname => 'Erdinger 16oz', price => 8, ksym => '16oz'},
    'erdinger_32'		=> { mname => 'Erdinger 32oz', price => 15, ksym => '32oz'},
    'erdinger_boot'		=> { mname => 'Erdinger Boot', price => 16, ksym => 'boot'},
    'paulaner_16'		=> { mname => 'Paulaner 16oz', price => 8, ksym => '16oz'},
    'paulaner_32'		=> { mname => 'Paulaner 32oz', price => 15, ksym => '32oz'},
    'paulaner_boot'		=> { mname => 'Paulaner Boot', price => 16, ksym => 'boot'}, 
    'coronado_16'		=> { mname => 'Coronado 16oz', price => 8.5, ksym => '16oz'},
    'coronado_32'		=> { mname => 'Coronado 32oz', price => 16, ksym => '32oz'},
    'coronado_boot'		=> { mname => 'Coronado boot', price => 16, ksym => 'boot'},
    'st_pauli'			=> { mname => 'Sankt Pauli', price => 6, ksym => 'St Pauli'},
);
my %beer_map = (
    Czechvar 	=> [ qw( czechvar_16 czechvar_32 czechvar_boot ) ],
    Pilsner	=> [ qw( pilsner_16 pilsner_32 pilsner_boot    ) ],
    Erdinger	=> [ qw( erdinger_16 erdinger_32 erdinger_boot ) ],
    Coronado	=> [ qw( coronado_16 coronado_32 coronado_boot ) ],
    Paulaner	=> [ qw( paulaner_16 paulaner_32 paulaner_boot ) ],
);

my %wine_map = (
    'Hahn Cab'		=> [ qw( hahn_cabernet_gls hahn_cabernet_bot ) ],
    'Herman Kadarka'	=> [ qw( herman_kadarka_gls herman_kadarka_bot ) ],
    'Kekfrankos'	=> [ qw( kekfrankos_gls kekfrankos_bot) ],
    'Sant Julia'	=> [ qw(santa_julia_malbec_gls santa_julia_malbec_bot ) ],
    'Doqi Saparevi'	=> [ qw(doqi_saperavi_gls doqi_saperavi_bot ) ],
    'Pratsch Grnvlt'	=> [ qw(pratsch_grunervelt_gls pratsch_grunervelt_bot ) ],
    'Patricius Tikaji'	=> [ qw(patricius_tikaji_gls patricius_tikaji_bot ) ],
    'Annabella Chard'	=> [ qw(annabella_chardonnay_gls annabella_chardonnay_bot ) ],
    'Sziegle'		=> [ qw(sziegl_olaszrizling_gls sziegl_olaszrizling_bot ) ],
    'Fuleke'		=> [ qw(fuleke_pallas_takaji_gls ) ],
    'Sparkling Wine'	=> [ qw(sparkling_wine_gls sparkling_wine_bot ) ],
);

my @custxt = ('Get lost....', 'Black Lives Matter', 'Credit Card surcharge is %2');

@appis = qw(sausage soup caprese_pltr cheese_pltr house_salad caesar_salad vegan_sausage);
@entrees = qw( paprika_goulash szeged_goulash chicken_paprikash vegetable_goulash polish_kielbasa_2 sausages_choice_2 );
@desserts = qw(strudel chocolate_cake cheese_cake);
@nav_menu = ('Appetizers', 'Entrees', 'Desserts', 'Wines', 'Beers', 'Top Menu');

$mw		= MainWindow->new(-background => 'white');
$menu_appis	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$menu_entrees	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$menu_desserts	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$menu_wines	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$menu_beers	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$menu_main	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$navigation	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$footer_fr	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$orders_fr	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');

$n_menu_appis	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$n_menu_entrees	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$n_menu_desserts = $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$n_menu_wines	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$n_menu_beers	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');
$n_menu_main	= $mw->Frame(-borderwidth => 4, -relief => 'groove', -background => 'white');

$mw->Label(-text => 'Paprika', -foreground => 'red', -background => 'white')->pack;
$menu_appis->Label(-text => 'Appetizers', -background => 'white')->grid(-row => 0, -column => 0, -columnspan => 4);
$menu_entrees->Label(-text => 'Entrees', -background => 'white')->grid(-row => 0, -column => 0, -columnspan => 4);
$menu_desserts->Label(-text => 'Desserts', -background => 'white')->grid(-row => 0, -column => 0, -columnspan => 4);
$menu_wines->Label(-text => 'Wines', -background => 'white')->grid(-row => 0, -column => 0, -columnspan => 4);
$menu_beers->Label(-text => 'Beers', -background => 'white')->grid(-row => 0, -column => 0, -columnspan => 4);

$n_menu_appis->Label(-text => 'Appetizers', -background => 'green')->grid(-row => 0, -column => 0, -columnspan => 4);
$n_menu_entrees->Label(-text => 'Entrees', -background => 'green')->grid(-row => 0, -column => 0, -columnspan => 4);
$n_menu_desserts->Label(-text => 'Desserts', -background => 'green')->grid(-row => 0, -column => 0, -columnspan => 4);
$n_menu_wines->Label(-text => 'Wines', -background => 'green')->grid(-row => 0, -column => 0, -columnspan => 4);
$n_menu_beers->Label(-text => 'Beers', -background => 'green')->grid(-row => 0, -column => 0, -columnspan => 4);


@menu_frames = (\$menu_appis, \$menu_entrees, \$menu_desserts, \$menu_wines, \$menu_beers);

my %nav_map = ( 
    Appetizers	 => [ $menu_appis, $am ],
    Entrees      => [ $menu_entrees, $em ],
    Desserts     => [ $menu_desserts, $dm ],
    Wines        => [ $menu_wines, $wm ],
    Beers        => [ $menu_beers, $bm ],
    'Top Menu'	 => [ $menu_main, $tm ],
);

my $k;
my $r;
my $c;
my $i;


##########################
### FILL IN THE FRAMES
# DRINKS MENUS
################## 
create_drink_menus( \%wine_map, \$menu_wines);
create_drink_menus(\%beer_map, \$menu_beers);

###########
## FOOD MENUS
###########
create_food_menus(\@appis, \$menu_appis, 0);
create_food_menus(\@entrees, \$menu_entrees, 0);
create_food_menus(\@desserts, \$menu_desserts, 0);

create_drink_menus( \%wine_map, \$n_menu_wines);
create_drink_menus(\%beer_map, \$n_menu_beers);
create_food_menus(\@appis, \$n_menu_appis, 1);
create_food_menus(\@entrees, \$n_menu_entrees, 1);
create_food_menus(\@desserts, \$n_menu_desserts, 1);

#############
## NAV FRAME
#############
$c = 0;
foreach $i (@nav_menu) {
    $nav_map{$i}[1] = $navigation->Button(-text => $i,
	-background => 'blue',
	-foreground => 'white',
	-command => sub { $current_frame->packForget();
	    $current_frame = $nav_map{$i}[0];
	    $current_frame->pack();
	    if ($current_frame == $menu_main) { $navigation->packForget(); }
		$footer_fr->pack(-after => $nav_map{$i}[0]); }
		)->grid(-row => 0, -column => $c);
	        $c++;
}
############
## FOOTER
############
$c = 0;

$footer_fr->Button(-text => 'Print',
	-background => 'blue',
	-foreground => 'white',
	-command => sub { $total = 0; @order_list = ();}
	)->pack(-side => 'right');

$footer_fr->Button(-text => 'Quit',
	-background => 'blue',
	-foreground => 'white',
	-command => sub { exit; }
	)->pack(-side => 'left');

$footer_fr->Button(-text => 'Clear',
	-background => 'blue',
	-foreground => 'white',
	-command => sub { $total = sprintf("%.2F", 0);
		    @order_list = ();
		    @orders_hlist = ();
		    $msg->configure(-text => "Total: \$$total");
		    $list->configure(-listvariable => \@orders_hlist);
		}
	)->pack(-side => 'left');

$footer_fr->Button(-text => 'CE',
	-background => 'blue',
	-foreground => 'white',
	-command => sub { pop(@order_list); pop(@orders_hlist); \&calc_total(\$total); $msg->configure(-text => "Total:  \$$total");}
	)->pack(-side => 'right');

$sign = $footer_fr->Checkbutton(-text => '-',
	-background => 'blue',
	-foreground => 'white',
	-command    => sub { if ($op_flg == 0) {
				 $op_flg = 1;
				  $list->configure(-background => 'tomato')
			     } elsif ($op_flg == 1) {
				 $op_flg = 0;
				 $list->configure(-background => 'white');
			     }
			   },
	)->pack(-side => 'left');

$footer_fr->Button(-text => 'Show',
	-background => 'blue',
	-foreground => 'white',
	-command => sub { foreach $i (@order_list) { print "$menu{$i}{'price'}\t$menu{$i}{'mname'}\n"; } print "$total\n"; }
	)->pack(-side => 'left');

################
## ORDERS FRAME
################
$total = '0.00';
$msg = $orders_fr->Message(-text => "Total:  \$'$total", -width => '100', -background => 'white' )->pack(-side => 'top');

foreach my $k (keys %menu) {
    my $l;
    $l = length($menu{$k}{'mname'});
    if ($l > $mname_len) {
	$mname_len = $l;
    }
}

$list = $orders_fr->Listbox(-listvariable => \@orders_hlist, -background => 'white', -height => 30, -width => $mname_len)->pack();

# Main Window
foreach $i (@nav_menu) {
    $menu_main->Button(-text => $i, -background => 'white',
	-command => sub {$menu_main->packForget();
			 $current_frame = $nav_map{$i}[0];
			 $navigation->pack(-side => 'top');
			 $orders_fr->pack(-side => 'right',);
			 $nav_map{$i}[0]->pack();
#			 $footer_fr->pack(-after => $nav_map{$i}[0]); }
			 $footer_fr->pack(-side => 'bottom'); }
			)->pack;
}

$current_frame = $menu_main;
$menu_main->pack();
MainLoop;

sub output {
    foreach $i (@order_list) {
	print "$menu{$i}{'price'}\t$menu{$i}{'mname'}\n";
	$total += $menu{$i}{'price'};
    }
    print "Total: $total\n";
}

sub calc_total {
    my $tot_ref = shift;
    my $t = 0;
    foreach $i (@order_list) {
	$t += $menu{$i}{'price'};
    }
    $$tot_ref = sprintf("%.2F", $t);
} 

sub math_op {
    my $o = shift;
    my $ind = 0;
    if ($op_flg == 0) {
	push @order_list, $$o;
	push @orders_hlist, $menu{$$o}{'mname'};
    } elsif ($op_flg == 1) {
	foreach $i (@order_list) {
	    if ($i =~ m/$$o/) {
		splice(@order_list, $ind, 1);
		splice(@orders_hlist, $ind, 1);
		last;
	    } else { 
		$ind++;
	    }
	}	    
    }
}

sub create_food_menus {
    my $grp = shift;
    my $fr = shift;
    my $r = 1;
    my $c = 0;

    foreach $i (@$grp) {
	$$fr->Button(-text => $menu{$i}{'ksym'},
		-background => 'white',
		-command => sub { \&math_op(\$i);
			&calc_total(\$total);
			$msg->configure(-text => "Total:  \$$total");
			},
		)->grid(-row => $r, -column => $c);
	$c++;
	if ( $c >= 3 ) { $r++; $c = 0; }
    }
}

sub create_drink_menus {
    my $dmap = shift;
    my $fr = shift;
    $r = 1;
    $c = 0;

    foreach $k (sort keys %$dmap) {
	$$fr->Label(-text => $k, -background => 'white')->grid(-column => $c, -row => $r);	
	$c++;
	foreach $i ( @{ $$dmap{$k} }) {
	    $$fr->Button(-text => $menu{$i}{'ksym'},
			 -background => 'white',
			 -command => sub { \&math_op(\$i);
				&calc_total(\$total);
				$msg->configure(-text => "Total:  \$$total");
			  },
			)->grid(-row => $r, -column => $c );
	    $c++;
	}
	$r++;
	$c = 0;
    }
}

