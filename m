From: Robin Gong <yibin.gong@nxp.com>
Subject: RE: [PATCH v5 12/15] ARM: dts: imx6ul: add dma support on ecspi
Date: Tue, 24 Sep 2019 09:53:28 +0000
Message-ID: <VE1PR04MB663843266A2839FE5CF5142489840@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-13-yibin.gong@nxp.com> <20190717064204.GA3738@dragon>
 <VE1PR04MB663894FA5BC88B130C70AC0789C70@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20190724004848.GV15632@dragon>
 <VE1PR04MB6638F60965CD3D5CE47F26C489C60@VE1PR04MB6638.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
To: Shawn Guo <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VE1PR04MB6638F60965CD3D5CE47F26C489C60@VE1PR04MB6638.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Ping Sacha...
On 2019-7-24 9:53 Robin Gong wrote:
> On 2019-7-24 at 08:49 Shawn Guo <shawnguo@kernel.org> wrote:
> > On Tue, Jul 23, 2019 at 09:39:38AM +0000, Robin Gong wrote:
> > > On 2019-7-17 at 14:42 Shawn Guo <shawnguo@kernel.org> wrote:
> > > > On Mon, Jun 10, 2019 at 04:17:50PM +0800, yibin.gong@nxp.com
> wrote:
> > > > > From: Robin Gong <yibin.gong@nxp.com>
> > > > >
> > > > > Add dma support on ecspi.
> > > > >
> > > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > >
> > > > Applied, thanks.
> > > Thanks Shawn, but how about other dts patches such as 01/15,02/15?
> >
> > I need the authors of the commits being reverted agree on the reverting=
.
> >
> >   Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> >   Sascha Hauer <s.hauer@pengutronix.de>
> Seems Sean's mail can't be reached.
> Hello Sacha, Could you please help test if my patch set could fix your is=
sue
> even I revert your patch?
> https://patchwork.kernel.org/cover/10984301/
> >
> > Shawn
