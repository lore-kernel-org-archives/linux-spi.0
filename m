From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v2 00/15] add ecspi ERR009165 for i.mx6/7 soc
 family
Date: Fri, 26 Apr 2019 11:06:11 +0200
Message-ID: <1556269571.2584.21.camel@pengutronix.de>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556266779.2584.15.camel@pengutronix.de>
         <1556268048.9298.11.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: Robin Gong <yibin.gong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556268048.9298.11.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am Freitag, den 26.04.2019, 08:47 +0000 schrieb Robin Gong:
> On 2019-04-26 at 08:19 +0000, Lucas Stach wrote:
> > Caution: EXT Email
> > 
> > Hi Robin,
> > 
> > Am Freitag, den 26.04.2019, 08:05 +0000 schrieb Robin Gong:
> > > 
> > >   There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> > > transfer to be send twice in DMA mode. Please get more information
> > > from:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fw
> > > ww.nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=02%7C01%7Cy
> > > ibin.gong%40nxp.com%7C0078694b231443d1cb7d08d6ca1feecf%7C686ea1d3bc
> > > 2b4c6fa92cd99c5c301635%7C0%7C1%7C636918635828489049&amp;sdata=IcPzg
> > > uHTS81rdHGMzU2wQdDYJn9bE1UDCsc0BUO5In8%3D&amp;reserved=0. The
> > > workaround is adding
> > > new sdma ram script which works in XCH  mode as PIO inside sdma
> > > instead
> > > of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0.
> > 
> > I would like to have a more in-depth explanation about how this new
> > RAM
> > script differs from the existing ROM script and the changes to the
> > state transitions.
> 
> The new ecspi ram script just follow errata to enable ecspi XCH bit
> after every time txfifo filled just as PIO, please check spi_imx_push()
> in spi-imx.c.
> > 
> > > 
> > >   The issue should be exist on all legacy i.mx6/7 soc family before
> > > i.mx6ul,
> > > NXP fix this design issue from i.mx6ul, so newer chips such as
> > > i.mx6ull/
> > > i.mx8mq/i.mx8mm, don't need this workaroud anymore. This patch set
> > > add new 'fsl,imx6ul-ecspi' for ecspi driver and 'ecspi_fixed' in
> > > sdma
> > > driver to choose if need errata or not.
> > >   The first two reverted patches should be the same issue, though,
> > > it
> > > seems 'fixed' by changing to other shp script. Hope Sean or Sascha
> > > could
> > > have the chance to test this patch set if could fix their issues.
> > >   Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not
> > > work
> > > on i.mx8mm because the event id is zero.
> > > 
> > > PS:
> > >  Please get sdma firmware from below linux-firmware and copy it to
> > > your
> > > local rootfs /lib/firmware/imx/sdma.
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fg
> > > it.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ffirmware%2Flinux
> > > -firmware.git%2Ftree%2Fimx%2Fsdma&amp;data=02%7C01%7Cyibin.gong%40n
> > > xp.com%7C0078694b231443d1cb7d08d6ca1feecf%7C686ea1d3bc2b4c6fa92cd99
> > > c5c301635%7C0%7C1%7C636918635828489049&amp;sdata=SMoonJ9HQpUj3TzPmi
> > > 7CcCSAwaR44%2BGPi%2BSBj%2FXceqo%3D&amp;reserved=0
> > 
> > This is not an option as long as the SDMA RAM firmware breaks the
> > mainline serial DMA support. Please provide a fixed SDMA RAM firmware
> > that doesn't replace the ROM serial script, as that one is totally
> > fine.
> 
> Yes, I have another patch to fix such uart function broken with SDMA
> RAM firmware, including new sdma firmware updated and kernel patch.
> Should I add that patch into this patch set?

Why would we need a kernel patch for this? Just drop the SDMA serial
RAM script, it does not add any value as the ROM script is totally
fine.

Regards,
Lucas
