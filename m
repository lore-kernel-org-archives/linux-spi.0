From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: support zero length
	transfer
Date: Fri, 22 Feb 2008 10:30:31 +0100
Message-ID: <200802221030.32263.marc.pignat@hevs.ch>
References: <20080221.005432.07645461.anemo@mba.ocn.ne.jp>
	<200802211026.17816.marc.pignat@hevs.ch>
	<20080221192334.EE97A230A58@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080221192334.EE97A230A58-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
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

Hi Dave!

On Thursday 21 February 2008, David Brownell wrote:
> > David, do you think writing 0 bytes is a valid use of this API?
> 
> Just a zero byte transfer ... no, though it depends what you mean
> by "valid".  (I'm not sure I'd expect all controller drivers to
> reject such requests.)  That has no effect on bits-on-the-wire,
> and would make trouble for various DMA engines.
So, the behaviour is undefined, something between 'crash my dma engine',
'assert chip select and wait some time', or 'do_nothing'...

...
> This *specific* usage might arguably belong in spi_device, since
> it's a delay required after chipselect goes active and before any
> bytes get transferred.  It's clearly not a per-transfer thing, and
> should also apply after a temporary mid-message chip deselect.
Ack, should be in spi_device (same remark for spi_transfer->delay_usec?).

> 
> And it would probably deserve a mode flag (sigh) unless someone
> can update every master controller driver.
Supporting the zero-len-write means checking and perhpaps updating each driver
for the benefit of having an unknown length delay.

We should add the delay field in the spi_device, but this means more work.

Is this kind of device so common that we need to do all that work? or can we
leave it as is (verified to work only with atmel_spi)?

Regards

Marc

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
