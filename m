From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 06/10 V2] spi: Add SPI driver for mx233/mx28
Date: Fri, 3 Aug 2012 10:46:06 -0300
Message-ID: <CAOMZO5AQs1NzJBogcLPcKtY=QSaxpDmzUTvpfScY7P10FEoMJw@mail.gmail.com>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
	<1343076052-27312-7-git-send-email-marex@denx.de>
	<20120803153815.758dc064@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Attila Kinali <attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120803153815.758dc064@skate>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 3, 2012 at 10:38 AM, Thomas Petazzoni
<thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

>
> It sounds really strange to manipulate WAIT_FOR_CMD and WAIT_FOR_IRQ
> bits to adjust the chip select, and when reading the driver, it seemed
> suspicious to me. After going through the datasheet, indeed those bits
> are the appropriate one to select between the SS0, SS1 and SS2 chip
> selects, but I find the code not really obvious. Would it be possible
> to make it more obvious either by adding or comment or doing something
> like:
>
> /* Should be put in some header file */
> #define BM_SSP_CTRL0_SPI_CS_BITS (20)
>
> +static void mxs_spi_set_cs(struct mxs_spi *spi, unsigned cs)
> +{
> +       struct mxs_ssp *ssp = &spi->ssp;
> +
> +       writel(0x3 << BM_SSP_CTRL0_SPI_CS_BITS,
> +              ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> +       writel(cs,
> +              ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
> +}

I agree with Thomas.

In U-boot I did the following in order to be able to select the
different chip selects:
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=148ca64f327a89ef77e84756f5d351af33e59b64

Thanks,

Fabio Estevam

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
