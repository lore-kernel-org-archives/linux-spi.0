From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: problems with atmel_spi interface & ads
	under 2.6.23
Date: Fri, 23 Nov 2007 07:52:56 -0800
Message-ID: <200711230752.56793.david-b@pacbell.net>
References: <d7b238da0711101602y61f8b5b9j4248c690cc79bb8d@mail.gmail.com>
	<20071122233427.a2a63837.akpm@linux-foundation.org>
	<20071123141050.5d4e352a@dhcp-255-175.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	dave chung <ponstrip-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071123141050.5d4e352a-RzfXdsu3MTOUA/xf2v/QOMGzbamoMwWuEvhb3Hwu1Ks@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 23 November 2007, Haavard Skinnemoen wrote:
> Hmm. I can swear I've seen David respond to this before, but I can't
> seem to find the thread. Anyway...

Yes, the linux-arm-kernel thread by "steve birtles" seems to have been
mangled for some reason.  And this exact message seems to have been
on that thread too ... but with different attribution.

I'm getting bounces from mail.mondialelectronic.{eu,com} for L-A-K
messages which don't always appear to have beeen delivered to that
list... and other messages seem to have been completely dropped.
Either of those might cause trouble finding that thread.


> > > atmel_spi atmel_spi.0: fifo overrun (0/1 remaining)
> > > atmel_spi atmel_spi.0: timeout waiting for TXEMPTY<7>ads7846 spi0.0:
> > > DEactivate 35, mr 000f0011
> > > atmel_spi atmel_spi.0: fifo overrun (0/1 remaining)
> > > atmel_spi atmel_spi.0: timeout waiting for TXEMPTY<7>ads7846 spi0.0:
> > > DEactivate 35, mr 000f0011
> =

> It seems like the AT91RM9200 has a few serious quirks

... as commented in the atmel_spi.c driver, with nCS0 issues
being the main unresolved issue.


> that later AT91 =

> and AVR32 chips don't have. This is especially problematic for things
> connected to CS0. If it's not too late to modify your board design I
> suggest you try a different chipselect.

That's a short term workaround.  The canonical problem is an
rm9200 chip booting off DataFlash on nCS0, and with its root
filesystem living there.  We know this can work since the
legacy driver worked.  We even know what the current driver
does differently ... mostly, it doesn't do DMA chaining.

It'd be useful to have someone test with something simpler
than the ads784x code ... like DataFlash, which doesn't
have variables like user interaction causing different data.
(And where non-experts can detect bogus data.)

That said, there's nothing wrong with avoiding nCS0 except
when it's unavoidable (e.g. for booting from DataFlash).
And this *does* seem to be a newish board design, by some
of the other reports...


> However, several people have reported that
> atmel_spi-chain-dma-transfers.patch (currently in -mm) makes the driver
> behave a lot better on AT91RM9200, even on CS0. So if you haven't tried
> that yet, I suggest you do.

The nCS0 setup in arch/arm/mach-at91/at91rm9200_devices.c also
needs to be changed ... the "use GPIOs" workaround for one big
erratum doesn't work for nCS0 because of a different erratum.

ISTR that in the L-A-K thread, applying the nCS0 workaround
plus the dma chaining patch seemed to give good results.  As in,
those timeouts stopped, and the touchscreen event data looked
at least marginally plausible.


> Make sure you apply the fix too, or it will crash if you define DEBUG:
> =

> http://sourceforge.net/mailarchive/forum.php?thread_name=3D200711210250.4=
6883.david-b%40pacbell.net&forum_name=3Dspi-devel-general
> =

> If everything else fails, try reducing the SCK frequency.
> =

> > > it appears to be coming from /drivers/touchscreen/ads7846.c
> > > =

> > > also even stranger, a cat of  the TS when the pen is down produces:
> > > # cat /dev/ts |hexdump
> > > returns
> > > 0000000 ea9c 34aa 0d64 0007 0001 014a 0001 0000
> > > 0000010 ea9c 34aa 0dde 0007 0003 0018 1d4c 0000
> > > 0000020 ea9c 34aa 0e1b 0007 0000 0000 0000 0000
> > > 0000030 ea9c 34aa 8c84 0008 0001 014a 0000 0000
> > > 0000040 ea9c 34aa 8cdf 0008 0003 0018 0000 0000
> > > 0000050 ea9c 34aa 8d1c 0008 0000 0000 0000 0000
> > > 0000060 ea9d 34aa c9af 0004 0001 014a 0001 0000
> > > 0000070 ea9d 34aa ca29 0004 0003 0018 1d4c 0000
> > > 0000080 ea9d 34aa ca66 0004 0000 0000 0000 0000
> > > =

> > > when the pen is down , notice that the left column is a sequence of
> > > incrementing words, at "second" intervals , the value of which change
> > > when i turn off the "RTC" compillation in the kernel, but this may be
> > > down to the interrupts.
> =

> The left column is the offset printed by hexdump, so I take it you're
> talking about the one after that, right?
> =

> Is the RTC chip connected to the same SPI bus? Perhaps it's not paying
> attention to its chip select signal, or the chip select is set up with
> the wrong polarity?

I'd have assumed it was the on-chip RTC, myself...

Given some other recent oddball reports -- like userspace
alignment faults causing drivers to get bus errors -- I'm
thinking it likely that some folk have been bringing up
some defective (or maybe misconfigured memory timings?)
rm9200 boards over the past few weeks.

- Dave

> =

> H=E5vard
> =

> =


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
