From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: Issues with i.MX SPI DMA transfers
Date: Tue, 2 Apr 2019 10:20:27 +0300
Message-ID: <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
 <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
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
In-Reply-To: <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dear Robin Gong,


>> Sorry...below another sdma patch(ad0d92d7ba6a) need to be reverted, 
>> because spi driver may dynamically change burst length.


now I have reverted patch ad0d92d7ba6a.

Patches 0001-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch and 
0002-spi-spi-imx-fix-ERR009165.patch are applied.


Kernel log show messages

[   29.202639] imx-sdma 20ec000.sdma: loaded firmware 3.3
[   29.238595] spi_imx 2008000.spi: probed
[   29.242802] spi_imx 200c000.spi: probed
[   29.245217] spi_imx 2018000.spi: probed

SPI DMA transfers still not work.

If I test 32 byte transfers, then they work fine. But 64 byte transfers 
fails always and I see error messages

root@cr7:~# spidev_test -D /dev/spidev4.1 -s 1200000 -b 8 -S 64 -I 1 -l
spi mode: 0x20
bits per word: 8
max speed: 1200000 Hz (1200 KHz)
[  423.686736] spi_master spi4: I/O Error in DMA RX
[  423.691392] spidev spi4.1: SPI transfer failed: -110
[  423.696382] spi_master spi4: failed to transfer one message from queue
can't send spi message: Connection timed out
Aborted (core dumped)

I suppose, transfers shorter then 64 bytes made with help of PIO.

Robin, is there any chance for you to find some time and look at this 
issue again?

Best wishes.
--
Igor Plyatov
