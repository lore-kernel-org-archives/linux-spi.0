From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: crypto: Convert stm32 QSPI bindings to
 json-schema
Date: Wed, 20 Nov 2019 12:04:03 -0600
Message-ID: <20191120180403.GA11687@bogus>
References: <20191115142318.2909-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191115142318.2909-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Nov 15, 2019 at 03:23:18PM +0100, Benjamin Gaignard wrote:
> Convert the STM32 QSPI binding to DT schema format using json-schema

Leftover 'crypto' in the subject.

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/spi/spi-stm32-qspi.txt     | 47 -----------
>  .../devicetree/bindings/spi/st,stm32-qspi.yaml     | 91 ++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> new file mode 100644
> index 000000000000..955405d39966
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/st,stm32-qspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Quad Serial Peripheral Interface (QSPI) bindings
> +
> +maintainers:
> +  - Christophe Kerello <christophe.kerello@st.com>
> +  - Patrice Chotard <patrice.chotard@st.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    const: st,stm32f469-qspi
> +
> +  reg:
> +    items:
> +      - description: registers
> +      - description: memory mapping
> +    minItems: 2
> +    maxItems: 2

Implied by the 'items' length.

> +
> +  reg-names:
> +    items:
> +     - const: qspi
> +     - const: qspi_mm
> +    minItems: 2
> +    maxItems: 2

Implied by the 'items' length.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: tx DMA channel
> +      - description: rx DMA channel
> +    minItems: 2
> +    maxItems: 2

Implied by the 'items' length.

> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +    minItems: 2
> +    maxItems: 2

Implied by the 'items' length.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    spi@58003000 {
> +      compatible = "st,stm32f469-qspi";
> +      reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
> +      reg-names = "qspi", "qspi_mm";
> +      interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +      dmas = <&mdma1 22 0x10 0x100002 0x0 0x0>,
> +             <&mdma1 22 0x10 0x100008 0x0 0x0>;
> +      dma-names = "tx", "rx";
> +      clocks = <&rcc QSPI_K>;
> +      resets = <&rcc QSPI_R>;
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      flash@0 {
> +        compatible = "jedec,spi-nor";
> +        reg = <0>;
> +        spi-rx-bus-width = <4>;
> +        spi-max-frequency = <108000000>;
> +      };
> +    };
> +
> +...
> -- 
> 2.15.0
> 
