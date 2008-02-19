From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: atmel_spi clock polarity
Date: Tue, 19 Feb 2008 23:51:23 +0900 (JST)
Message-ID: <20080219.235123.07645009.anemo@mba.ocn.ne.jp>
References: <20080218.231243.41197917.anemo@mba.ocn.ne.jp>
	<200802181157.57299.david-b@pacbell.net>
	<20080218234918.3d09022a@siona>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080218234918.3d09022a@siona>
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

On Mon, 18 Feb 2008 23:49:18 +0100, Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> > > CLK     ______________________|~|___|~~~|___|~~~|___|~~~|___
> > 
> > ... and at T1 CPOL is changed??  That's wrong.  There should
> > never be a partial clock period while a chipselect is active.
> > While it's inactive, sure -- no chip should care.
> 
> ...but what I'm afraid of is that since we're using GPIO chipselects,
> the controller may _think_ that no chip is selected and change the
> clock polarity just before it would pull the chipselect low if we were
> using automatic chipselects...

Yes.  That's I suppose.

> If that's the case, it would be a bit strange if it actually helped to
> initialize all the CSRn registers, but it would also offer us a nice
> workaround...

I suppose the clock state of the AT91 just follows _last_ transfer.
My patch (setting all CSRn.POL for next transfer) was based on that
assumption.

> Atsushi, do you by any chance have debugging enabled? That would
> explain the long delay from CS activation to the change of clock
> polarity. Compared to printk() the DMA setup takes almost no time at
> all.

No, I did not enabled debugging.

> If you can confirm that my patch helps, I think that's the one we want
> in mainline.

Unfortunately I had no time to try it today.  Hopefully tomorrow...

---
Atsushi Nemoto

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
