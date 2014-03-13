From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: bitbang: add lsb first support
Date: Thu, 13 Mar 2014 19:11:36 +0100
Message-ID: <20140313181107.GT3327@book.gsilab.sittig.org>
References: <1394637636-29042-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394637636-29042-3-git-send-email-m.grzeschik@pengutronix.de>
 <20140312212941.GP3327@book.gsilab.sittig.org>
 <20140312213544.GX28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140312213544.GX28112-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 12, 2014 at 21:35 +0000, Mark Brown wrote:
> 
> On Wed, Mar 12, 2014 at 10:29:41PM +0100, Gerhard Sittig wrote:
> 
> > Would it be useful to not duplicate the transmission logic, but
> > instead to optionally "bit swap" the TX and RX data before and
> > after the common transmission logic?  Just a though whether this
> > might help maintenance.  There might even be existing and proven
> > code to bit swap integers?
> 
> I was wondering myself, but on the other hand that's an extra operation
> and this is about as CPU intensive as one can get.

Actually I thought that bitbanging pins including the timing
would be the most expensive part, and that swapping bits might
not be negligable but could be acceptable in comparison.  But
this was just a guess, no research was done.


http://graphics.stanford.edu/~seander/bithacks.html#BitReverseObvious
and the following sections suggest that code might get less
expensive when you accept to no longer see at first glance what's
happening.  Given a good identifier and an appropriate comment,
http://graphics.stanford.edu/~seander/bithacks.html#ReverseParallel
might be acceptable for mainline.

Naively reading the code, you would expect some 15 assembly
instructions and only two registers in use (for ARM).  A quick
experiment shows that the 32bit constants add some more work, yet
the complete swapping is done in 88 bytes of code (a sequence of
19 instructions and three constants).  Other architectures weight
in at some 120 bytes of code.

How do some 50 additional CPU instructions sound (calling the bit
swapper two times), in comparison to the whole SPI bitbanging
loop, for the optional case of LSB first transfers and 32bit
data?  In contrast to duplicating the core bitbanging routine's
body (two times for differing SPI modes).


BTW are these bitbang routines referenced from several sites, not
only spi-gpio.c.  They encode "be" in their name which might
become misleading then they operate in LSB mode as well.

And spidelay() appears to sometimes be a NOP -- could this be the
reason for unreliable data transmission and bit errors in certain
environments (optimized code, inlined GPIO access, fast CPU, slow
SPI slave), instead of the suspected receiver's bit shifting?


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
