From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 06/10 V2] spi: Add SPI driver for mx233/mx28
Date: Fri, 3 Aug 2012 16:00:43 +0200
Message-ID: <201208031600.43816.marex@denx.de>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
	<20120803153815.758dc064@skate>
	<CAOMZO5AQs1NzJBogcLPcKtY=QSaxpDmzUTvpfScY7P10FEoMJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Attila Kinali <attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAOMZO5AQs1NzJBogcLPcKtY=QSaxpDmzUTvpfScY7P10FEoMJw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Fabio Estevam,

> On Fri, Aug 3, 2012 at 10:38 AM, Thomas Petazzoni
> 
> <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > It sounds really strange to manipulate WAIT_FOR_CMD and WAIT_FOR_IRQ
> > bits to adjust the chip select, and when reading the driver, it seemed
> > suspicious to me. After going through the datasheet, indeed those bits
> > are the appropriate one to select between the SS0, SS1 and SS2 chip
> > selects, but I find the code not really obvious. Would it be possible
> > to make it more obvious either by adding or comment or doing something
> > like:
> > 
> > /* Should be put in some header file */
> > #define BM_SSP_CTRL0_SPI_CS_BITS (20)
> > 
> > +static void mxs_spi_set_cs(struct mxs_spi *spi, unsigned cs)
> > +{
> > +       struct mxs_ssp *ssp = &spi->ssp;
> > +
> > +       writel(0x3 << BM_SSP_CTRL0_SPI_CS_BITS,
> > +              ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> > +       writel(cs,
> > +              ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
> > +}
> 
> I agree with Thomas.
> 
> In U-boot I did the following in order to be able to select the
> different chip selects:
> http://git.denx.de/?p=u-boot.git;a=commitdiff;h=148ca64f327a89ef77e84756f5d
> 351af33e59b64

I'll just add the following comment if it's ok with you:

/*
 * i.MX28 Datasheet: 17.10.1: HW_SSP_CTRL0
 *
 * The bits BM_SSP_CTRL0_WAIT_FOR_CMD and BM_SSP_CTRL0_WAIT_FOR_IRQ
 * in HW_SSP_CTRL0 register do have multiple usage, please refer to
 * the datasheet for further details. In SPI mode, they are used to
 * toggle the chip-select lines (nCS pins).
 */

I hope it'll suffice. Recycling bits in registers is really crazy practice and 
I'd like to avoid these getting out of scope of this flaw's location.

> Thanks,
> 
> Fabio Estevam

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
