From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 08/10 RESEND] spi: Add DMA support into SPI driver
Date: Thu, 2 Aug 2012 17:00:42 +0200
Message-ID: <201208021700.43159.marex@denx.de>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
	<1343076052-27312-9-git-send-email-marex@denx.de>
	<20120801203448.GX4483@opensource.wolfsonmicro.com>
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
In-Reply-To: <20120801203448.GX4483-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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

> On Mon, Jul 23, 2012 at 10:40:50PM +0200, Marek Vasut wrote:
> > +		/*
> > +		 * Small blocks can be transfered via PIO.
> > +		 * Measured by empiric means:
> > +		 *
> > +		 * dd if=/dev/mtdblock0 of=/dev/null bs=1024k count=1
> > +		 *
> > +		 * DMA only: 2.164808 seconds, 473.0KB/s
> > +		 * Combined: 1.676276 seconds, 610.9KB/s
> > +		 */
> 
> I've seen other devices end up using the FIFO length as the decision
> point here which makes intuitive sense to me unless the FIFO is
> extremely deep.

Yep, that's all good. This device has not too deep FIFO, but the reason I chose 
not to go that way is because the DMA allocations have some overhead too and 
this values seemed to be the best.

> Not reviewed this properly yet but it looks OK from a first read
> through.

Thanks!

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
