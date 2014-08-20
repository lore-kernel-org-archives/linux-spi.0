From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: Remove unused definitions
Date: Wed, 20 Aug 2014 22:26:02 +0200
Message-ID: <20140820202235.GA28350@xo-6d-61-c0.localdomain>
References: <1407347597-2168-1-git-send-email-xerofoiffy@gmail.com>
 <17153.1407349640@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Richard Weinberger <richard.weinberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <17153.1407349640-+bZmOdGhbsPr6rcHtW+onFJE71vCis6O@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed 2014-08-06 14:27:20, Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org wrote:
> On Wed, 06 Aug 2014 13:53:17 -0400, Nick Krause said:
> > Remove unused definition which cause the following warnings
> > 
> > drivers/spi/spi-omap-100k.c:73:0: warning: "WRITE" redefined [enabled by default]
> > include/linux/fs.h:193:0: note: this is the location of the previous definition
> > drivers/spi/spi-omap-100k.c:74:0: warning: "READ" redefined [enabled by default]
> > include/linux/fs.h:192:0: note: this is the location of the previous definition
> 
> > -#define WRITE 0
> > -#define READ  1
> 
> NAK.  Full stop.  These are potentially used in an inner macro someplace, and by
> removing these, the conflicting values from fs.h will be used instead.
> 
> #define READ                    0
> #define WRITE                   RW_MASK
> 
> So if there *is* a use in an inner macro, you just screwed the pooch
> and introduced a bug in this "clean up" - somebody will be expecting to see
> a 0 for a READ, and will receive a 1 instead.  This can't end well.

Actually.. having macros called READ and WRITE in fs.h is already something I'd say
can't end well. Can we rename those?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
