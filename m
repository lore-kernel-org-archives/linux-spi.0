From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 11:36:53 -0700
Message-ID: <20150513183653.GA879@kroah.com>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513171300.GD2761@sirena.org.uk>
 <20150513172028.GA18303@kroah.com>
 <20150513173922.GF2761@sirena.org.uk>
 <20150513181631.GB16811@kroah.com>
 <20150513183211.GK2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513183211.GK2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, May 13, 2015 at 07:32:11PM +0100, Mark Brown wrote:
> On Wed, May 13, 2015 at 11:16:31AM -0700, Greg Kroah-Hartman wrote:
> 
> > It should "just work" for all busses, but if you want to add a "new_id"
> > sysfs file, you need to add the logic for that to your bus.  It's the
> > bind/unbind files in the driver directories.
> 
> Oh, right.  For this to be useful here we'd need to implement a new_id
> file, bind and unbind don't do anything helpful here.  I think I'd have
> expected this to have a default implementation that non-enumerable buses
> could pick up.

No one has ever asked for that, so feel free to make a patch that adds
it :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
