From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 02/11] spi: mpc512x: Use devm_*() functions
Date: Thu, 12 Dec 2013 17:38:48 +0100
Message-ID: <20131212163848.GD26910@book.gsilab.sittig.org>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
 <000e01cef4c7$53d9e060$fb8da120$%han@samsung.com>
 <20131209131213.GL2982@book.gsilab.sittig.org>
 <005601cef54d$7c9b1bf0$75d153d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Anatolij Gustschin' <agust-ynQEQJNshbs@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <005601cef54d$7c9b1bf0$75d153d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Dec 10, 2013 at 11:13 +0900, Jingoo Han wrote:
> 
> On Monday, December 09, 2013 10:12 PM, Gerhard Sittig wrote:
> > 
> > On Mon, Dec 09, 2013 at 19:13 +0900, Jingoo Han wrote:
> > >
> > [ ... ]
> > > @@ -513,8 +513,8 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
> > >  	mps->fifo =
> > >  		(struct mpc512x_psc_fifo *)(tempp + sizeof(struct mpc52xx_psc));
> > >
> > > -	ret = request_irq(mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
> > > -			  "mpc512x-psc-spi", mps);
> > > +	ret = devm_request_irq(dev, mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
> > > +				"mpc512x-psc-spi", mps);
> > >  	if (ret)
> > >  		goto free_master;
> > >  	init_completion(&mps->txisrdone);
> > 
> > nit: whitespace, indentation of the continued parameter list
> 
> Hi Gerhard Sittig,
> 
> Sorry, I cannot find the whitespace.
> Also, there is no checkpatch warning.
> Would you check it again? :-)
> Thank you for your feedback.

If you look very close at the added lines, you see that the
continued line (the opening quote of the string) does not align
with the start of the parameter list of the previous line (the
'dev' word).  And it appears to not be a false positive due to
the use of TABs, as in the above quote the "ret = " starts at
position 8 as well.

But as mentioned, it's a nit.  And if nobody else objects neither
will I.  It's just too minor, and does not affect operation.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
