From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v6 1/9] ARM: dts: Reflect change of FSL QSPI driver and
 remove unused properties
Date: Tue, 27 Nov 2018 12:01:34 +0100
Message-ID: <20181127110134.7xdwo7ird44qj2ih@pengutronix.de>
References: <1543314174-28580-1-git-send-email-frieder.schrempf@kontron.de>
 <1543314174-28580-2-git-send-email-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "richard@nod.at" <richard@nod.at>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543314174-28580-2-git-send-email-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

On Tue, Nov 27, 2018 at 10:24:19AM +0000, Schrempf Frieder wrote:
> The FSL QSPI driver will be moved to the SPI framework and it then
> acts as a SPI controller. Therefore the subnodes need to set
> spi-[rx/tx]-bus-width = <4>, so quad mode is used just as before.
> 
> Also the properties 'bus-num', 'fsl,spi-num-chipselects' and
> 'fsl,spi-flash-chipselects' were never read by the driver and
> can be removed.
> 
> The 'reg' properties are adjusted to reflect what bus and
> chipselect the flash is connected to, as the new driver needs
> this information.
> 
> The property 'fsl,qspi-has-second-chip' is not needed anymore
> and will be removed after the old driver was disabled to avoid
> breaking ls1021a-moxa-uc-8410a.dts.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

do we need to change the binding document accordingly?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
