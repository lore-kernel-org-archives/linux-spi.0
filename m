From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC / PATCH] [SPI] get_module while using
	it.
Date: Tue, 15 Apr 2008 11:09:43 -0700
Message-ID: <200804151109.43278.david-b@pacbell.net>
References: <20080414194549.GA1363@www.tglx.de>
	<200804141623.36838.david-b@pacbell.net>
	<20080415070723.GA18303@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080415070723.GA18303-Hfxr4Dq0UpYb1SvskN2V4Q@public.gmane.org>
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

On Tuesday 15 April 2008, Sebastian Siewior wrote:
> * David Brownell | 2008-04-14 16:23:36 [-0700]:
> 
> >On Monday 14 April 2008, Sebastian Siewior wrote:
> >> Without this it is possible to unload the SPI-driver while an
> >> spidev user open()ed the spidev device.
> >
> >Does that misbehave in any way?  That sort of unloading of
>
> Yes. Unload, read() -> Ooops.

What's the oops, and with which controller driver?

If the adapter is unloaded it's *supposed* to first complete
all pending transfers (and prevent submission of new ones).

And removing the subsidiary devices is supposed to unbind
them ... though looking at it quickly, I suspect that the
"spidev" driver doesn't check for unbound devices in its
various I/O paths.

So this sounds like a bug in the controller driver, or else
in how spidev handles unbind.

- Dave


 
> >adapter code is possible with USB and I2C and hasn't been
> >perceived as much of a problem.  I'm not sure I see a strong
> >reason for SPI to act very different.
>
> True. usb returns with -ENODEV after read/whatever. We could add
> something like this to spi/spidev. This might also fit better into
> hot-plugging.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
