#
# Copyright (C) 2017 Nethesis S.r.l.
# http://www.nethesis.it - nethserver@nethesis.it
#
# This script is part of NethServer.
#
# NethServer is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License,
# or any later version.
#
# NethServer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with NethServer.  If not, see COPYING.
#

package NethServer::Database::Esdb;

use strict;
use Net::DBus;

sub TIEHASH
{
    my $class = shift;
    my $database = shift;
    my $bus = Net::DBus->system();
    my $service = $bus->get_service("org.nethserver.toweld1");
    my $object = $service->get_object('/org/nethserver/toweld1/Esdb/' . $database);
    my $self = {
        'bus' => $bus,
        'service' => $service,
        'object' => $object,
        'iterator' => []
    };
    bless $self, $class;
    return $self;
}


sub FETCH
{
    my $self = shift;
    my $key = shift;

    return $self->{'object'}->GetRaw($key);
}


sub STORE
{
    
}


sub DELETE
{
        
}


sub CLEAR
{
        
}


sub EXISTS
{
    my $self = shift;
    my $key = shift;
    my $value = $self->{'object'}->GetRaw($key);
    return ($value ? 1 : 0)
}


sub FIRSTKEY
{
    my $self = shift;
    $self->{'iterator'} = $self->{'object'}->Keys();
    return $self->{'iterator'}->[0];
}


sub NEXTKEY
{
    my $self = shift;
    return shift $self->{'iterator'};
}

1;
