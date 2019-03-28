From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: Issues with i.MX SPI DMA transfers
Date: Thu, 28 Mar 2019 14:05:59 +0300
Message-ID: <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
To: Robin Gong <yibin.gong@nxp.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dear Robin,

I have applied patches 
0001-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch, 
0002-spi-spi-imx-fix-ERR009165.patch and made testing.

Results are following:

root@cr7:~# spidev_test -D /dev/spidev0.0 -s 12000000 -b 8 -S 512 -I 
10000000000 -l
spi mode: 0x20
bits per word: 8
max speed: 12000000 Hz (12000 KHz)
[  133.987798] spi_imx 2008000.spi: I/O Error in DMA TX
[  133.992810] spidev spi0.0: SPI transfer failed: -110
[  133.997860] spi_master spi0: failed to transfer one message from queue
can't send spi message: Connection timed out
Aborted (core dumped)

root@cr7:~# spidev_test -D /dev/spidev1.0 -s 12000000 -b 8 -S 512 -I 
10000000000 -l
spi mode: 0x20
bits per word: 8
max speed: 12000000 Hz (12000 KHz)
[  483.530815] spi_imx 200c000.spi: I/O Error in DMA TX
[  483.535825] spidev spi1.0: SPI transfer failed: -110
[  483.540873] spi_master spi1: failed to transfer one message from queue
can't send spi message: Connection timed out
Aborted (core dumped)

root@cr7:~# spidev_test -D /dev/spidev4.0 -s 12000000 -b 8 -S 512 -I 
10000000000 -l
spi mode: 0x20
bits per word: 8
max speed: 12000000 Hz (12000 KHz)
[   94.228774] spi_imx 2018000.spi: I/O Error in DMA TX
[   94.233788] spidev spi4.0: SPI transfer failed: -110
[   94.238837] spi_master spi4: failed to transfer one message from queue
can't send spi message: Connection timed out
Aborted (core dumped)

Best wishes.

--

Igor Plyatov


> Hi Igor,
> 	Please have a try with the attached patch, assume you have already used the sdma firmware
>  From https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma/sdma-imx6q.bin
>> -----Original Message-----
>> From: Igor Plyatov <plyatov@gmail.com>
>> Sent: 2019年3月28日 15:04
>> To: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-spi@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Fabio Estevam
>> <festevam@gmail.com>; Pengutronix Kernel Team <kernel@pengutronix.de>;
>> Sascha Hauer <s.hauer@pengutronix.de>; Shawn Guo
>> <shawnguo@kernel.org>; Mark Brown <broonie@kernel.org>;
>> dmaengine@vger.kernel.org; Vinod Koul <vkoul@kernel.org>; Dan Williams
>> <dan.j.williams@intel.com>; Andy Duan <fugang.duan@nxp.com>; Han Xu
>> <han.xu@nxp.com>; Robin Gong <yibin.gong@nxp.com>; Clark Wang
>> <xiaoning.wang@nxp.com>
>> Subject: Re: Issues with i.MX SPI DMA transfers
>>
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
>> disabling of DMA is not an option, because high throughput required for SPI bus
>> to communicate with DSPs.
>>
>> I'm aware of ERR009165, but as I write some minutes earlier to list,
>> spi0 (alias for ecspi1) and spi1 (alias for ecspi2) work flawless, while
>> spi4 (alias for ecspi5) fails very fast.
>>
>> Does same SDMA script used for all SPI interfaces or scripts are different?
>>
>> Best wishes.
>>
>> --
>>
>> Igor Plyatov
