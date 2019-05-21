From: Vinod Koul <vkoul@kernel.org>
Subject: Re: Re: Re: [PATCH v3 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma
 not work on i.mx8mm
Date: Tue, 21 May 2019 11:42:36 +0530
Message-ID: <20190521061236.GA15118@vkoul-mobl>
References: <VI1PR04MB4543DEEC702531ED69616B8C89070@VI1PR04MB4543.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4543DEEC702531ED69616B8C89070@VI1PR04MB4543.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 21-05-19, 05:41, Robin Gong wrote:
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: 2019年5月21日 13:13
> > 
> > On 21-05-19, 04:58, Robin Gong wrote:
> > > > -----Original Message-----
> > > > From: Vinod Koul <vkoul@kernel.org>
> > > > Sent: 2019年5月21日 12:18
> > > >
> > > > On 07-05-19, 09:16, Robin Gong wrote:
> > > > > Because the number of ecspi1 rx event on i.mx8mm is 0, the
> > > > > condition check ignore such special case without dma channel
> > > > > enabled, which caused
> > > > > ecspi1 rx works failed. Actually, no need to check event_id0,
> > > > > checking
> > > > > event_id1 is enough for DEV_2_DEV case because it's so lucky that
> > > > > event_id1 never be 0.
> > > >
> > > > Well is that by chance or design that event_id1 will be never 0?
> > > >
> > > That's by chance. DEV_2_DEV is just for Audio case and non-zero for
> > event_id1 on current i.MX family.
> > 
> > Then it wont be fgood to rely on chance :)
> Yes, I knew that. May I create another independent patch for event_id1 since that's potential issue is not related with this ecspi patch set?

Sure a patch should change one thing but I think it should come before
this one. The log for this should be fixed up as well

-- 
~Vinod
