From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH 1/9] ARM: Kirkwood: Add interrupt controller support for
 DT boards
Date: Sun, 10 Jun 2012 23:21:51 +0200
Message-ID: <201206102321.51637.michael@walle.cc>
References: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
 linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1339324322-29388-2-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

Am Sonntag 10 Juni 2012, 12:31:53 schrieb Andrew Lunn:
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> ---
>  .../devicetree/bindings/arm/mrvl/intc.txt          |   20
> ++++++++++++++++++ arch/arm/boot/dts/kirkwood.dtsi                    |   
> 9 ++++++++ arch/arm/mach-kirkwood/board-dt.c                  |   22
> +++++++++++++++++++- 3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> b/Documentation/devicetree/bindings/arm/mrvl/intc.txt index
> 80b9a94..612536e 100644
> --- a/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> +++ b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> @@ -38,3 +38,23 @@ Example:
>  		reg-names = "mux status", "mux mask";
>  		mrvl,intc-nr-irqs = <2>;
>  	};
> +
> +* Marvell Orion Interrupt controller
> +
> +Required properties
> +- compatible :  Should be "marvell,orion-intc"
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +  interrupt source. Supported value is <1>
> +- interrupt-controller : So that its clear its an interrupt controller.
> +Optional properties
> +- reg : Not used yet, but will contain the interrupt mask address
> +
> +Example:
> +
> +	intc: interrupt-controller {
> +        	compatible = "marvell,orion-intc", "marvell,intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +                reg = <0xfed20204 0x04>,
> +		      <0xfed20214 0x04>;
> +        };

please fix whitespaces/tabs


> diff --git a/arch/arm/boot/dts/kirkwood.dtsi
> b/arch/arm/boot/dts/kirkwood.dtsi index 926528b..8eab7c4 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -2,6 +2,15 @@
> 
>  / {
>  	compatible = "mrvl,kirkwood";
> +	interrupt-parent = <&intc>;
> +
> +	intc: interrupt-controller {
> +        	compatible = "marvell,orion-intc", "marvell,intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +                reg = <0xfed20204 0x04>,
> +		      <0xfed20214 0x04>;
> +        };

ditto

-- 
Michael
