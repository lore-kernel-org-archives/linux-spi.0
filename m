From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 4/6] spi: ti-qspi: Implement the spi_mem interface
Date: Wed, 14 Feb 2018 20:09:52 +0100
Message-ID: <20180214200952.6a8578dc@bbrezillon>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
        <20180205232120.5851-5-boris.brezillon@bootlin.com>
        <6a9eaaaf-20a6-b332-03d0-9d16e24d0b3d@ti.com>
        <20180212133158.3032442f@bbrezillon>
        <67e61203-a2e9-853c-6cda-7226499611c2@ti.com>
        <20180212170809.3f0b5e20@bbrezillon>
        <0944fefa-6ef8-a93a-dad6-660044b8ec8e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Peter Pan <peterpansjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>,
        Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0944fefa-6ef8-a93a-dad6-660044b8ec8e-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 14 Feb 2018 21:55:10 +0530
Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:

> On 12-Feb-18 9:38 PM, Boris Brezillon wrote:
> > On Mon, 12 Feb 2018 21:30:09 +0530
> > Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
> >   
> >> On 12-Feb-18 6:01 PM, Boris Brezillon wrote:  
> >>> On Mon, 12 Feb 2018 17:13:55 +0530
> >>> Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
> >>>     
> >>>> On Tuesday 06 February 2018 04:51 AM, Boris Brezillon wrote:    
> >>>>> From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >>>>>
> >>>>> The spi_mem interface is meant to replace the spi_flash_read() one.
> >>>>> Implement the ->exec_op() method so that we can smoothly get rid of the
> >>>>> old interface.
> >>>>>
> >>>>> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >>>>> ---
> >>>>>   drivers/spi/spi-ti-qspi.c | 85 +++++++++++++++++++++++++++++++++++++++--------
> >>>>>   1 file changed, 72 insertions(+), 13 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> >>>>> index c24d9b45a27c..40cac3ef6cc9 100644
> >>>>> --- a/drivers/spi/spi-ti-qspi.c
> >>>>> +++ b/drivers/spi/spi-ti-qspi.c      
> >>>>
> >>>> [...]
> >>>>     
> >>>>> +static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
> >>>>> +   .exec_op = ti_qspi_exec_mem_op,      
> >>>>
> >>>>         .supports_op = ti_qspi_supports_mem_op,
> >>>>
> >>>> Its required as per spi_controller_check_ops() in Patch 1/6    
> >>>     
> >>> ->supports_op() is optional, and if it's missing, the core will do the    
> >>> regular QuadSPI/DualSPI/SingleSPI check (see spi_mem_supports_op()
> >>> implementation).     
> >>
> >> You might have overlooked spi_controller_check_ops() from Patch 1/6:
> >> +static int spi_controller_check_ops(struct spi_controller *ctlr)
> >> +{
> >> +	/*
> >> +	 * The controller can implement only the high-level SPI-memory
> >> +	 * operations if it does not support regular SPI transfers.
> >> +	 */
> >> +	if (ctlr->mem_ops) {
> >> +		if (!ctlr->mem_ops->supports_op ||
> >> +		    !ctlr->mem_ops->exec_op)
> >> +			return -EINVAL;
> >> +	} else if (!ctlr->transfer && !ctlr->transfer_one &&
> >> +		   !ctlr->transfer_one_message) {
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>
> >> So if ->supports_op() is not populated by SPI controller driver, then
> >> driver probe fails with -EINVAL. This is what I observed on my TI
> >> hardware when testing this patch series.  
> > 
> > Correct. Then I should fix spi_controller_check_ops() to allow empty
> > ctlr->mem_ops->supports_op.
> >   
> >>  
> >>> This being said, if you think a custom ->supports_op()
> >>> implementation is needed for this controller I can add one.
> >>>     
> >>
> >> spi_mem_supports_op() should suffice for now if above issue is fixed.  
> > 
> > Cool. IIUC, you tested the series on a TI SoC. Does it work as
> > expected? Do you see any perf regressions?
> >   
> 
> I am planning to collect throughput numbers with this series for TI
> QSPI. I don't think there would be noticeable degradation.

Ok.

> But, it would be interesting to test for a driver thats now under
> drivers/mtd/spi-nor moved to drivers/spi and see if added overhead of
> m25p80 layer + spi core has any impact.

I'm working with Frieder on the fsl-qspi rework, so we should have
numbers soon.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
