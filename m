From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
Date: Wed, 15 Jan 2020 12:45:59 -0600
Message-ID: <CAL_Jsq+AOiFV4Kcu=r3-kz42ZqSVR_0ZuKtnz8ak_sksW0D0wQ@mail.gmail.com>
References: <20200114233857.25933-1-chris.packham@alliedtelesis.co.nz> <20200114233857.25933-2-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        anthony.derosa-ZdkzgDXte25Wk0Htik3J/w@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200114233857.25933-2-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 14, 2020 at 5:39 PM Chris Packham
<chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
>
> Add binding documentation for the spi-mux driver. This allows a generic
> multiplexer to be used to provide access to multiple SPI devices.
>
> Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/spi-mux.yaml      | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml

Be sure to run 'make dt_binding_check'.

>
> diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> new file mode 100644
> index 000000000000..1026d03a69c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-mux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic SPI Multiplexer
> +
> +description: |
> +  This binding describes a SPI bus multiplexer to route the SPI chip select
> +  signals. This can be used when you need more devices than the SPI controller
> +  has chip selects available. An example setup is shown in ASCII art; the actual
> +  setting of the multiplexer to a channel needs to be done by a specific SPI mux
> +  driver.
> +
> +        MOSI /--------------------------------+--------+--------+--------\
> +        MISO |/------------------------------+|-------+|-------+|-------\|
> +         SCL ||/----------------------------+||------+||------+||------\||
> +             |||                            |||      |||      |||      |||
> +      +------------+                        |||      |||      |||      |||
> +      | SoC  |||   |                      +-+++-+  +-+++-+  +-+++-+  +-+++-+
> +      |      |||   |                      | dev |  | dev |  | dev |  | dev |
> +      |   +--+++-+ | CS-X  +------+\      +--+--+  +--+--+  +--+--+  +--+--+
> +      |   | SPI  +-|-------+ Mux  |\\   CS-0 |        |        |        |
> +      |   +------+ |       +--+---+\\\-------/   CS-1 |        |        |
> +      |            |          |    \\\----------------/   CS-2 |        |
> +      |   +------+ |          |     \\-------------------------/   CS-3 |
> +      |   | ?    +-|----------/      \----------------------------------/
> +      |   +------+ |
> +      +------------+
> +
> +allOf:
> +  - $ref: "/schemas/spi/spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    const: spi-mux
> +
> +  mux-control:
> +    $ref: "/schemas/mux/mux-controller.yaml#"

That file doesn't exist. If it did, it would still be wrong as that
would be the provider side and this is the client.

The correct name is also 'mux-controls'.

You can assume it has a schema already and you just need to define how
many entries it has (maxItems: 1).

> +
> +required:
> +   - compatible
> +   - reg
> +   - spi-max-frequency
> +   - mux-control
> +
> +examples:
> +   - |
> +     mux: mux-controller {
> +       compatible = "gpio-mux";
> +       #mux-control-cells = <0>;
> +
> +       mux-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
> +     };
> +
> +     spi {
> +       spi-mux {

spi-mux@0

> +         compatible = "spi-mux";
> +         #address-cells = <1>;
> +         #size-cells = <0>;
> +         reg = <0>;
> +         spi-max-frequency = <100000000>;

I don't think this makes sense here. The mux doesn't really have any
frequency given the clock and data lines aren't routed thru the mux
(though maybe that's possible if some isolation is needed).

> +
> +         mux-control = <&mux>
> +         mux-control-names = "spi";

Not documented. Drop it as it's not all that useful when there's only 1 entry.

> +
> +         spi-flash@0 {
> +           compatible = "jedec,spi-nor";
> +           #address-cells = <1>;
> +           #size-cells = <1>;
> +           reg = <0>;
> +           spi-max-frequency = <40000000>;
> +         };
> +
> +         spi-device@1 {
> +           compatible = "spidev";

Not a valid compatible.

> +           reg = <1>;
> +           spi-max-frequency = <10000000>;
> +         };
> +       };
> +     };
> --
> 2.25.0
>
