From: Maxime Ripard <maxime-R63rPqgGiG5yDzI6CaY1VQ@public.gmane.org>
Subject: Re: [PATCH v1 02/36] dt-bindings: spi: support non-spi bindings as
 SPI slaves
Date: Mon, 16 Mar 2020 21:48:50 +0100
Message-ID: <20200316204850.gggeyjulgiy53i7x@gilmour.lan>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-3-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
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
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marco Fr
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-3-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Sam,

On Sun, Mar 15, 2020 at 02:43:42PM +0100, Sam Ravnborg wrote:
> Independent bindings can be SPI slaves which for example is
> the case for several panel bindings.
>
> Move SPI slave properties to spi-slave.yaml so the independent
> SPI slave bindings can include spi-slave.yaml rather than
> duplicating the properties.
>
> Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  .../bindings/spi/spi-controller.yaml          | 63 +-------------
>  .../devicetree/bindings/spi/spi-slave.yaml    | 83 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 60 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-slave.yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 1e0ca6ccf64b..99531c8d10dd 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -67,71 +67,14 @@ patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
>
> +    allOf:
> +      - $ref: spi-slave.yaml#
> +
>      properties:
>        compatible:
>          description:
>            Compatible of the SPI device.
>
> -      reg:
> -        minimum: 0
> -        maximum: 256
> -        description:
> -          Chip select used by the device.
> -
> -      spi-3wire:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          The device requires 3-wire mode.
> -
> -      spi-cpha:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          The device requires shifted clock phase (CPHA) mode.
> -
> -      spi-cpol:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          The device requires inverse clock polarity (CPOL) mode.
> -
> -      spi-cs-high:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          The device requires the chip select active high.
> -
> -      spi-lsb-first:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          The device requires the LSB first mode.
> -
> -      spi-max-frequency:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description:
> -          Maximum SPI clocking speed of the device in Hz.
> -
> -      spi-rx-bus-width:
> -        allOf:
> -          - $ref: /schemas/types.yaml#/definitions/uint32
> -          - enum: [ 1, 2, 4, 8 ]
> -          - default: 1
> -        description:
> -          Bus width to the SPI bus used for MISO.
> -
> -      spi-rx-delay-us:
> -        description:
> -          Delay, in microseconds, after a read transfer.
> -
> -      spi-tx-bus-width:
> -        allOf:
> -          - $ref: /schemas/types.yaml#/definitions/uint32
> -          - enum: [ 1, 2, 4, 8 ]
> -          - default: 1
> -        description:
> -          Bus width to the SPI bus used for MOSI.
> -
> -      spi-tx-delay-us:
> -        description:
> -          Delay, in microseconds, after a write transfer.
> -

I can see what you're trying to do, but you don't really need to.

All the SPI devices will be declared under a spi controller node that
will validate its child nodes (and thus the devices) already.

Doing it this way would actually make all the checks happen twice,
once as part of the SPI controller, once as part of the SPI device
binding, without any good reason.

Maxime
