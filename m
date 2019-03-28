From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: Issues with i.MX SPI DMA transfers
Date: Thu, 28 Mar 2019 09:22:31 +0100
Message-ID: <20190328082231.zg4emm66mpbbfb6c@pengutronix.de>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Andy Duan <fugang.duan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
To: Igor Plyatov <plyatov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 28, 2019 at 10:04:21AM +0300, Igor Plyatov wrote:
> Dear Uwe,
> 
> 
> > Hello Igor,
> > 
> > On Wed, Mar 27, 2019 at 08:40:00PM +0300, Igor Plyatov wrote:
> > > please, help to resolve two issues with SPI DMA transfers at i.MX6Q
> > > platform.
> > > 
> > > First issue is
> > >   [ 4465.008003] spi_master spi0: I/O Error in DMA RX
> > > 
> > > Second issue is duplication for one of received bytes.
> > > 
> > > Probably, these issues related to each one.
> > This is probably the same problem I hit some time ago. Check ERR009165
> > in the errata. You either need to disable DMA or need a fixed
> > sdma-Script.
> 
> disabling of DMA is not an option, because high throughput required for SPI
> bus to communicate with DSPs.

Is this a theoretical reasoning, or is that backed by testing? People
here on the list already said things like:

	The eCSPI appears to insert a 4 bit pause after each word in DMA
	mode, not done in PIO mode, which can make DMA transfers 50%
	slower than PIO.

You might want to read the thread
https://marc.info/?l=linux-spi&m=155191201208766&w=2
.

> I'm aware of ERR009165, but as I write some minutes earlier to list, spi0
> (alias for ecspi1) and spi1 (alias for ecspi2) work flawless, while spi4
> (alias for ecspi5) fails very fast.

As the issue is a timing race, it might depend on things like length of
the SPI lines, load on the data lines and other electrical properties.
So you might just be happy that spi0 and spi1 don't show the issue for
you. Or you didn't apply the "right" work load yet.

> Does same SDMA script used for all SPI interfaces or scripts are different?

As answered already before: The same script is used for all interfaces.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
