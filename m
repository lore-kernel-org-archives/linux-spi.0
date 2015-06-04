From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 11/11] dt: Exynos: add Snow SPI NOR node.
Date: Thu, 4 Jun 2015 17:20:54 +0200
Message-ID: <201506041720.54666.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com> <3234c12c90eabbeeb6d33604a324231937e309ec.1433364398.git.hramrach@gmail.com> <556FB222.2070406@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michal Suchanek <hramrach@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Kukjin Kim <kgene@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Han Xu <han.xu@freescale.com>, Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
	Alison Chaiken <alison_chaiken@mentor.com>,
	Huang Shijie <b32955@freescale.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Knut Wohlrab <knut.wohlrab@de.bosch.com>,
	"Bean Huo =?utf-8?q?=E9=9C=8D=E6=96=8C=E6=96=8C?= (beanhuo)"
	<beanhuo@micron.com>, "grmoore@alter
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <556FB222.2070406@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday, June 04, 2015 at 04:04:18 AM, Krzysztof Kozlowski wrote:
> On 04.06.2015 06:26, Michal Suchanek wrote:
> > The Snow has onboard SPI NOR flash which contains the bootloader.
> > 
> > Add DT node for this flash chip. The flash is rated 133MHz but the pl330
> > controller can transfer only up to 128 bytes at this speed so use more
> > conservative settings. Even at 40MHz pl330 can transfer at most 64k with
> > the current driver.
> > 
> > Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> > ---
> > 
> >  arch/arm/boot/dts/exynos5250-snow.dts | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/exynos5250-snow.dts
> > b/arch/arm/boot/dts/exynos5250-snow.dts index 1fa72cf..38e4cda 100644
> > --- a/arch/arm/boot/dts/exynos5250-snow.dts
> > +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> > @@ -691,6 +691,18 @@
> > 
> >  	num-cs = <1>;
> >  	cs-gpios = <&gpa2 5 0>;
> >  	status = "okay";
> > 
> > +		flash: m25p80@0 {
> 
> The indentation looks odd. This should be at the same level as "status".
> 
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			compatible = "jedec,spi-nor";
> > +			reg = <0>;
> > +			spi-max-frequency = <40000000>;
> 
> So actually you wanted 133 MHz but as a workaround for DMA issue you use
> 40 MHz, right? Could you add here a small TODO note in comment about it?

I disagree. There is a problem, the problem should actually be analyzed and 
fixed, not just postponed with some TODO nonsense.

Best regards,
Marek Vasut
