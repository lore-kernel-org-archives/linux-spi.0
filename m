From: Hu Mingkai-B21284 <B21284@freescale.com>
Subject: RE: [PATCH v3 2/7] spi/mpc8xxx: refactor the common code for SPI/eSPI
	controller
Date: Fri, 8 Oct 2010 14:37:00 +0800
Message-ID: <73839B4A0818E747864426270AC332C3057F6272@zmy16exm20.fsl.freescale.net>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<20101001112212.GA17505@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>,
	linux-mtd@lists.infradead.org, Zang Roy-R61911 <R61911@freescale.com>,
	spi-devel-general@lists.sourceforge.net
To: Anton Vorontsov <cbouatmailru@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20101001112212.GA17505@oksana.dev.rtsoft.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Anton Vorontsov [mailto:cbouatmailru@gmail.com]
> Sent: Friday, October 01, 2010 7:22 PM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; spi-devel-general@lists.sourceforge.net; linux-
> mtd@lists.infradead.org; Gala Kumar-B11780; Zang Roy-R61911
> Subject: Re: [PATCH v3 2/7] spi/mpc8xxx: refactor the common code for SPI/eSPI
> controller
> 
> On Thu, Sep 30, 2010 at 04:00:41PM +0800, Mingkai Hu wrote:
> [...]
> > -static void mpc8xxx_spi_change_mode(struct spi_device *spi)
> > +static void fsl_spi_change_mode(struct spi_device *spi)
> >  {
> >  	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
> >  	struct spi_mpc8xxx_cs *cs = spi->controller_state;
> > -	__be32 __iomem *mode = &mspi->base->mode;
> > +	struct fsl_spi_reg *reg_base = (struct fsl_spi_reg *)mspi->reg_base;
> 
> No need for these type casts (the same is for the whole patch).
> 

Fix it.

Thanks,
Mingkai
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
