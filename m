From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
Date: Thu, 23 Jan 2020 07:51:37 -0600
Message-ID: <CAL_JsqLvM34WSBE29beBgJj0jLA6P_UwQUbTuEQcYJgrkg3v1A@mail.gmail.com>
References: <20200123012317.14808-1-chris.packham@alliedtelesis.co.nz> <20200123012317.14808-2-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200123012317.14808-2-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 22, 2020 at 7:24 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add binding documentation for the spi-mux driver. This allows a generic
> multiplexer to be used to provide access to multiple SPI devices.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v2:
>     - update license
>     - make dt_binding_check clean

Sure about that?

>
>  .../devicetree/bindings/spi/spi-mux.yaml      | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> new file mode 100644
> index 000000000000..4bdb31e2257e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
> +maintainers:
> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +properties:
> +  compatible:
> +    const: spi-mux
> +
> +  mux-controls:
> +    maxItems: 1
> +
> +required:
> +   - compatible
> +   - reg
> +   - spi-max-frequency
> +   - mux-controls
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
> +       spi-mux@0 {
> +         compatible = "spi-mux";
> +         #address-cells = <1>;
> +         #size-cells = <0>;
> +         reg = <0>;
> +         spi-max-frequency = <100000000>;
> +
> +         mux-controls = <&mux>

Missing semicolon.

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
> +           compatible = "lineartechnology,ltc2488";
> +           reg = <1>;
> +           spi-max-frequency = <10000000>;
> +         };
> +       };
> +     };
> --
> 2.25.0
>
