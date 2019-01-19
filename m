From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [v7,2/5] mtd: spi-nor: add octal read flag for flash mt35xu512aba
Date: Sat, 19 Jan 2019 16:42:04 +0100
Message-ID: <20190119154204.3518-1-bbrezillon@kernel.org>
References: <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 2019-01-15 at 10:05:16 UTC, Yogesh Narayan Gaur wrote:
> Add octal read flag for flash mt35xu512aba.
> This flash, mt35xu512aba, is only complaint to SFDP JESD216B and does
> not seem to support newer JESD216C standard that provides auto
> detection of Octal mode capabilities and opcodes. Therefore, this
> capability is manually added using new SPI_NOR_OCTAL_READ flag.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
