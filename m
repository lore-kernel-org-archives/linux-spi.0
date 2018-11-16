From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 5/9] dt-bindings: spi: Adjust the bindings for the FSL QSPI  driver
Date: Fri, 16 Nov 2018 16:59:26 -0600
Message-ID: <5bef4bcf.1c69fb81.39c0b.e18d@mx.google.com>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de> <1542116782-13118-6-git-send-email-frieder.schrempf@kontron.de>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
To: Schrempf Frieder <frieder.schrempf@kontron.De>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542116782-13118-6-git-send-email-frieder.schrempf@kontron.de>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 13 Nov 2018 13:47:37 +0000, Schrempf Frieder wrote:
> Adjust the documentation of the new SPI memory interface based
> driver to reflect the new drivers settings.
> 
> The "old" driver was using the "fsl,qspi-has-second-chip" property to
> select one of two dual chip setups (two chips on one bus or two chips
> on separate buses). And it used the order in which the subnodes are
> defined in the dt to select the CS, the chip is connected to.
> 
> Both methods are wrong and in fact the "reg" property should be used to
> determine which bus and CS a chip is connected to. This also enables us
> to use different setups than just single chip, or symmetric dual chip.
> 
> So the porting of the driver from the MTD to the SPI framework actually
> enforces the use of the "reg" properties and makes
> "fsl,qspi-has-second-chip" superfluous.
> 
> As all boards that have "fsl,qspi-has-second-chip" set, also have
> correct "reg" properties, the removal of this property shouldn't lead to
> any incompatibilities.
> 
> The only compatibility issues I can see are with imx6sx-sdb.dts and
> imx6sx-sdb-reva.dts, which have their reg properties set incorrectly
> (see explanation here: [2]), all other boards should stay compatible.
> 
> Also the "big-endian" flag was removed, as this setting is now selected
> by the driver, depending on which SoC is in use.
> 
> [2] https://patchwork.ozlabs.org/patch/922817/#1925445
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../devicetree/bindings/spi/spi-fsl-qspi.txt      | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
