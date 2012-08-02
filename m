From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 06/10 V2] spi: Add SPI driver for mx233/mx28
Date: Thu, 2 Aug 2012 16:58:38 +0200
Message-ID: <201208021658.38237.marex@denx.de>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
	<1343076052-27312-7-git-send-email-marex@denx.de>
	<20120801203106.GW4483@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Attila Kinali <attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120801203106.GW4483-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Mark Brown,

Thanks for the review!

> On Mon, Jul 23, 2012 at 10:40:48PM +0200, Marek Vasut wrote:
> > This is slightly reworked version of the SPI driver.
> > Support for DT has been added and it's been converted
> > to queued API.
> 
> Looks reasonable overall.
> 
> > +	bits_per_word = dev->bits_per_word;
> > +	if (t && t->bits_per_word)
> > +		bits_per_word = t->bits_per_word;
> > +
> > +	if (bits_per_word != 8) {
> > +		dev_err(&dev->dev, "%s, unsupported bits_per_word=%d\n",
> > +					__func__, bits_per_word);
> > +		return -EINVAL;
> > +	}
> > 
> > +	if (dev->max_speed_hz)
> > +		hz = dev->max_speed_hz;
> > +	if (t && t->speed_hz)
> > +		hz = t->speed_hz;
> > +	if (hz == 0) {
> > +		dev_err(&dev->dev, "Cannot continue with zero clock\n");
> > +		return -EINVAL;
> > +	}
> 
> These two blocks use a different style (the first does the first assign
> unconditionally, the second uses initialisation with declaration).  I
> prefer the first style but YMMV and it doesn't matter.
> 
> For the missing clock rate might it make sense to just use whatever the
> clock happens to come out as?

Hm, the max_speed_hz should be the cap for the transfer speed. I will change the 
function to this:

hz = dev->max_speed_hz;
if (t && t->speed_hz)
        hz = min(hz, t->speed_hz);

> > +static void mxs_spi_cleanup(struct spi_device *dev)
> > +{
> > +	return;
> > +}
> 
> Empty functions are generally a warning sign...  why do we need this
> one?

Good catch, thanks!

> > +static int __devexit mxs_spi_remove(struct platform_device *pdev)
> > +{
> > 
> > +	clk_disable_unprepare(ssp->clk);
> 
> It'd be nice to only keep the clocks enabled while doing transfers but
> again totally non-essential.

Hm, this is spread across mxs. Shawn, is there any plan for PM implementation 
for MXS ?

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
