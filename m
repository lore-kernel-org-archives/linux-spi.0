From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 03/36] dt-bindings: display: convert samsung,s6e63m0
 to DT Schema
Date: Wed, 18 Mar 2020 20:47:11 -0600
Message-ID: <20200319024711.GA29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-4-sam@ravnborg.org>
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
In-Reply-To: <20200315134416.16527-4-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Mar 15, 2020 at 02:43:43PM +0100, Sam Ravnborg wrote:
> The binding for this panel is a SPI slave.
> Reference spi-slave.yaml
> to avoid duplicating all properties.
> 
> Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> Cc: Jonathan Bakker <xc-racer2-kt+e9JA1QaI@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> ---
>  .../display/panel/samsung,s6e63m0.txt         | 33 -----------
>  .../display/panel/samsung,s6e63m0.yaml        | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
> deleted file mode 100644
> index 9fb9ebeef8e4..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -Samsung s6e63m0 AMOLED LCD panel
> -
> -Required properties:
> -  - compatible: "samsung,s6e63m0"
> -  - reset-gpios: GPIO spec for reset pin
> -  - vdd3-supply: VDD regulator
> -  - vci-supply: VCI regulator
> -
> -The panel must obey rules for SPI slave device specified in document [1].
> -
> -The device node can contain one 'port' child node with one child
> -'endpoint' node, according to the bindings defined in [2]. This
> -node should describe panel's video bus.
> -
> -[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
> -[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
> -
> -Example:
> -
> -		s6e63m0: display@0 {
> -			compatible = "samsung,s6e63m0";
> -			reg = <0>;
> -			reset-gpio = <&mp05 5 1>;
> -			vdd3-supply = <&ldo12_reg>;
> -			vci-supply = <&ldo11_reg>;
> -			spi-max-frequency = <1200000>;
> -
> -			port {
> -				lcd_ep: endpoint {
> -					remote-endpoint = <&fimd_ep>;
> -				};
> -			};
> -		};
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
> new file mode 100644
> index 000000000000..204ed76da84d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,s6e63m0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung s6e63m0 AMOLED LCD panel
> +
> +maintainers:
> +  - Jonathan Bakker <xc-racer2-kt+e9JA1QaI@public.gmane.org>
> +
> +allOf:
> +  - $ref: ../../spi/spi-slave.yaml#
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,s6e63m0
> +
> +  reg: true
> +  reset-gpios: true
> +  port: true
> +
> +  vdd3-supply:
> +    description: VDD regulator
> +
> +  vci-supply:
> +    description: VCI regulator
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - vdd3-supply
> +  - vci-supply

Shouldn't port be required? Not really clear in the binding doc, but in 
the driver it doesn't look like display data goes over spi.

Rob

> +
> +examples:
> +  - |
> +    spi {
> +        reg = <0xf00 0x20>;

Drop this or do 'spi@f00'. If it doesn't warn with W=1, it's only a 
matter of time.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        display@0 {
> +            compatible = "samsung,s6e63m0";
> +            reg = <0>;
> +            reset-gpios = <&mp05 5 1>;
> +            vdd3-supply = <&ldo12_reg>;
> +            vci-supply = <&ldo11_reg>;
> +            spi-max-frequency = <1200000>;
> +
> +            port {
> +                lcd_ep: endpoint {
> +                    remote-endpoint = <&fimd_ep>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
