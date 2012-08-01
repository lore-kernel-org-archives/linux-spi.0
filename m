From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [06/10,V2] spi: Add SPI driver for mx233/mx28
Date: Wed, 1 Aug 2012 04:31:04 +0200
Message-ID: <201208010431.04399.marex@denx.de>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
	<20120731205300.GA25721@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>,
	Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120731205300.GA25721-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Guenter Roeck,

[...]

> > +static int __devexit mxs_spi_remove(struct platform_device *pdev)
> > +{
> > +	struct spi_master *host;
> > +	struct mxs_spi *spi;
> > +	struct mxs_ssp *ssp;
> > +
> > +	host = platform_get_drvdata(pdev);
> > +	spi = spi_master_get_devdata(host);
> > +	ssp = &spi->ssp;
> > +
> > +	spi_unregister_master(host);
> > +
> > +	platform_set_drvdata(pdev, NULL);
> > +
> > +	clk_disable_unprepare(ssp->clk);
> > +
> > +	spi_master_put(host);
> > +	kfree(host);
> > +
> 
> Is the kfree() here and in the probe function really necessary ?

It certainly would seem that way.

> Couple of reasons for asking: No other SPI master driver calls it in the
> remove function (unless I missed it), most drivers don't call it in the
> probe function error path, and if I call it in the remove function in a
> SPI master driver I am working on, and load/unload the module several
> times in a row, I get a nasty kernel crash.

It seems the spi_master class takes care of that kfree() in 
spi.c:spi_master_release() . Good catch, thanks!

> Thanks,
> Guenter

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
