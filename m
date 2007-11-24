From: "dave chung" <ponstrip-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: problems with spi interface & ads 784X
	under 2.6.23
Date: Sun, 25 Nov 2007 06:42:53 +0800
Message-ID: <d7b238da0711241442w8a93335te7f6316a1536ec35@mail.gmail.com>
References: <d7b238da0711101602y61f8b5b9j4248c690cc79bb8d@mail.gmail.com>
	<20071122233427.a2a63837.akpm@linux-foundation.org>
	<20071123141050.5d4e352a@dhcp-255-175.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: "Haavard Skinnemoen" <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
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

On Nov 23, 2007 9:10 PM, Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> Hmm. I can swear I've seen David respond to this before, but I can't
> seem to find the thread. Anyway...
>
> On Thu, 22 Nov 2007 23:34:27 -0800
> Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:
>
> > On Sun, 11 Nov 2007 08:02:19 +0800 "dave chung" <ponstrip-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> >
> > > on kernel 2.6.23 , with an  Arm AT91rm9200
> > > sometimes when i  "pen-down" on the touch screen,I'm seeing
> > >
> > > ads7846 spi0.0: touchscreen, irq 75
> > > input: ADS784x Touchscreen as /devices/platform/atmel_spi.0/spi0.0/in=
put/input0
> > > at91_rtc at91_rtc: rtc core: registered at91_rtc as rtc0
> > >
> > >
> > >
> > > atmel_spi atmel_spi.0: fifo overrun (0/1 remaining)
> > > atmel_spi atmel_spi.0: timeout waiting for TXEMPTY<7>ads7846 spi0.0:
> > > DEactivate 35, mr 000f0011
> > > atmel_spi atmel_spi.0: fifo overrun (0/1 remaining)
> > > atmel_spi atmel_spi.0: timeout waiting for TXEMPTY<7>ads7846 spi0.0:
> > > DEactivate 35, mr 000f0011
>
> It seems like the AT91RM9200 has a few serious quirks that later AT91
> and AVR32 chips don't have. This is especially problematic for things
> connected to CS0. If it's not too late to modify your board design I
> suggest you try a different chipselect.
>
> However, several people have reported that
> atmel_spi-chain-dma-transfers.patch (currently in -mm) makes the driver
> behave a lot better on AT91RM9200, even on CS0. So if you haven't tried
> that yet, I suggest you do.
>
> Make sure you apply the fix too, or it will crash if you define DEBUG:
>
> http://sourceforge.net/mailarchive/forum.php?thread_name=3D200711210250.4=
6883.david-b%40pacbell.net&forum_name=3Dspi-devel-general
>
> If everything else fails, try reducing the SCK frequency.
>
> > > it appears to be coming from /drivers/touchscreen/ads7846.c
> > >
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
> > >
> > > when the pen is down , notice that the left column is a sequence of
> > > incrementing words, at "second" intervals , the value of which change
> > > when i turn off the "RTC" compillation in the kernel, but this may be
> > > down to the interrupts.
>
> The left column is the offset printed by hexdump, so I take it you're
> talking about the one after that, right?
>
> Is the RTC chip connected to the same SPI bus? Perhaps it's not paying
> attention to its chip select signal, or the chip select is set up with
> the wrong polarity?
>
> H=E5vard
>

Hi  Havard,

sorry not the absolute left col , but the actual hex dump data.
the RTC is actually built into the AT91RM9200 so it's not sitting on
the SPI bus ,that's why it's odd.

I'm beginning to suspect something with the interrupts , but i cannot
understand why reading the spi registers should be affected by the
internal RTC or indeed anything
I' using kernel 2.6.23  which means I just need to setup the spi
select line and the pin interrupt which i can do in "board-*"
as the driver is already written for ADS 7843/6 the polarity should be
correct, and that would be "active" low.
I.E the select should go from High "1" to low"0" to  select the chip.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
