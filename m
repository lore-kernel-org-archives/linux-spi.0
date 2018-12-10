From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Date: Mon, 10 Dec 2018 22:35:53 +0100
Message-ID: <20181210213553.GK8952@piout.net>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Cyrille.Pitchen@microchip.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-mtd@lists.infradead.org, broonie@kernel.org,
        linux-spi@vger.kernel.org
To: Tudor.Ambarus@microchip.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181210171511.21002-1-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 10/12/2018 17:15:29+0000, Tudor.Ambarus@microchip.com wrote:
> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> 
> This patch configures the QSPI0 controller pin muxing and declares
> a jedec,spi-nor memory.
> 
> sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
> memory which advertises a maximum frequency of 80MHz for Quad IO
> Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
> the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> [tudor.ambarus@microchip.com:
> - drop partitions,
> - add spi-rx/tx-bus-width
> - change spi-max-frequency to match the 80MHz limit advertised by
>   MX25L25673G for Quad IO Fast Read,
> - reword commit message and subject.]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 518e2b095ccf..171bc82cfbbf 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -108,6 +108,21 @@
>  		};
>  
>  		apb {
> +			qspi0: spi@f0020000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_qspi0_default>;
> +				/* status = "okay"; */ /* conflict with sdmmc1 */

Isn't that conflicting then because I think the default is okay.

> +
> +				flash@0 {
> +					compatible = "jedec,spi-nor";
> +					reg = <0>;
> +					spi-max-frequency = <80000000>;
> +					spi-tx-bus-width = <4>;
> +					spi-rx-bus-width = <4>;
> +					m25p,fast-read;
> +				};
> +			};
> +
>  			spi0: spi@f8000000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_spi0_default>;
> @@ -485,6 +500,22 @@
>  					bias-disable;
>  				};
>  
> +				pinctrl_qspi0_default: qspi0_default {
> +					sck_cs {
> +						pinmux = <PIN_PA22__QSPI0_SCK>,
> +							 <PIN_PA23__QSPI0_CS>;
> +						bias-disable;
> +					};
> +
> +					data {
> +						pinmux = <PIN_PA24__QSPI0_IO0>,
> +							 <PIN_PA25__QSPI0_IO1>,
> +							 <PIN_PA26__QSPI0_IO2>,
> +							 <PIN_PA27__QSPI0_IO3>;
> +						bias-pull-up;
> +					};
> +				};
> +
>  				pinctrl_sdmmc0_default: sdmmc0_default {
>  					cmd_data {
>  						pinmux = <PIN_PA1__SDMMC0_CMD>,
> -- 
> 2.9.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
