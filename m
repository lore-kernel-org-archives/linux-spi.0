From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 10/11] spi: add more debug prints in s3c64xx
Date: Thu, 4 Jun 2015 01:04:08 +0200
Message-ID: <201506040104.08192.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com> <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
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
In-Reply-To: <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, June 03, 2015 at 11:26:42 PM, Michal Suchanek wrote:
> The SPI NOR transfers mysteriously fail so add more debug prints about
> SPI transactions.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>

dev_dbg() and friends would certainly be nicer here.

Best regards,
Marek Vasut
