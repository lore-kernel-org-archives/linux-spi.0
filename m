From: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/18] spi: qup: Fix transaction done signaling
Date: Wed, 14 Jun 2017 15:51:55 -0400
Message-ID: <20170614195155.GB32733@hector.wework.com>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
 <1497419551-21834-8-git-send-email-varada@codeaurora.org>
 <4b81a4c7-b85c-a35d-15fb-4aaaec3c7e8c@codeaurora.org>
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
In-Reply-To: <4b81a4c7-b85c-a35d-15fb-4aaaec3c7e8c-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 14, 2017 at 12:43:43PM +0530, Sricharan R wrote:
> Hi Varada,
> 
> On 6/14/2017 11:22 AM, Varadarajan Narayanan wrote:
> > Wait to signal done until we get all of the interrupts we are expecting
> > to get for a transaction.  If we don't wait for the input done flag, we
> > can be inbetween transactions when the done flag comes in and this can
> > mess up the next transaction.
> > 
> > Signed-off-by: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > ---
> >  drivers/spi/spi-qup.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> > index 2124815..7c22ee4 100644
> > --- a/drivers/spi/spi-qup.c
> > +++ b/drivers/spi/spi-qup.c
> > @@ -465,7 +465,8 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
> >  	controller->xfer = xfer;
> >  	spin_unlock_irqrestore(&controller->lock, flags);
> >  
> > -	if (controller->rx_bytes == xfer->len || error)
> > +	if ((controller->rx_bytes == xfer->len &&
> > +		(opflags & QUP_OP_MAX_INPUT_DONE_FLAG)) ||  error)
> 
>  Not sure why we need this additional check, because having read all the
>  bytes implies transfer complete (or) why not just check only for
>  QUP_OP_MAX_INPUT_DONE_FLAG ?

So you can receive an interrupt for the last data without it having also
signalled the INPUT_DONE.  That means you'd have one more IRQ come in and if you
don't wait for that, you could start up the next transaction and have an irq
come in that screws up that transaction.

It might be sufficient to just wait for the INPUT_DONE_FLAG.  That cannot be
signalled unless the rx_bytes == xfer->len.

Regards,

Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
