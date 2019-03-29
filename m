From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: Issues with i.MX SPI DMA transfers
Date: Fri, 29 Mar 2019 14:57:29 +0300
Message-ID: <3aa00772-8a62-3da3-c4ed-281dc93cc597@gmail.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <20190328082231.zg4emm66mpbbfb6c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328082231.zg4emm66mpbbfb6c@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dear Uwe,

> On Thu, Mar 28, 2019 at 10:04:21AM +0300, Igor Plyatov wrote:
>> Dear Uwe,
>>
>>
>>> Hello Igor,
>>>
>>> On Wed, Mar 27, 2019 at 08:40:00PM +0300, Igor Plyatov wrote:
>>>> please, help to resolve two issues with SPI DMA transfers at i.MX6Q
>>>> platform.
>>>>
>>>> First issue is
>>>>    [ 4465.008003] spi_master spi0: I/O Error in DMA RX
>>>>
>>>> Second issue is duplication for one of received bytes.
>>>>
>>>> Probably, these issues related to each one.
>>> This is probably the same problem I hit some time ago. Check ERR009165
>>> in the errata. You either need to disable DMA or need a fixed
>>> sdma-Script.
>> disabling of DMA is not an option, because high throughput required for SPI
>> bus to communicate with DSPs.
> Is this a theoretical reasoning, or is that backed by testing? People
> here on the list already said things like:
>
> 	The eCSPI appears to insert a 4 bit pause after each word in DMA
> 	mode, not done in PIO mode, which can make DMA transfers 50%
> 	slower than PIO.
>
> You might want to read the thread
> https://marc.info/?l=linux-spi&m=155191201208766&w=2
> .

SPI throughput depends from transfer mode (PIO or DMA), OS load and OS 
version.

For example, Linux-4.9.87 has quite bad results for SPI throughput when 
PIO transfer used and OS highly loaded by other processes. Throughput 
varies from 2700 kbps to 0.8 kbps and this is totally unacceptable for 
my application, where streaming of DSP data required.

Linux-5.1.0-rc2 has much better performance of SPI with PIO transfers. 
Throughput varies within 10%.

>> I'm aware of ERR009165, but as I write some minutes earlier to list, spi0
>> (alias for ecspi1) and spi1 (alias for ecspi2) work flawless, while spi4
>> (alias for ecspi5) fails very fast.
> As the issue is a timing race, it might depend on things like length of
> the SPI lines, load on the data lines and other electrical properties.
> So you might just be happy that spi0 and spi1 don't show the issue for
> you. Or you didn't apply the "right" work load yet.

This e-mail thread discuss operation of SPI only in loopback mode. So, 
real lines of SPI does not used. SPI module of SOC has connected MOSI 
and MISO lines internally, while MISO disconnected from SOC pad. So, 
electrical characteristics of SPI lines are not important at all.

Best wishes.

--

Igor Plyatov
