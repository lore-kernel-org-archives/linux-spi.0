From: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/18] spi: qup: Fix DMA mode interrupt handling
Date: Wed, 14 Jun 2017 16:06:08 -0400
Message-ID: <20170614200608.GE32733@hector.wework.com>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
 <1497419551-21834-11-git-send-email-varada@codeaurora.org>
 <66ba7dfb-6ff3-884e-6db0-8d5191f87c93@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <66ba7dfb-6ff3-884e-6db0-8d5191f87c93-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 14, 2017 at 12:51:11PM +0530, Sricharan R wrote:
> Hi Varada,
> 
> On 6/14/2017 11:22 AM, Varadarajan Narayanan wrote:
> > This is needed for v1, where the i/o completion is not
> > handled in the dma driver.
> > 
> > Signed-off-by: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > ---
> >  drivers/spi/spi-qup.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> > index 872de28..bd53e82 100644
> > --- a/drivers/spi/spi-qup.c
> > +++ b/drivers/spi/spi-qup.c
> > @@ -510,9 +510,9 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
> >  
> >  	writel_relaxed(qup_err, controller->base + QUP_ERROR_FLAGS);
> >  	writel_relaxed(spi_err, controller->base + SPI_ERROR_FLAGS);
> > -	writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
> >  
> >  	if (!xfer) {
> > +		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
> 
>  This does look correct to remove acknowledging the QUP in normal case and
>   do it conditionally only when xfer = NULL.

This is to probably mask the issue of getting erroneous/spurious IRQs.

> 
> >  		dev_err_ratelimited(controller->dev, "unexpected irq %08x %08x %08x\n",
> >  				    qup_err, spi_err, opflags);
> >  		return IRQ_HANDLED;
> > @@ -540,7 +540,15 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
> >  		error = -EIO;
> >  	}
> >  
> > -	if (!spi_qup_is_dma_xfer(controller->mode)) {
> > +	if (spi_qup_is_dma_xfer(controller->mode)) {
> > +		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
> > +		if (opflags & QUP_OP_IN_SERVICE_FLAG &&
> > +		    opflags & QUP_OP_MAX_INPUT_DONE_FLAG)
> > +			complete(&controller->rxc);
> > +		if (opflags & QUP_OP_OUT_SERVICE_FLAG &&
> > +		    opflags & QUP_OP_MAX_OUTPUT_DONE_FLAG)
> > +			complete(&controller->txc);
> > +	} else {
> 
>  Is this because in patch #8 that we do not populate the dma callback
>  for v1. If that is done, this should not be required at all, as the
>  complete would be signalled from the dma callback.

I believe that is true.  There shouldn't be any IRQs for DMA enabled
transactions (at least BAM-dma).
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
