From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFCv2 3/9] dt-bindings: spi: meson: convert to yaml
Date: Mon, 5 Aug 2019 15:45:48 -0600
Message-ID: <CAL_Jsq+WQ6KAE+d2_Pu03s6cSbu4PUErUWrGj81cAivTBNWBxQ@mail.gmail.com>
References: <20190805120320.32282-1-narmstrong@baylibre.com>
 <20190805120320.32282-4-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-spi <linux-spi@vger.kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190805120320.32282-4-narmstrong@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Mon, Aug 5, 2019 at 6:03 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic SPI controllers over to two separate YAML schemas.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 67 +++++++++++++++++++
>  .../bindings/spi/amlogic,meson6-spifc.yaml    | 53 +++++++++++++++
>  .../devicetree/bindings/spi/spi-meson.txt     | 55 ---------------
>  3 files changed, 120 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> new file mode 100644
> index 000000000000..49b617c98ae7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/amlogic,meson-gx-spicc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson SPI Communication Controller
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +description: |
> +  The Meson SPICC is a generic SPI controller for general purpose Full-Duplex
> +  communications with dedicated 16 words RX/TX PIO FIFOs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-gx-spicc # SPICC controller on Amlogic GX and compatible SoCs
> +      - amlogic,meson-axg-spicc # SPICC controller on Amlogic AXG and compatible SoCs
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    description: input clock for the baud rate generator
> +    items:
> +      - const: core
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    spi@c1108d80 {
> +          compatible = "amlogic,meson-gx-spicc";
> +          reg = <0xc1108d80 0x80>;
> +          interrupts = <112>;
> +          clocks = <&clk81>;
> +          clock-names = "core";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          ethernet-switch@0 {
> +              compatible = "micrel,ks8995m";
> +              spi-max-frequency = <1000000>;
> +              reg = <0>;
> +          };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> new file mode 100644
> index 000000000000..67dcedc81a5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/amlogic,meson6-spifc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson SPI Flash Controller
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +description: |
> +  The Meson SPIFC is a controller optimized for communication with SPI
> +  NOR memories, without DMA support and a 64-byte unified transmit /
> +  receive buffer.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson6-spifc # SPI Flash Controller on Meson6 and compatible SoCs
> +      - amlogic,meson-gxbb-spifc # SPI Flash Controller on GXBB and compatible SoCs
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +examples:
> +  - |
> +    spi@c1108c80 {
> +          compatible = "amlogic,meson6-spifc";
> +          reg = <0xc1108c80 0x80>;
> +          clocks = <&clk81>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          flash: m25p80@0 {

flash@0

I need to write a schema for this or I'll never stop giving this comment...

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +              compatible = "spansion,m25p80", "jedec,spi-nor";
> +              reg = <0>;
> +              spi-max-frequency = <40000000>;
> +          };
> +    };
> +
