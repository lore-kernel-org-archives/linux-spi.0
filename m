From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v8 5/7] ARM: dts: ls1021a: Remove
 fsl,qspi-has-second-chip as it is not used
Date: Tue, 15 Jan 2019 23:18:19 +0800
Message-ID: <20190115151818.GD13895@dragon>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
 <20190107092823.11188-6-frieder.schrempf@kontron.de>
 <20190113033117.GG11426@dragon>
 <ee3eb5d5-4b04-002e-5e49-d4b766138ec5@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ee3eb5d5-4b04-002e-5e49-d4b766138ec5@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 14, 2019 at 08:18:49AM +0000, Schrempf Frieder wrote:
> Hi Shawn,
> 
> On 13.01.19 04:31, Shawn Guo wrote:
> > On Mon, Jan 07, 2019 at 09:29:54AM +0000, Schrempf Frieder wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> After switching to the new FSL QSPI driver the property
> >> 'fsl,qspi-has-second-chip' is not needed anymore.
> >>
> >> The driver now uses the 'reg' property to determine the bus and
> >> the chipselect.
> >>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > 
> > Applied, thanks.
> 
> I just noticed, that this and the arm64 patch depend on the driver 
> changes for 5.1 that go through the SPI tree. So I guess we can't be 
> sure that this will be merged in the right order and we need to delay 
> this cleanup to 5.2, or am I wrong?

You are right.  I just dropped the both patches.  Ping me or resend when
they are ready to go.

Shawn
