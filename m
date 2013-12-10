From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 02/11] spi: mpc512x: Use devm_*() functions
Date: Tue, 10 Dec 2013 11:13:59 +0900
Message-ID: <005601cef54d$7c9b1bf0$75d153d0$%han@samsung.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
 <000e01cef4c7$53d9e060$fb8da120$%han@samsung.com>
 <20131209131213.GL2982@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Anatolij Gustschin' <agust-ynQEQJNshbs@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Gerhard Sittig' <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20131209131213.GL2982-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Monday, December 09, 2013 10:12 PM, Gerhard Sittig wrote:
> On Mon, Dec 09, 2013 at 19:13 +0900, Jingoo Han wrote:
> >
> > Use devm_*() functions to make cleanup paths simpler.
> >
> > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/spi/spi-mpc512x-psc.c |   17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
> > index 2babea2..77c03e2 100644
> > --- a/drivers/spi/spi-mpc512x-psc.c
> > +++ b/drivers/spi/spi-mpc512x-psc.c
> > @@ -503,7 +503,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
> >  	master->cleanup = mpc512x_psc_spi_cleanup;
> >  	master->dev.of_node = dev->of_node;
> >
> > -	tempp = ioremap(regaddr, size);
> > +	tempp = devm_ioremap(dev, regaddr, size);
> >  	if (!tempp) {
> >  		dev_err(dev, "could not ioremap I/O port range\n");
> >  		ret = -EFAULT;
> > @@ -513,8 +513,8 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
> >  	mps->fifo =
> >  		(struct mpc512x_psc_fifo *)(tempp + sizeof(struct mpc52xx_psc));
> >
> > -	ret = request_irq(mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
> > -			  "mpc512x-psc-spi", mps);
> > +	ret = devm_request_irq(dev, mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
> > +				"mpc512x-psc-spi", mps);
> >  	if (ret)
> >  		goto free_master;
> >  	init_completion(&mps->txisrdone);
> 
> nit: whitespace, indentation of the continued parameter list

Hi Gerhard Sittig,

Sorry, I cannot find the whitespace.
Also, there is no checkpatch warning.
Would you check it again? :-)
Thank you for your feedback.

Best regards,
Jingoo Han

> 
> everything else looks good (from looking at it, did not build/run-test)


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
