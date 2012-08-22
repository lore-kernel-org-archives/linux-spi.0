From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mxs/spi: Fix misuse of init_completion
Date: Wed, 22 Aug 2012 23:30:37 +0200
Message-ID: <201208222330.37925.marex@denx.de>
References: <1345669065-17750-1-git-send-email-marex@denx.de>
	<87ehmyzlds.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87ehmyzlds.fsf-DGHOrqG7t0YzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Chris Ball,

> Hi,
> 
> On Wed, Aug 22 2012, Marek Vasut wrote:
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
> > Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> > Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> > 
> >  drivers/spi/spi-mxs.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> > index 331f600..c965cc6 100644
> > --- a/drivers/spi/spi-mxs.c
> > +++ b/drivers/spi/spi-mxs.c
> > @@ -230,7 +230,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> > cs,
> > 
> >  		return -EINVAL;
> >  	
> >  	}
> > 
> > -	init_completion(&spi->c);
> > +	INIT_COMPLETION(spi->c);
> > 
> >  	if (*first)
> >  	
> >  		pio |= BM_SSP_CTRL0_LOCK_CS;
> > 
> > @@ -560,6 +560,8 @@ static int __devinit mxs_spi_probe(struct
> > platform_device *pdev)
> > 
> >  	ssp->devid = devid;
> >  	ssp->dma_channel = dma_channel;
> > 
> > +	init_completion(&spi->c);
> > +
> > 
> >  	ret = devm_request_irq(&pdev->dev, irq_err, mxs_ssp_irq_handler, 0,
> >  	
> >  			       DRIVER_NAME, ssp);
> >  	
> >  	if (ret)
> 
> Please be more specific with commit messages

I kind of expected this change was pretty obvious.

> is there an observed symptom that this fixes?

None. I noticed this misuse, so I fixed it.

> Does the patch need to go to stable@, too?

No, this driver is in -next currently.

> Thanks,
> 
> - Chris.

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
