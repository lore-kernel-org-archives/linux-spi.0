From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 11:16:31 -0700
Message-ID: <20150513181631.GB16811@kroah.com>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513171300.GD2761@sirena.org.uk>
 <20150513172028.GA18303@kroah.com>
 <20150513173922.GF2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513173922.GF2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, May 13, 2015 at 06:39:22PM +0100, Mark Brown wrote:
> On Wed, May 13, 2015 at 10:20:28AM -0700, Greg Kroah-Hartman wrote:
> > On Wed, May 13, 2015 at 06:13:00PM +0100, Mark Brown wrote:
> 
> > > So, that was my original suggestion too but people were complaining that
> > > this wasn't a generally supported feature and requires specific support
> > > of some kind in the bus (which nobody posted a patch for).
> 
> > I don't understand the complaint, it's a very "generally supported
> > feature" and has been there for a very long time for any bus that wants
> > to use it.
> 
> So it's not something that just works for all buses and someone would
> need to write a patch (hint, hint - that's one of the big blockers
> here)?  It is a bit surprising to me that this would be something that
> the buses would need to cope with individually since for most things the
> matching mechanics are taken care of in the driver core and we're
> explicitly overriding them here.

It should "just work" for all busses, but if you want to add a "new_id"
sysfs file, you need to add the logic for that to your bus.  It's the
bind/unbind files in the driver directories.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
