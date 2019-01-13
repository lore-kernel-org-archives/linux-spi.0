From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v8 6/7] ARM64: dts: ls1046a: Remove
 fsl,qspi-has-second-chip as it is not used
Date: Sun, 13 Jan 2019 11:32:32 +0800
Message-ID: <20190113033231.GH11426@dragon>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
 <20190107092823.11188-7-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        Rob Herring <robh+dt@kerne
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107092823.11188-7-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 07, 2019 at 09:29:55AM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> After switching to the new FSL QSPI driver the property
> 'fsl,qspi-has-second-chip' is not needed anymore.
> 
> The driver now uses the 'reg' property to determine the bus and
> the chipselect.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Different from arm dts files, we use prefix 'arm64: dts: ...'.
I fixed it up and applied the patch.

Shawn
