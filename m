From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: Backport of spi-fsl-spi bugfix to 3.14.y
Date: Sun, 25 Jan 2015 14:07:23 -0800
Message-ID: <20150125220723.GD29924@kroah.com>
References: <1420472564.803.9.camel@gmail.com>
 <20150105154834.GV11764@sirena.org.uk>
 <CAOR3GqUBWyfUvNG-8JiPVkis6b_25Eq_REtcp=kLN3CUoqsG6g@mail.gmail.com>
 <20150123124529.GU21293@sirena.org.uk>
 <20150125173853.GA6467@kroah.com>
 <20150125201254.GX21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Esben Haabendal <esben.haabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150125201254.GX21293-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Jan 25, 2015 at 08:12:54PM +0000, Mark Brown wrote:
> On Sun, Jan 25, 2015 at 09:38:53AM -0800, Greg Kroah-Hartman wrote:
> > On Fri, Jan 23, 2015 at 12:45:29PM +0000, Mark Brown wrote:
> 
> > > So, I now see this has actually been merged into stable without getting
> > > to the bottom of why it's helping anything...  this is a bit worrying
> > > since it's adding new functionality and not really a bug fix.  It'd have
> > > been good to at least get a followup here.
> 
> > Do you want me to revert something from the stable tree?  If so, has it
> > also been reverted upstream?
> 
> The patch just isn't an obvious -stable patch - it's adding new
> functionality, not fixing a bug, and I was surprised to discover it had
> been added as a result.  It's fine as new functionality and therefore
> hasn't been reverted upstream.
> 
> We can probably leave it there, though if this is OK that's a bit of a
> change, but if this new functionality is a good fix then we're probably
> leaving other systems unfixed which isn't good, I would be very much
> happier if we understood what had changed here.  If new functionality is
> OK there's a probably a bunch of other changes we should be pulling
> back.

New functionality shouldn't be added, but sometimes things slip in due
to the volume of patches and how people word-smith changelog entries :(

greg k-h

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
