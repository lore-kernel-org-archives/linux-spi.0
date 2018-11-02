From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] ARM: dts: r8a77470: Add QSPI support
Date: Fri, 2 Nov 2018 12:49:50 +0100
Message-ID: <20181102114946.5tqk2lyisaey475w@verge.net.au>
References: <1541075705-1333-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1541075705-1333-4-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Mark Brown <broonie@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Biju Das <biju.das@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1541075705-1333-4-git-send-email-fabrizio.castro@bp.renesas.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 01, 2018 at 12:35:04PM +0000, Fabrizio Castro wrote:
> Add QSPI[01] support to the RZ/G1C SoC specific device tree.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  arch/arm/boot/dts/r8a77470.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
> index e6407e5..04a8877 100644
> --- a/arch/arm/boot/dts/r8a77470.dtsi
> +++ b/arch/arm/boot/dts/r8a77470.dtsi
> @@ -20,6 +20,8 @@
>  		i2c2 = &i2c2;
>  		i2c3 = &i2c3;
>  		i2c4 = &i2c4;
> +		spi0 = &qspi0;
> +		spi1 = &qspi1;
>  	};

Geert can comment but I believe we are moving away from using aliases
in this way and that it would be best if the above hunk was dropped
from this patch.

https://patchwork.kernel.org/patch/10644159/

The rest of the patch looks fine to me.

>  
>  	cpus {
> @@ -460,6 +462,38 @@
>  			status = "disabled";
>  		};
>  
> +		qspi0: spi@e6b10000 {
> +			compatible = "renesas,qspi-r8a77470", "renesas,qspi";
> +			reg = <0 0xe6b10000 0 0x2c>;
> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 918>;
> +			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
> +			       <&dmac1 0x17>, <&dmac1 0x18>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
> +			num-cs = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			resets = <&cpg 918>;
> +			status = "disabled";
> +		};
> +
> +		qspi1: spi@ee200000 {
> +			compatible = "renesas,qspi-r8a77470", "renesas,qspi";
> +			reg = <0 0xee200000 0 0x2c>;
> +			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 917>;
> +			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
> +			       <&dmac1 0xd1>, <&dmac1 0xd2>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
> +			num-cs = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			resets = <&cpg 917>;
> +			status = "disabled";
> +		};
> +
>  		scif0: serial@e6e60000 {
>  			compatible = "renesas,scif-r8a77470",
>  				     "renesas,rcar-gen2-scif", "renesas,scif";
> -- 
> 2.7.4
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
