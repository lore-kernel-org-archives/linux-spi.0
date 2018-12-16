From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Date: Sun, 16 Dec 2018 15:51:23 +0800
Message-ID: <20181216075121.GH13243@dragon>
References: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
 <ce1442f3-357b-d647-958e-cc4a89282b79@kontron.de>
 <1ad93cdf-7ba1-ff49-f330-6bbd0f6c6972@kontron.de>
 <20181214004251.GA15775@dragon>
 <937b0f34e3eb485aaae45cd649cdeb4f@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <937b0f34e3eb485aaae45cd649cdeb4f@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Dec 15, 2018 at 10:04:55AM +0000, Schrempf Frieder wrote:
> I can confirm, that the series does only remove or add properties to the
> devicetree, that are currently not used by the driver. Therefore it won't break
> anything.

Okay, applied the series.

Shawn
