From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: Issues with i.MX SPI DMA transfers
Date: Thu, 18 Apr 2019 09:30:28 +0300
Message-ID: <c9f24997-0112-8684-dc38-a6f8ba64c158@gmail.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
 <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
 <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <VI1PR04MB454302BAF353124ED13747DC892D0@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <VI1PR04MB4543A5CA46FBB3ACC9F3B3E289260@VI1PR04MB4543.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB4543A5CA46FBB3ACC9F3B3E289260@VI1PR04MB4543.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dear Robin,

> Hi Igor,
> 	Did you meet any issue with my latest patch?

sorry, but unfortunately I have no time to test it.

I have switched to PIO mode and continue other development.

Maybe later I will find time to test DMA mode, but not sure when.

Thank you for support!

--

Igor Plyatov

>> -----Original Message-----
>> From: Robin Gong
>> Sent: April 9, 2019 11:26>
>> Hi Igor,
>> 	Please have a try with the attached patches, and revert 25aaa75df1e6,
>> ad0d92d7ba6a , dd4b487b32a3, df07101e1c4a before apply. Besides XCH, tx
>> thresh should be set to 0 , now no failure caught on ecspi5.
>>
