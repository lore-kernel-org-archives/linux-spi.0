From: Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther-3G+769LDiQ0@public.gmane.org>
Subject: Re: [PATCH v1 19/36] dt-bindings: display: convert
 rocktech,jh057n00900 to DT Schema
Date: Sun, 15 Mar 2020 18:58:39 +0100
Message-ID: <20200315175839.GA4953@bogon.m.sigxcpu.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-20-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Brian Masney <masneyb-1iNe0GrtECGEi8DpZVb4nw@public.gmane.org>,
        Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>,
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
In-Reply-To: <20200315134416.16527-20-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,
On Sun, Mar 15, 2020 at 02:43:59PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> Cc: "Guido Günther" <agx-wGvLLbajjwFAfugRpC6u6w@public.gmane.org>
> Cc: Purism Kernel Team <kernel-3G+769LDiQ0@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>

Reviewed-by: Guido Günther <agx-wGvLLbajjwFAfugRpC6u6w@public.gmane.org>

Thanks!
 -- Guido

> ---
>  .../display/panel/rocktech,jh057n00900.txt    | 23 --------
>  .../display/panel/rocktech,jh057n00900.yaml   | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> deleted file mode 100644
> index a372c5d84695..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
> -
> -Required properties:
> -- compatible: should be "rocktech,jh057n00900"
> -- reg: DSI virtual channel of the peripheral
> -- reset-gpios: panel reset gpio
> -- backlight: phandle of the backlight device attached to the panel
> -- vcc-supply: phandle of the regulator that provides the vcc supply voltage.
> -- iovcc-supply: phandle of the regulator that provides the iovcc supply
> -  voltage.
> -
> -Example:
> -
> -	&mipi_dsi {
> -		panel@0 {
> -			compatible = "rocktech,jh057n00900";
> -			reg = <0>;
> -			backlight = <&backlight>;
> -			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> -			vcc-supply = <&reg_2v8_p>;
> -			iovcc-supply = <&reg_1v8_p>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> new file mode 100644
> index 000000000000..827417bbff63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/rocktech,jh057n00900.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
> +
> +maintainers:
> +  - Guido Günther <agx-wGvLLbajjwFAfugRpC6u6w@public.gmane.org>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: rocktech,jh057n00900
> +
> +  reg: true
> +  reset-gpios: true
> +  backlight: true
> +
> +  vcc-supply:
> +    description: The regulator that provides the vcc supply voltage
> +
> +  iovcc-supply:
> +    description: The regulator that provides the iovcc supply voltage
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - backlight
> +  - vcc-supply
> +  - iovcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "rocktech,jh057n00900";
> +            reg = <0>;
> +            backlight = <&backlight>;
> +            reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> +            vcc-supply = <&reg_2v8_p>;
> +            iovcc-supply = <&reg_1v8_p>;
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
