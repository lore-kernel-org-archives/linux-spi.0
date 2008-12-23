From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.28-rc9] spi:
	spi_write_then_read() regression fix
Date: Tue, 23 Dec 2008 10:37:53 -0800
Message-ID: <200812231037.53955.david-b@pacbell.net>
References: <200812202332.36281.david-b@pacbell.net>
	<200812211648.26699.david-b@pacbell.net>
	<200812230254.00249.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ingo Oeser <ioe-lkml-MFZNYGWX9eyELgA04lAiVw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200812230254.00249.ioe-lkml-MFZNYGWX9eyELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday 22 December 2008, Ingo Oeser wrote:
> Hi David,
> 
> On Monday 22 December 2008, you wrote:
> > 	  The write_then_read() helper is
> > simplifying a common half-duplex idiom for short operations,
> > but the hardware still does full duplex.  Buffer layout is:
> > 
> >   Before:	WWWWW0000000
> >   After:	xxxxxRRRRRRR
> > 
> > That is, for every bit shifted out (W, 0) another one gets
> > shifted in (x, R).  The I/O primitive essentially swaps
> > contents of a one-word shift register between master and
> > slave; or, sequences of such words.  Words don't need to
> > be byte-size, though that's a common option.
> 
> ...
> 
> Wow, what interesting hardware logic and a nice explanation.

It's standard SPI ... yes, it's kind of interesting, and I've
not come across anything else that synchronizes RX and TX in
quite the same way.

I suspect that hardware designers find the ability to get
quick transfers (tens of megabits/second) from just a shift
register is fairly attractive.  Less work than high speed
I2C, for one example.


> Could you put that into a comment somewhere close to those helpers?

Fair enough.  That file does lack any mention of the I/O model
for SPI ... and it's certainly a bit of a surprise to anyone
who's not had to look at it before!

 
> You can safely assume, that any code which Linus doesn't understand
> is non-trivial and needs a comment :-)

I'm not sure I'd agree with that -- while he's many things,
"expert in everything" is not one of them! -- but I do agree
that comment would be worth adding.


However, with regards to $PATCH ... considering that the '28
release is just around the corner, I changed my mind and would
suggest just reverting f9b90e39cbc5c4d6ef60022fd1f25d541df0aad1
much though I very much like that fix in general.

Reason being:  it needs a bit more work, I forgot that it will
break for example drivers using drivers/spi/omap_uwire.c since
that is built on top of truly half-duplex hardware.  (Used with
OMAP1 SOCs.)  The kerneldoc says it's for providing MicroWire
style transactions, so it's kind of significant that it work
on MicroWire hardware too.  ;)

So an updated version would need to both zero the TX bits when
using normal full-duplex SPI hardware ... and use more or less
the current code when running on half-duplex variants.

- Dave



------------------------------------------------------------------------------
