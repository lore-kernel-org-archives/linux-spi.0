From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Date: Wed, 30 Jan 2019 18:30:07 +0100
Message-ID: <20190130182958.528e5ac0@bbrezillon>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-9-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130150818.24902-9-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 30 Jan 2019 15:08:45 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
> access, the other for the qspi core and phy. Both are mandatory.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .../devicetree/bindings/spi/atmel-quadspi.txt      | 28 ++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> index e9dae6264d89..e7b7f297c5d7 100644
> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> @@ -1,14 +1,22 @@
>  * Atmel Quad Serial Peripheral Interface (QSPI)
>  
>  Required properties:
> -- compatible:     Should be "atmel,sama5d2-qspi".
> +- compatible:     Should be one of the following
> +		  - "atmel,sama5d2-qspi"
> +		  - "microchip,sam9x60-qspi"
>  - reg:            Should contain the locations and lengths of the base registers
>                    and the mapped memory.
>  - reg-names:      Should contain the resource reg names:
>                    - qspi_base: configuration register address space
>                    - qspi_mmap: memory mapped address space
>  - interrupts:     Should contain the interrupt for the device.
> -- clocks:         The phandle of the clock needed by the QSPI controller.
> +- clocks:	  - "atmel,sama5d2-qspi": the phandle of the clock needed by the
> +		  QSPI controller.
> +		  - "microchip,sam9x60-qspi": should reference the peripheral
> +		  and system QSPI clocks.
> +- clock-names:    Only for sam9x60 - should contain two strigs:

							   ^strings

And I think naming clocks even for sama5d2 is a good practice, so I'd
suggest making "pclk" mandatory even if you support unnamed clk in the
driver to be backward compatible with old DTs.

> +		  - "pclk" for the peripheral clock
> +		  - "qspick" for the system clock
>  - #address-cells: Should be <1>.
>  - #size-cells:    Should be <0>.
>  
> @@ -29,3 +37,19 @@ spi@f0020000 {
>  		...
>  	};
>  };
> +
> +qspi@f0014000 {
> +	compatible = "microchip,sam9x60-qspi";
> +	reg = <0xf0014000 0x100>, <0x70000000 0x08000000>;
> +	reg-names = "qspi_base", "qspi_mmap";
> +	interrupts = <35 IRQ_TYPE_LEVEL_HIGH 7>;
> +	clocks =  <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_SYSTEM 19>;
> +	clock-names = "pclk", "qspick";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +
> +	flash@0 {
> +		...
> +	};
> +};

No need to add one example per compat, especially when all that
changes is the compat string and an extra clk. 
