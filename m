From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Thu, 4 Jun 2015 01:03:09 +0200
Message-ID: <201506040103.09555.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com> <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Han Xu <han.xu@freescale.com>, Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	" =?utf-8?q?Rafa=C5=82?= =?utf-8?q?_Mi=C5=82ecki?="
	<zajec5@gmail.com>, Alison Chaiken <alison_chaiken@mentor.com>,
	Huang Shijie <b32955@freescale.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Knut Wohlrab <knut.wohlrab@de.bosch.com>,
	"Bean Huo =?utf-8?q?=E9=9C=8D=E6=96=8C=E6=96=8C?= \(beanhuo\)"
	<beanhuo@
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, June 03, 2015 at 11:26:41 PM, Michal Suchanek wrote:
> On sunxi the SPI controller currently does not have DMA support and fails
> any transfer larger than 63 bytes.
> 
> On Exynos the pl330 DMA controller fails any transfer larger than 64kb
> when using slower speed like 40MHz and any transfer larger than 128bytes
> when running at 133MHz.

This smells more like some corruption of the data on the bus or something
even more obscure.

> The best thing is that in both cases the controller can just lock up and
> never finish potentially leaving the hardware in unusable state.
> 
> So it is required that the m25p80 driver actively prevents doing
> transfers that are too large for the current driver state on a
> particular piece of hardware.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> 
> --
> 
> Update commit message and documentation text.
> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  6 ++++++
>  drivers/mtd/devices/m25p80.c                       | 24
> ++++++++++++++++++++-- 2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt index
> 2bee681..4e63ae8 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> @@ -19,6 +19,12 @@ Optional properties:
>                     all chips and support for it can not be detected at
> runtime. Refer to your chips' datasheet to check if this is supported by
> your chip.
> +- linux,max_tx_len : With some SPI controller drivers possible transfer
> size is +                     limited. This may be hardware or driver bug.
> +                     Transfer data in chunks no larger than this value. +
>                     Using this option may severely degrade performance and
> +                     possibly flash memory life when max_tx_len is
> smaller than +                     flash page size (typically 256 bytes)

Will we need similar patch for all other SPI slave drivers, like SPI NAND ?

Best regards,
Marek Vasut
