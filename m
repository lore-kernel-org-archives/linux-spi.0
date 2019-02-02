From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Date: Sat, 2 Feb 2019 08:15:02 +0100
Message-ID: <20190202081502.47ca404d@bbrezillon>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-11-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190202040653.1217-11-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 2 Feb 2019 04:07:39 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Naming clocks is a good practice. Make "pclk" madatory even if
> we support unnamed clock in the driver, to be backward compatible
> with old DTs.
> 
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v3: new patch
> 
>  Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> index e9dae6264d89..1de54e87f5d6 100644
> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> @@ -9,6 +9,7 @@ Required properties:
>                    - qspi_mmap: memory mapped address space
>  - interrupts:     Should contain the interrupt for the device.
>  - clocks:         The phandle of the clock needed by the QSPI controller.
> +- clock-names:    Should contain "pclk" for the peripheral clock.
>  - #address-cells: Should be <1>.
>  - #size-cells:    Should be <0>.
>  
> @@ -20,6 +21,7 @@ spi@f0020000 {
>  	reg-names = "qspi_base", "qspi_mmap";
>  	interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
>  	clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
> +	clock-names = "pclk"

Missing semicolon. Once fixed you can add

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

>  	#address-cells = <1>;
>  	#size-cells = <0>;
>  	pinctrl-names = "default";
