From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: Issues with i.MX SPI DMA transfers
Date: Thu, 28 Mar 2019 07:52:47 +0100
Message-ID: <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
To: Igor Plyatov <plyatov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Igor,

On Wed, Mar 27, 2019 at 08:40:00PM +0300, Igor Plyatov wrote:
> please, help to resolve two issues with SPI DMA transfers at i.MX6Q
> platform.
> 
> First issue is
>  [ 4465.008003] spi_master spi0: I/O Error in DMA RX
> 
> Second issue is duplication for one of received bytes.
> 
> Probably, these issues related to each one.

This is probably the same problem I hit some time ago. Check ERR009165
in the errata. You either need to disable DMA or need a fixed
sdma-Script.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
