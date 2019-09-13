From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Convert spi-sifive binding to
 json-schema
Date: Fri, 13 Sep 2019 15:36:26 +0100
Message-ID: <5d7ba96b.1c69fb81.edf8e.655e@mx.google.com>
References: <1568098996-4180-1-git-send-email-pragnesh.patel@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: palmer@sifive.com, paul.walmsley@sifive.com,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
To: Pragnesh Patel <pragnesh.patel@sifive.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568098996-4180-1-git-send-email-pragnesh.patel@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Sep 10, 2019 at 12:32:51PM +0530, Pragnesh Patel wrote:
> Convert the spi-sifive binding to DT schema format.
> 
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>  .../devicetree/bindings/spi/spi-sifive.txt         | 37 ----------
>  .../devicetree/bindings/spi/spi-sifive.yaml        | 86 ++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.yaml


> diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.yaml b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
> new file mode 100644
> index 0000000..368f5d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-sifive.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive SPI controller
> +
> +maintainers:
> +  - Pragnesh Patel <pragnesh.patel@sifive.com>
> +  - Paul Walmsley  <paul.walmsley@sifive.com>
> +  - Palmer Dabbelt <palmer@sifive.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sifive,fu540-c000-spi
> +      - const: sifive,spi0
> +
> +    description:
> +      Should be "sifive,<chip>-spi" and "sifive,spi<version>".
> +      Supported compatible strings are -
> +      "sifive,fu540-c000-spi" for the SiFive SPI v0 as integrated
> +      onto the SiFive FU540 chip, and "sifive,spi0" for the SiFive
> +      SPI v0 IP block with no chip integration tweaks.
> +      Please refer to sifive-blocks-ip-versioning.txt for details
> +
> +      SPI RTL that corresponds to the IP block version numbers can be found here -
> +      https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/spi
> +
> +  reg:
> +    maxItems: 1
> +
> +    description:
> +      Physical base address and size of SPI registers map
> +      A second (optional) range can indicate memory mapped flash
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +    description:
> +      Must reference the frequency given to the controller
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

These 2 are covered by spi-controller.yaml, so you can drop them.

> +
> +  sifive,fifo-depth:
> +    description:
> +      Depth of hardware queues; defaults to 8

default: 8

What are valid values?

> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Will need to be under 'allOf' with the above constraints.

> +
> +  sifive,max-bits-per-word:
> +    description:
> +      Maximum bits per word; defaults to 8
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Same comments here.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +examples:
> +  - |
> +    spi: spi@10040000 {
> +      compatible = "sifive,fu540-c000-spi", "sifive,spi0";
> +      reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
> +      interrupt-parent = <&plic>;
> +      interrupts = <51>;
> +      clocks = <&tlclk>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      sifive,fifo-depth = <8>;
> +      sifive,max-bits-per-word = <8>;
> +    };
> +
> +...
> -- 
> 2.7.4
> 
