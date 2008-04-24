From: Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
Subject: Re: [RFC / PATCH] [SPI] get_module while using
	it.
Date: Thu, 24 Apr 2008 11:26:05 +0200
Message-ID: <20080424092605.GC7371@www.tglx.de>
References: <20080414194549.GA1363@www.tglx.de>
	<200804141623.36838.david-b@pacbell.net>
	<20080415070723.GA18303@www.tglx.de>
	<200804151109.43278.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200804151109.43278.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

* David Brownell | 2008-04-15 11:09:43 [-0700]:

>On Tuesday 15 April 2008, Sebastian Siewior wrote:
>> * David Brownell | 2008-04-14 16:23:36 [-0700]:
>> 
>> >On Monday 14 April 2008, Sebastian Siewior wrote:
>> >> Without this it is possible to unload the SPI-driver while an
>> >> spidev user open()ed the spidev device.
>> >
>> >Does that misbehave in any way?  That sort of unloading of
>>
>> Yes. Unload, read() -> Ooops.
>
>What's the oops, and with which controller driver?
I can't dump the Ooops right now. The conter driver is my own which is
based on mpc52xx_psc_spi.c.

>If the adapter is unloaded it's *supposed* to first complete
>all pending transfers (and prevent submission of new ones).
Yes, but the problem here is (I thing) that spidev doesn't know that the
driver is gone. spi_async() (what is called straight from spidev_read()
with no checks in between) is always using spi->master->* even if the
master is gone.

>And removing the subsidiary devices is supposed to unbind
>them ... though looking at it quickly, I suspect that the
>"spidev" driver doesn't check for unbound devices in its
>various I/O paths.
Aha. So you mean that the read function which was spidev_read() while
the controller was available should point to something else once the
controller is gone?

>
>So this sounds like a bug in the controller driver, or else
>in how spidev handles unbind.
I try to look later at spidev once I find something that does a similar
job and works as expected....

>- Dave
Sebastian

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
