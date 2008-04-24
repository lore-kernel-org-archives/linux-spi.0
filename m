From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC / PATCH] [SPI] get_module while using
	it.
Date: Thu, 24 Apr 2008 11:26:00 -0700
Message-ID: <200804241126.01158.david-b@pacbell.net>
References: <20080414194549.GA1363@www.tglx.de>
	<200804151109.43278.david-b@pacbell.net>
	<20080424092605.GC7371@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080424092605.GC7371-Hfxr4Dq0UpYb1SvskN2V4Q@public.gmane.org>
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

On Thursday 24 April 2008, Sebastian Siewior wrote:
> >And removing the subsidiary devices is supposed to unbind
> >them ... though looking at it quickly, I suspect that the
> >"spidev" driver doesn't check for unbound devices in its
> >various I/O paths.
> 
> Aha. So you mean that the read function which was spidev_read() while
> the controller was available should point to something else once the
> controller is gone?

No, I mean that the issue is most likely a spidev bug.

> >So this sounds like a bug in the controller driver, or else
> >in how spidev handles unbind.
>
> I try to look later at spidev once I find something that does a similar
> job and works as expected....

They're all over the place, though not with SPI.  The unbind
method just updates some state that's checked in the I/O ops.

- Dave
 



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
