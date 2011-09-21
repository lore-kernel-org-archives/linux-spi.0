From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spi-dw: fix all sparse warnings
Date: Wed, 21 Sep 2011 09:42:02 +0800
Message-ID: <20110921094202.21198fd0@feng-i7>
References: <201109201106.19123.hartleys@visionengravers.com>
	<20110920205000.GO7781@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110920205000.GO7781-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 21 Sep 2011 04:50:00 +0800
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> On Tue, Sep 20, 2011 at 11:06:17AM -0700, H Hartley Sweeten wrote:
> > The dw_{read,write}[lw] macros produce sparse warnings everytime
> > they are used.  The "read" ones cause:
> > 
> > warning: cast removes address space of expression
> > warning: incorrect type in argument 1 (different address spaces)
> >    expected void const volatile [noderef] <asn:2>*addr
> >    got unsigned int *<noident>
> > 
> > And the "write" ones:
> > 
> > warning: cast removes address space of expression
> > warning: incorrect type in argument 2 (different address spaces)
> >    expected void volatile [noderef] <asn:2>*addr
> >    got unsigned int *<noident>
> > 
> > Fix this by removing struct dw_spi_reg and converting all the
> > register offsets to #defines. Then convert the macros into inlined
> > functions so that proper type checking can occur.
> > 
> > While here, also fix the three sparse warnings in spi-dw-mid.c due
> > to the return value of ioremap_nocache being stored in a u32 * not a
> > void __iomem *.
> > 
> > With these changes the spi-dw* files all build with no sparse
> > warnings.
> > 
> > Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> 
> Looks good to me.  Feng, does this look okay to you?

Yes, the patch looks good to me, thanks

- Feng
> 
> g.
> 
> > 
> > ---
> > 
> > diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
> > index 130e555..e743a45 100644
> > --- a/drivers/spi/spi-dw-mid.c
> > +++ b/drivers/spi/spi-dw-mid.c
> > @@ -116,13 +116,13 @@ static int mid_spi_dma_transfer(struct dw_spi
> > *dws, int cs_change) /* 1. setup DMA related registers */
> >  	if (cs_change) {
> >  		spi_enable_chip(dws, 0);
> > -		dw_writew(dws, dmardlr, 0xf);
> > -		dw_writew(dws, dmatdlr, 0x10);
> > +		dw_writew(dws, DW_SPI_DMARDLR, 0xf);
> > +		dw_writew(dws, DW_SPI_DMATDLR, 0x10);
> >  		if (dws->tx_dma)
> >  			dma_ctrl |= 0x2;
> >  		if (dws->rx_dma)
> >  			dma_ctrl |= 0x1;
> > -		dw_writew(dws, dmacr, dma_ctrl);
> > +		dw_writew(dws, DW_SPI_DMACR, dma_ctrl);
> >  		spi_enable_chip(dws, 1);
> >  	}
> >  
> > @@ -200,7 +200,8 @@ static struct dw_spi_dma_ops mid_dma_ops = {
> >  
> >  int dw_spi_mid_init(struct dw_spi *dws)
> >  {
> > -	u32 *clk_reg, clk_cdiv;
> > +	void __iomem *clk_reg;
> > +	u32 clk_cdiv;
> >  
> >  	clk_reg = ioremap_nocache(MRST_CLK_SPI0_REG, 16);
> >  	if (!clk_reg)
> > diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> > index 0b99320..082458d 100644
> > --- a/drivers/spi/spi-dw.c
> > +++ b/drivers/spi/spi-dw.c
> > @@ -89,35 +89,35 @@ static ssize_t  spi_show_regs(struct file
> > *file, char __user *user_buf, len += snprintf(buf + len,
> > SPI_REGS_BUFSIZE - len, "=================================\n");
> >  	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"CTRL0: \t\t0x%08x\n", dw_readl(dws,
> > ctrl0));
> > +			"CTRL0: \t\t0x%08x\n", dw_readl(dws,
> > DW_SPI_CTRL0)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"CTRL1: \t\t0x%08x\n", dw_readl(dws,
> > ctrl1));
> > +			"CTRL1: \t\t0x%08x\n", dw_readl(dws,
> > DW_SPI_CTRL1)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"SSIENR: \t0x%08x\n", dw_readl(dws,
> > ssienr));
> > +			"SSIENR: \t0x%08x\n", dw_readl(dws,
> > DW_SPI_SSIENR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"SER: \t\t0x%08x\n", dw_readl(dws, ser));
> > +			"SER: \t\t0x%08x\n", dw_readl(dws,
> > DW_SPI_SER)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"BAUDR: \t\t0x%08x\n", dw_readl(dws,
> > baudr));
> > +			"BAUDR: \t\t0x%08x\n", dw_readl(dws,
> > DW_SPI_BAUDR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"TXFTLR: \t0x%08x\n", dw_readl(dws,
> > txfltr));
> > +			"TXFTLR: \t0x%08x\n", dw_readl(dws,
> > DW_SPI_TXFLTR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"RXFTLR: \t0x%08x\n", dw_readl(dws,
> > rxfltr));
> > +			"RXFTLR: \t0x%08x\n", dw_readl(dws,
> > DW_SPI_RXFLTR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"TXFLR: \t\t0x%08x\n", dw_readl(dws,
> > txflr));
> > +			"TXFLR: \t\t0x%08x\n", dw_readl(dws,
> > DW_SPI_TXFLR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"RXFLR: \t\t0x%08x\n", dw_readl(dws,
> > rxflr));
> > +			"RXFLR: \t\t0x%08x\n", dw_readl(dws,
> > DW_SPI_RXFLR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"SR: \t\t0x%08x\n", dw_readl(dws, sr));
> > +			"SR: \t\t0x%08x\n", dw_readl(dws,
> > DW_SPI_SR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"IMR: \t\t0x%08x\n", dw_readl(dws, imr));
> > +			"IMR: \t\t0x%08x\n", dw_readl(dws,
> > DW_SPI_IMR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"ISR: \t\t0x%08x\n", dw_readl(dws, isr));
> > +			"ISR: \t\t0x%08x\n", dw_readl(dws,
> > DW_SPI_ISR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"DMACR: \t\t0x%08x\n", dw_readl(dws,
> > dmacr));
> > +			"DMACR: \t\t0x%08x\n", dw_readl(dws,
> > DW_SPI_DMACR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"DMATDLR: \t0x%08x\n", dw_readl(dws,
> > dmatdlr));
> > +			"DMATDLR: \t0x%08x\n", dw_readl(dws,
> > DW_SPI_DMATDLR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> > -			"DMARDLR: \t0x%08x\n", dw_readl(dws,
> > dmardlr));
> > +			"DMARDLR: \t0x%08x\n", dw_readl(dws,
> > DW_SPI_DMARDLR)); len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> >  			"=================================\n");


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
