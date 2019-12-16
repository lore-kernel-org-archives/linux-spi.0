From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: Convert stm32 spi bindings to
 json-schema
Date: Mon, 16 Dec 2019 15:49:51 -0600
Message-ID: <20191216214951.GA9328@bogus>
References: <20191204153233.791-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>, alexandre.torgue@st.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, broonie@kernel.org,
 Erwan Leray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191204153233.791-1-benjamin.gaignard@st.com>
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

On Wed, Dec 04, 2019 at 04:32:33PM +0100, Benjamin Gaignard wrote:
> Convert the STM32 spi binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Erwan Leray <erwan.leray@st.com>
> CC: Fabrice Gasnier <fabrice.gasnier@st.com>
> CC: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/spi/spi-stm32.txt          |  62 ------------
>  .../devicetree/bindings/spi/st,stm32-spi.yaml      | 105 +++++++++++++++++++++
>  2 files changed, 105 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
> deleted file mode 100644
> index d82755c63eaf..000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
> +++ /dev/null
> @@ -1,62 +0,0 @@
> -STMicroelectronics STM32 SPI Controller
> -
> -The STM32 SPI controller is used to communicate with external devices using
> -the Serial Peripheral Interface. It supports full-duplex, half-duplex and
> -simplex synchronous serial communication with external devices. It supports
> -from 4 to 32-bit data size. Although it can be configured as master or slave,
> -only master is supported by the driver.
> -
> -Required properties:
> -- compatible: Should be one of:
> -  "st,stm32h7-spi"
> -  "st,stm32f4-spi"
> -- reg: Offset and length of the device's register set.
> -- interrupts: Must contain the interrupt id.
> -- clocks: Must contain an entry for spiclk (which feeds the internal clock
> -	  generator).
> -- #address-cells:  Number of cells required to define a chip select address.
> -- #size-cells: Should be zero.
> -
> -Optional properties:
> -- resets: Must contain the phandle to the reset controller.
> -- A pinctrl state named "default" may be defined to set pins in mode of
> -  operation for SPI transfer.
> -- dmas: DMA specifiers for tx and rx dma. DMA fifo mode must be used. See the
> -  STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt.
> -- dma-names: DMA request names should include "tx" and "rx" if present.
> -- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
> -  Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -
> -Child nodes represent devices on the SPI bus
> -  See ../spi/spi-bus.txt
> -
> -Optional properties:
> -- st,spi-midi-ns: Only for STM32H7, (Master Inter-Data Idleness) minimum time
> -		  delay in nanoseconds inserted between two consecutive data
> -		  frames.
> -
> -
> -Example:
> -	spi2: spi@40003800 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "st,stm32h7-spi";
> -		reg = <0x40003800 0x400>;
> -		interrupts = <36>;
> -		clocks = <&rcc SPI2_CK>;
> -		resets = <&rcc 1166>;
> -		dmas = <&dmamux1 0 39 0x400 0x01>,
> -		       <&dmamux1 1 40 0x400 0x01>;
> -		dma-names = "rx", "tx";
> -		pinctrl-0 = <&spi2_pins_b>;
> -		pinctrl-names = "default";
> -		cs-gpios = <&gpioa 11 0>;
> -
> -		aardvark@0 {
> -			compatible = "totalphase,aardvark";
> -			reg = <0>;
> -			spi-max-frequency = <4000000>;
> -			st,spi-midi-ns = <4000>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> new file mode 100644
> index 000000000000..57ef3a0f57e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/st,stm32-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 SPI Controller bindings
> +
> +description: |
> +  The STM32 SPI controller is used to communicate with external devices using
> +  the Serial Peripheral Interface. It supports full-duplex, half-duplex and
> +  simplex synchronous serial communication with external devices. It supports
> +  from 4 to 32-bit data size.
> +
> +maintainers:
> +  - Erwan Leray <erwan.leray@st.com>
> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +  - if:
> +      properties:
> +        comptatible:
> +          constains:

One of the features of json-schema is ignoring unknown keywords like 
'constains'. I've tried to mitigate this with the meta-schema, but seems 
this one didn't get caught. But checkpatch.pl caught it.


> +            st,stm32f4-spi
> +    then:
> +      properties:
> +        st,spi-midi-ns: false
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,stm32f4-spi
> +      - st,stm32h7-spi
> +
> +  reg:
> +    maxItems: 1
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
> +    description: |
> +      DMA specifiers for tx and rx dma. DMA fifo mode must be used. See
> +      the STM32 DMA bindings Documentation/devicetree/bindings/dma/stm32-dma.txt.
> +    items:
> +      - description: rx DMA channel
> +      - description: tx DMA channel
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +patternProperties:
> +  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-f]+$":
> +    type: object
> +    # SPI slave nodes must be children of the SPI master node and can
> +    # contain the following properties.
> +    properties:
> +      st,spi-midi-ns:
> +        $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type since it has a standard unit. I'd assume there's 
at least some max less than 2^32 you could define.

> +        description: |
> +          Only for STM32H7, (Master Inter-Data Idleness) minimum time
> +          delay in nanoseconds inserted between two consecutive data frames.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    spi@4000b000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      compatible = "st,stm32h7-spi";
> +      reg = <0x4000b000 0x400>;
> +      interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&rcc SPI2_K>;
> +      resets = <&rcc SPI2_R>;
> +      dmas = <&dmamux1 0 39 0x400 0x05>,
> +             <&dmamux1 1 40 0x400 0x05>;
> +      dma-names = "rx", "tx";
> +      cs-gpios = <&gpioa 11 0>;
> +
> +      aardvark@0 {
> +        compatible = "totalphase,aardvark";
> +        reg = <0>;
> +        spi-max-frequency = <4000000>;
> +        st,spi-midi-ns = <4000>;
> +      };
> +    };
> +
> +...
> -- 
> 2.15.0
> 
