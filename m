From: Rabin Vincent <rabin.vincent-VrBV9hrLPhE@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: don't use uninitialized variable
Date: Thu, 6 Apr 2017 13:39:24 +0200
Message-ID: <20170406113924.GA7801@axis.com>
References: <1491466583-6121-1-git-send-email-rabin.vincent@axis.com>
 <20170406105502.baaj4c2xcetp5z6p@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170406105502.baaj4c2xcetp5z6p-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Apr 06, 2017 at 11:55:02AM +0100, Mark Brown wrote:
> On Thu, Apr 06, 2017 at 10:16:23AM +0200, Rabin Vincent wrote:
> > From: Rabin Vincent <rabinv-VrBV9hrLPhE@public.gmane.org>
> > 
> > The num-cs property is a required property according to the binding
> > documentation.  However, if it is not present, the driver currently
> > simply uses random junk from the stack for the num-cs since the variable
> > whose pointer is passed to of_property_read_u32() is not initialized.
> 
> > @@ -2074,7 +2074,7 @@ pl022_platform_data_dt_get(struct device *dev)
> >  {
> >  	struct device_node *np = dev->of_node;
> >  	struct pl022_ssp_controller *pd;
> > -	u32 tmp;
> > +	u32 tmp = 0;
> >  
> >  	if (!np) {
> >  		dev_err(dev, "no dt node defined\n");
> 
> This shuts the warning up but since it's a required property shouldn't
> we be failing the probe instead of using the value?  Looking at the code
> we end up actually doing that since we end up with zero chipselects
> which is flagged as an error during the main probe but it'd be good to
> note this in the changelog since it looks like we just silently ignore
> the required property.

Yes, I could add something like:

 By setting the default value to zero, we ensure that the probe fails if
 the num-cs property is missing.

But I noticed that you already applied this and your automated email says:

 If any updates are required or you are submitting further changes they should
 be sent as incremental updates against current git, existing patches will not
 be replaced.

So I guess it's too late to submit a new changelog?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
