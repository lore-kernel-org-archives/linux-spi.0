From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [v3,1/2] mtd: spi-nor: add macros related to MICRON flash
Date: Wed, 21 Nov 2018 15:39:04 +0100
Message-ID: <20181121143904.15449-1-boris.brezillon@bootlin.com>
References: <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 2018-10-12 at 02:23:08 UTC, Yogesh Narayan Gaur wrote:
> Some MICRON related macros in spi-nor domain were ST.
> Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.
> 
> Added entry of MFR Id for Micron flashes, 0x002C.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
