From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 00/11] Enable access to SPI NOR flash on Samsung Snow board
Date: Thu, 4 Jun 2015 00:53:29 +0200
Message-ID: <201506040053.29482.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433364398.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, June 03, 2015 at 11:26:39 PM, Michal Suchanek wrote:
> Hello,

Hi,

> this patch series makes it possible to access the SPI NOR flash in the
> Samsung XE303 'Snow' Chromebook.
> 
> Unfortunately not all issues are resolved. To work around an issue with the
> pl330 dma engine I respun the patch for limiting transfer size in m25p80
> driver.

Looks like fixing a bug at the wrong place to me ...

> As the flash does not contain any sane filesystem and is only likely to be
> accessed with mtd_debug or similar tool the limit of the dma engine is
> easily reached. Filesystems using shorter data transfers are less likely
> to be affected.

Sounds like the DMA engine driver should be fixed.

Best regards,
Marek Vasut
