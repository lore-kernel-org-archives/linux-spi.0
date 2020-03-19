From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 12/36] dt-bindings: display: convert jdi,lt070me05000
 to DT Schema
Date: Wed, 18 Mar 2020 20:53:56 -0600
Message-ID: <20200319025356.GC29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-13-sam@ravnborg.org>
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
In-Reply-To: <20200315134416.16527-13-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Mar 15, 2020 at 02:43:52PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> Cc: Vinay Simha BN <simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> ---
>  .../display/panel/jdi,lt070me05000.txt        | 31 ---------
>  .../display/panel/jdi,lt070me05000.yaml       | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt
> deleted file mode 100644
> index 4989c91d505f..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -JDI model LT070ME05000 1200x1920 7" DSI Panel
> -
> -Required properties:
> -- compatible: should be "jdi,lt070me05000"
> -- vddp-supply: phandle of the regulator that provides the supply voltage
> -  Power IC supply (3-5V)
> -- iovcc-supply: phandle of the regulator that provides the supply voltage
> -  IOVCC , power supply for LCM (1.8V)
> -- enable-gpios: phandle of gpio for enable line
> -  LED_EN, LED backlight enable, High active
> -- reset-gpios: phandle of gpio for reset line
> -  This should be 8mA, gpio can be configured using mux, pinctrl, pinctrl-names
> -  XRES, Reset, Low active
> -- dcdc-en-gpios: phandle of the gpio for power ic line
> -  Power IC supply enable, High active
> -
> -Example:
> -
> -	dsi0: qcom,mdss_dsi@4700000 {
> -		panel@0 {
> -			compatible = "jdi,lt070me05000";
> -			reg = <0>;
> -
> -			vddp-supply = <&pm8921_l17>;
> -			iovcc-supply = <&pm8921_lvs7>;
> -
> -			enable-gpios = <&pm8921_gpio 36 GPIO_ACTIVE_HIGH>;
> -			reset-gpios = <&tlmm_pinmux 54 GPIO_ACTIVE_LOW>;
> -			dcdc-en-gpios = <&pm8921_gpio 23 GPIO_ACTIVE_HIGH>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
> new file mode 100644
> index 000000000000..e0abf68ecb19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/jdi,lt070me05000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: JDI model LT070ME05000 1200x1920 7" DSI Panel
> +
> +maintainers:
> +  - Vinay Simha BN <simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: jdi,lt070me05000
> +
> +  enable-gpios: true
> +  reg: true
> +  reset-gpios: true
> +
> +  vddp-supply:
> +    description: |
> +      The regulator that provides the supply voltage Power IC supply (3-5V)
> +
> +  iovcc-supply:
> +    description: |
> +      The regulator that provides the supply voltage IOVCC,
> +      power supply for LCM (1.8V)
> +
> +  dcdc-en-gpios:
> +    description: |
> +      phandle of the gpio for power ic line
> +      Power IC supply enable, High active
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddp-supply
> +  - iovcc-supply
> +  - enable-gpios
> +  - reset-gpios
> +  - dcdc-en-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi: qcom,mdss_dsi@4700000 {

dsi {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "jdi,lt070me05000";
> +            reg = <0>;
> +
> +            vddp-supply = <&pm8921_l17>;
> +            iovcc-supply = <&pm8921_lvs7>;
> +
> +            enable-gpios = <&pm8921_gpio 36 GPIO_ACTIVE_HIGH>;
> +            reset-gpios = <&tlmm_pinmux 54 GPIO_ACTIVE_LOW>;
> +            dcdc-en-gpios = <&pm8921_gpio 23 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
