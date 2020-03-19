From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 18/36] dt-bindings: display: convert raydium,rm67191
 to DT Schema
Date: Wed, 18 Mar 2020 21:22:22 -0600
Message-ID: <20200319032222.GK29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-19-sam@ravnborg.org>
 <20200319025814.GE29911@bogus>
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
In-Reply-To: <20200319025814.GE29911@bogus>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 18, 2020 at 08:58:15PM -0600, Rob Herring wrote:
> On Sun, Mar 15, 2020 at 02:43:58PM +0100, Sam Ravnborg wrote:
> > Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> > Cc: Robert Chiras <robert.chiras-3arQi8VN3Tc@public.gmane.org>
> > Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> > ---
> >  .../display/panel/raydium,rm67191.txt         | 41 ----------
> >  .../display/panel/raydium,rm67191.yaml        | 75 +++++++++++++++++++
> >  2 files changed, 75 insertions(+), 41 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> > deleted file mode 100644
> > index 10424695aa02..000000000000
> > --- a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> > +++ /dev/null
> > @@ -1,41 +0,0 @@
> > -Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
> > -
> > -Required properties:
> > -- compatible: 		"raydium,rm67191"
> > -- reg:			virtual channel for MIPI-DSI protocol
> > -			must be <0>
> > -- dsi-lanes:		number of DSI lanes to be used
> > -			must be <3> or <4>
> > -- port: 		input port node with endpoint definition as
> > -			defined in Documentation/devicetree/bindings/graph.txt;
> > -			the input port should be connected to a MIPI-DSI device
> > -			driver
> > -
> > -Optional properties:
> > -- reset-gpios:		a GPIO spec for the RST_B GPIO pin
> > -- v3p3-supply:		phandle to 3.3V regulator that powers the VDD_3V3 pin
> > -- v1p8-supply:		phandle to 1.8V regulator that powers the VDD_1V8 pin
> > -- width-mm:		see panel-common.txt
> > -- height-mm:		see panel-common.txt
> > -- video-mode:		0 - burst-mode
> > -			1 - non-burst with sync event
> > -			2 - non-burst with sync pulse
> > -
> > -Example:
> > -
> > -	panel@0 {
> > -		compatible = "raydium,rm67191";
> > -		reg = <0>;
> > -		pinctrl-0 = <&pinctrl_mipi_dsi_0_1_en>;
> > -		pinctrl-names = "default";
> > -		reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> > -		dsi-lanes = <4>;
> > -		width-mm = <68>;
> > -		height-mm = <121>;
> > -
> > -		port {
> > -			panel_in: endpoint {
> > -				remote-endpoint = <&mipi_out>;
> > -			};
> > -		};
> > -	};
> > diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
> > new file mode 100644
> > index 000000000000..b78b66a4336f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/raydium,rm67191.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
> > +
> > +maintainers:
> > +  - Robert Chiras <robert.chiras-3arQi8VN3Tc@public.gmane.org>
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: raydium,rm67191
> > +
> > +  reg: true
> > +  port: true
> > +  reset-gpios: true
> > +  width-mm: true
> > +  height-mm: true
> > + 
> > +  dsi-lanes:
> > +    description: Number of DSI lanes to be used must be <3> or <4>
> > +    enum: [3, 4]
> > +
> > +  v3p3-supply:
> > +    description: phandle to 3.3V regulator that powers the VDD_3V3 pin
> > +
> > +  v1p8-supply:
> > +    description: phandle to 1.8V regulator that powers the VDD_1V8 pin
> > +
> > +  video-mode:
> > +    description: |
> > +      0 - burst-mode
> > +      1 - non-burst with sync event
> > +      2 - non-burst with sync pulse
> > +    enum: [0, 1, 2]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - dsi-lanes
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    dsi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        panel {
> 
> panel@0
> 
> I thought our dsi bus binding would catch this...

Uhhh, it's looking for dsi-controller(@.*)? which is not the common 
case found in dts files. We should fix that to dsi(@.*)?.

Rob
