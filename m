From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: Issues with i.MX SPI DMA transfers
Date: Thu, 28 Mar 2019 10:04:21 +0300
Message-ID: <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dear Uwe,


> Hello Igor,
>
> On Wed, Mar 27, 2019 at 08:40:00PM +0300, Igor Plyatov wrote:
>> please, help to resolve two issues with SPI DMA transfers at i.MX6Q
>> platform.
>>
>> First issue is
>>   [ 4465.008003] spi_master spi0: I/O Error in DMA RX
>>
>> Second issue is duplication for one of received bytes.
>>
>> Probably, these issues related to each one.
> This is probably the same problem I hit some time ago. Check ERR009165
> in the errata. You either need to disable DMA or need a fixed
> sdma-Script.

disabling of DMA is not an option, because high throughput required for 
SPI bus to communicate with DSPs.

I'm aware of ERR009165, but as I write some minutes earlier to list, 
spi0 (alias for ecspi1) and spi1 (alias for ecspi2) work flawless, while 
spi4 (alias for ecspi5) fails very fast.

Does same SDMA script used for all SPI interfaces or scripts are different?

Best wishes.

--

Igor Plyatov
