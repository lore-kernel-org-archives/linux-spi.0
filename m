From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 16/36] dt-bindings: display: convert lg,lg4573 to DT
 Schema
Date: Wed, 18 Mar 2020 20:56:01 -0600
Message-ID: <20200319025601.GD29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-17-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Brian Masney <masneyb-1iNe0GrtECGEi8DpZVb4nw@public.gmane.org>,
        Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Guido Gunther <agx-wGvLLbajjwFAfugRpC6u6w@public.gmane.org>, Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>,
        Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>,
        Hoegeun Kwon <hoegeun.kwon-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>,
        Jerry Han <hanxu5-dyavHbARFqWrZjcNGxgArdPArS5jOdiE2SarAXORi/o@public.gmane.org>,
        Jonathan Bakker <xc-racer2-kt+e9JA1QaI@public.gmane.org>,
        Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
        Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marco Franchi <marco.franchi-3arQi8VN3Tc@public.gmane.org>,
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-17-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Mar 15, 2020 at 02:43:56PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> Cc: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> ---
>  .../bindings/display/panel/lg,lg4573.txt      | 19 ---------
>  .../bindings/display/panel/lg,lg4573.yaml     | 41 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/lg,lg4573.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lg,lg4573.txt b/Documentation/devicetree/bindings/display/panel/lg,lg4573.txt
> deleted file mode 100644
> index 824441f4e95a..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/lg,lg4573.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -LG LG4573 TFT Liquid Crystal Display with SPI control bus
> -
> -Required properties:
> -  - compatible: "lg,lg4573"
> -  - reg: address of the panel on the SPI bus
> -
> -The panel must obey rules for SPI slave device specified in document [1].
> -
> -[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Example:
> -
> -	lcd_panel: display@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "lg,lg4573";
> -		spi-max-frequency = <10000000>;
> -		reg = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml b/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
> new file mode 100644
> index 000000000000..b5b475cf8406
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lg,lg4573.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LG LG4573 TFT Liquid Crystal Display with SPI control bus
> +
> +maintainers:
> +  - Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
> +
> +allOf:
> +  - $ref: ../../spi/spi-slave.yaml#
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: lg,lg4573
> +
> +  reg: true
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    spi {
> +        compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";

Better to drop this or it's going to fail when there's a schema for this 
spi controller.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lcd_panel: display@0 {
> +            compatible = "lg,lg4573";
> +            spi-max-frequency = <10000000>;
> +            reg = <0>;
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
