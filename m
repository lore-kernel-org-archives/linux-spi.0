From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI
 driver for Microchip SAM9X60
Date: Sat, 2 Feb 2019 08:17:23 +0100
Message-ID: <20190202081723.30645d03@bbrezillon>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-13-tudor.ambarus@microchip.com>
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
In-Reply-To: <20190202040653.1217-13-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 2 Feb 2019 04:07:44 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
> access, the other for the qspi core and phy. Both are mandatory.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v3: "pclk" was made mandatory in previous patch. Reword clock
> descriptions.
> v2:
> - make "pclk" mandatory even for sama5d2. Unnamed clk will be
> supported in the driver.
> - drop unneeded example
> 
>  Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> index 1de54e87f5d6..fc7e83adab36 100644
> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> @@ -1,15 +1,19 @@
>  * Atmel Quad Serial Peripheral Interface (QSPI)
>  
>  Required properties:
> -- compatible:     Should be "atmel,sama5d2-qspi".
> +- compatible:     Should be one of the following:
> +		  - "atmel,sama5d2-qspi"
> +		  - "microchip,sam9x60-qspi"
>  - reg:            Should contain the locations and lengths of the base registers
>                    and the mapped memory.
>  - reg-names:      Should contain the resource reg names:
>                    - qspi_base: configuration register address space
>                    - qspi_mmap: memory mapped address space
>  - interrupts:     Should contain the interrupt for the device.
> -- clocks:         The phandle of the clock needed by the QSPI controller.
> -- clock-names:    Should contain "pclk" for the peripheral clock.
> +- clocks:         Should reference the peripheral clock and the QSPI system
> +                  clock if available.
> +- clock-names:    Should contain "pclk" for the peripheral clock and "qspick"
> +                  for the system clock when available.
>  - #address-cells: Should be <1>.
>  - #size-cells:    Should be <0>.
>  
