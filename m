From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 26/36] dt-bindings: display: convert sony,acx565akm to
 DT Schema
Date: Tue, 17 Mar 2020 08:23:47 +0200
Message-ID: <b2cdb376-c283-fe06-14f3-a9e1a3ee3f4c@ti.com>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-27-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
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
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marco Franchi <marco.franchi-3arQi8VN3Tc@public.gmane.org>,
        Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Ripard <maxime.ripard@boo
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200315134416.16527-27-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 15/03/2020 15:44, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> ---
>   .../bindings/display/panel/sony,acx565akm.txt | 30 -----------
>   .../display/panel/sony,acx565akm.yaml         | 53 +++++++++++++++++++
>   2 files changed, 53 insertions(+), 30 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt
>   create mode 100644 Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt
> deleted file mode 100644
> index e12333280749..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Sony ACX565AKM SDI Panel
> -========================
> -
> -Required properties:
> -- compatible: "sony,acx565akm"
> -
> -Optional properties:
> -- label: a symbolic name for the panel
> -- reset-gpios: panel reset gpio
> -
> -Required nodes:
> -- Video port for SDI input
> -
> -Example
> --------
> -
> -acx565akm@2 {
> -	compatible = "sony,acx565akm";
> -	spi-max-frequency = <6000000>;
> -	reg = <2>;
> -
> -	label = "lcd";
> -	reset-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
> -
> -	port {
> -		lcd_in: endpoint {
> -			remote-endpoint = <&sdi_out>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
> new file mode 100644
> index 000000000000..a0b1abb9f33d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/sony,acx565akm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony ACX565AKM SDI Panel
> +
> +maintainers:
> +  - Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - $ref: ../../spi/spi-slave.yaml#
> +
> +properties:
> +  compatible:
> +    const: sony,acx565akm
> +
> +  label: true
> +  reset-gpios: true
> +  port: true
> +
> +required:
> +  - compatible
> +  - port
> +
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        acx565akm@2 {
> +            compatible = "sony,acx565akm";
> +            spi-max-frequency = <6000000>;
> +            reg = <2>;
> +
> +            label = "lcd";
> +            reset-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
> +
> +            port {
> +                lcd_in: endpoint {
> +                    remote-endpoint = <&sdi_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
