From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: support zero length
	transfer
Date: Fri, 22 Feb 2008 18:55:25 -0800
Message-ID: <200802221855.25892.david-b@pacbell.net>
References: <20080221.005432.07645461.anemo@mba.ocn.ne.jp>
	<20080221192334.EE97A230A58@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200802221030.32263.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200802221030.32263.marc.pignat-7TsPiqsLilE@public.gmane.org>
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

> > > David, do you think writing 0 bytes is a valid use of this API?
> > 
> > Just a zero byte transfer ... no, though it depends what you mean
> > by "valid".  (I'm not sure I'd expect all controller drivers to
> > reject such requests.)  That has no effect on bits-on-the-wire,
> > and would make trouble for various DMA engines.
>
> So, the behaviour is undefined, something between 'crash my dma engine',
> 'assert chip select and wait some time', or 'do_nothing'...

No, it's fully defined.  "Crash my engine" is not OK.  The delay
is controlled by transfer.delay_usecs ... possibly zero, which is
best viewed as a degenerate case.


> Is this kind of device so common that we need to do all that work? or can we
> leave it as is (verified to work only with atmel_spi)?

You can't avoid testing each combination of SPI protocol driver
and SPI master controller driver you rely on ... especially when
protocol tweaking options (cs_change, delay_usecs, bits_per_word,
etc) are used at the per-transfer level.  This driver stack isn't
as readily tested as, say, USB.

However, protocol drivers should be able to rely on controller
drivers to reject requests that they don't even try to handle;
that's basic.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
