From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: Remove unused definitions
Date: Wed, 6 Aug 2014 12:14:30 -0700
Message-ID: <20140806191430.GA5711@roeck-us.net>
References: <1407347597-2168-1-git-send-email-xerofoiffy@gmail.com>
 <20140806183319.GA15654@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Richard Weinberger <richard.weinberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140806183319.GA15654-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Aug 06, 2014 at 11:33:19AM -0700, Greg KH wrote:
> On Wed, Aug 06, 2014 at 01:53:17PM -0400, Nick Krause wrote:
> > Remove unused definition which cause the following warnings
> > 
> > drivers/spi/spi-omap-100k.c:73:0: warning: "WRITE" redefined [enabled by default]
> > include/linux/fs.h:193:0: note: this is the location of the previous definition
> > drivers/spi/spi-omap-100k.c:74:0: warning: "READ" redefined [enabled by default]
> > include/linux/fs.h:192:0: note: this is the location of the previous definition
> > 
> > Signed-off-by: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/spi/spi-omap-100k.c | 4 ----
> >  1 file changed, 4 deletions(-)
> 
> Nick, you were warned about this numerous times in the past.
> 
> By changing email addresses you have now ensured that we will never
> listen to you, as you obviously are not listening to us.
> 
He does manage to get our attention, though. Also, it is not that simple -
for my part I keep looking out for the patches just to make sure that
we don't get any more less than well researched "fixes" into the kernel.
I figure it pays to spend some time now instead of having to clean up
the resulting mess if something slips by.

Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
