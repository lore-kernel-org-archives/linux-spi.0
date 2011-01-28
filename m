From: Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Regd: SPI Slave Select
Date: Fri, 28 Jan 2011 14:42:42 +0530
Message-ID: <AANLkTinkWD4CMEjLCCKzECaC4i5JQJeBPwPjGOrr9f5B@mail.gmail.com>
References: <AANLkTimpC8Atvves=r+CLQYZKByLpyo8bm+xfnKvXAas@mail.gmail.com>
	<20110128082443.GA6927@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110128082443.GA6927@tarshish>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Baruch,

Thanks a lot for the quick reply.
But,my concern/doubt is over the sync of SS (GPIO toggling) and data
transmitted or read by SPI master.

There is(are actually) another SPI protocol driver in existence, and what if
its write/read operation happens over the bus, when my driver has issued a
write/read.

How do i avert this or does the spi framework (or linux driver model) assure
of its avoidance?

I noticed spi_bus_lock, spi_async_lock.. etc are available only in 2.6.37
and not in the code i am using (2.6.35)

Regards,
Tom


On Fri, Jan 28, 2011 at 1:54 PM, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:

> Hi Tom,
>
> On Fri, Jan 28, 2011 at 01:28:54PM +0530, Tom wrote:
> > I have a SPI slave device which expects the slave select line to be
> active
> > (low) during the entire message (e.g: say for a two byte transfer, the SS
> > should be low for until both the bytes have been written, and should not
> go
> > inactive in-between bytes being transfered).
> > But, I notice, this is not the case. The SS goes inactive in between
> bytes
> > transfer.
> >
> > Does the spi framework provide any support to avoid SS being deactivated
> > between byte transfer ?
>
> This is a (mis)feature of the DesignWare SPI master hardware, when SCPOL =
> 1.
> See figure 16 (page 63) in the DesigWare DW_apb_ssi Databook. The only
> solution is to use an external GPIO to control the SS signal.
>
> Another misfeature of this SPI master hardware is that it deactivates the
> SS
> signal automatically when the FIFO empties. This may or may not affect you,
> it
> depends on your application. Anyway, the solution here is again to use an
> external GPIO for SS.
>
> baruch
>
> > I have multiple slave devices on the same bus, so I can't keep the slave
> > always selected.
> >
> > My master driver is dw_spi.c and linunx kernel version is 2.6.35.
> >
> > Regards,
> > Tom
>
> --
>                                                     ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
>
------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
