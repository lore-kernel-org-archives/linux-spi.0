From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
Date: Fri, 25 Jul 2014 09:58:42 +0200
Message-ID: <5574058.fMy2hcvT92@wuerfel>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com> <20140724140620.GP1857@lahna.fi.intel.com> <20140725071138.GU1857@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-arm-kernel@lists.infradead.org,
	Kweh Hock Leong <hock.leong.kweh@intel.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chew Chiau Ee <chiau.ee.chew@intel.com>,
	Darren Hart <dvhart@linux.intel.com>, chiauee85@gmail.com,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140725071138.GU1857@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday 25 July 2014 10:11:38 Mika Westerberg wrote:
> On Thu, Jul 24, 2014 at 05:06:20PM +0300, Mika Westerberg wrote:
> > > On a related note, there seems to be a bug in this driver, which
> > > attempts to set the slave_id through dmaengine_slave_config(), which
> > > is wrong in both cases, ACPI and filter functions.
> > 
> > Good point. We will fix this, thanks.
> 
> I take that back. How we are supposed to set the slave_id if we don't
> have request line information available (from ACPI or DT)?

If you don't have the request line information, you are screwed and you
can't set it from either the filter function or slave_config.

However, it looks like you do have it, at least this is what the
code tells me:

static struct pxa_spi_info spi_info_configs[] = {
        [PORT_CE4100] = {
		...
        },
        [PORT_BYT] = {
                .type = LPSS_SSP,
                .port_id = 0,
                .num_chipselect = 1,
                .tx_slave_id = 0,
                .tx_chan_id = 0,
                .rx_slave_id = 1,
                .rx_chan_id = 1,
        },
};

All you need to do is change your filter function to take the
slave id from pxa_spi_info and stick it in there, e.g.

static bool pxa2xx_spi_dw_dma_filter(struct dma_chan *chan, void *param)
{       
        const struct pxa2xx_spi_master *pdata = param;
        struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
        
        dwc->request_line = fargs->req;
        dwc->src_master = 0;
        dwc->dst_master = 0;
        
        return 1;
}           

Note that the filter function by definition is specific to the dma
controller, not the dma slave (that's why most people define it in
the dmaengine driver), and the pxa2xx_spi_dma_filter() function used
in spi-pxa2xx-dma.c looks like it was written for another dma engine:

The dw-dma driver doesn't care at all about the channel number, so
matching it with the platform data is pointless, but it does need
the master and request numbers to be set in the filter function,
as dw_dma_of_filter() and dw_dma_acpi_filter() do.

It also really needs a check to see if the dma engine is the right
one for the device, as the current filter function will just take
a channel (with the right number) from any dma engine, and that
breaks as soon as you register a second dma controller in the system.

I agree that this is very ugly, but that's exactly why we came up
with the dma_request_slave_channel interface to replace the need
for filter functions that everybody gets wrong.

	Arnd
