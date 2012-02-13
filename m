From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
Date: Mon, 13 Feb 2012 12:40:14 -0700
Message-ID: <20120213194014.GG11077@ponder.secretlab.ca>
References: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
	<20120209152340.GB11249@ponder.secretlab.ca>
	<5EB3BFCD089AD643B9BB63439F5FD5E99CB93BC5@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	DL-SHA-WorkGroupLinux <Workgroup.Linux-kQvG35nSl+M@public.gmane.org>,
	Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E99CB93BC5-W2enlP78h2wYZnBWG7VmBdnKn0HB1kRyVQQcQy+6Uvc@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 10, 2012 at 05:06:15AM +0000, Barry Song wrote:
> Hi Grant,
> > > +
> > > +struct sirfsoc_spi {
> > > +	struct spi_bitbang bitbang;
> > > +	struct completion done;
> > > +
> > > +	u32 irq;
> > 
> > irq is set once and never used outside the probe function.  Doesn't need
> > to be here.
> 
> ok
> > 
> > > +	void __iomem *base;
> > > +	u32 ctrl_freq;  /* SPI controller clock speed */
> > > +	struct clk *clk;
> > > +	int bus_num;
> > 
> > bus_num is unused
> 
> Ok.
> 
> > > +
> > > +static void spi_sirfsoc_tasklet_tx(unsigned long arg)
> > > +{
> > > +	struct sirfsoc_spi *sspi = (struct sirfsoc_spi *)arg;
> > > +
> > > +	/* Fill Tx FIFO while there are left words to be transmitted */
> > > +	while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS) &
> > > +			SIRFSOC_SPI_FIFO_FULL)) &&
> > > +			sspi->left_tx_cnt)
> > > +		sspi->tx_word(sspi);
> > 
> > Potential problem: if for any reason the device stalls and the FULL bit
> > doesn't get cleared, then this function will be stuck in a tight loop.  This
> > may not be an issue, but it should be considered.
> 
> Might timeout check.
> 
> > > +
> > > +static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
> > > +{
> > > +	struct sirfsoc_spi *sspi = spi_master_get_devdata(spi->master);
> > > +	struct sirfsoc_spi_ctrldata *ctl_data = spi->controller_data;
> > 
> > Where does controller_data come from?  It is not set in the driver, and it is
> > *not* something that the spi_device driver or the board code is allowed to set.
> > 
> > If the driver needs controller_data, then it needs to be added to each spi
> > device by the spi controller driver when the slave device is registered.
> > 
> The controller_data is mainly for various kinds of chip selection. We might have a CS pin, a GPIO from prima2, or a GPIO from an extended MCU side by side with prima2.
> It seems like you think this driver should handle all different kinds of chip selection support and implement those callbacks in it? And every spi client use DT to describe the CS pin?

What I am saying is that controller_data should not be prepopulated at
spi_device registration time.  That pointer is 'owned' by the spi controller
and if it is used, should be set by the spi_master.

If the spi_master needs a controller_data pointer, then that data should
either be passed to the spi_master via the spi_master's platform_data, or it
should be decoded from the device tree.  In either case, it is the
responsibility of the spi_master driver to set the value of controller_data
for each of its spi_device children.

Does that make sense?

g.

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
