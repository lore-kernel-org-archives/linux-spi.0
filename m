From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: Issues with i.MX SPI DMA transfers
Date: Thu, 28 Mar 2019 09:58:52 +0300
Message-ID: <ec3fdef9-8f74-1a5a-e34a-d66b9e28dc5d@gmail.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <AM0PR04MB4211375B0647DE67D8C7406280590@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Aisheng Dong <aisheng.dong@nxp.com>,
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
        Robin Gong <yibin.gong@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR04MB4211375B0647DE67D8C7406280590@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dear developers,

I have update about these issues.

12 hours testing show very fast (some seconds) appearance of byte 
duplication at interface spi4 (alias for ecspi5), while interfaces spi0 
(alias for ecspi1) and spi1 (alias for ecspi2) work flawless (at least 
without any other OS load).

Looks like, ecspi5 has some different configuration in SPI or SDMA 
drivers or bug in SDMA script.

Any ideas?

Best wishes.

--

Igor Plyatov
