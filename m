From: Richard GENOUD <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 8/8] ARM: dts: add pinctrl property for spi node for
	atmel SoC
Date: Wed, 3 Apr 2013 12:35:14 +0200
Message-ID: <20130403103512.GB4633@lnx-rg>
References: <1364968581-23700-1-git-send-email-wenyou.yang@atmel.com>
	<1364969032-24281-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, JM.Lin-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1364969032-24281-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On [mer., 03.04.2013 14:03:52], Wenyou Yang wrote:
> Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  arch/arm/boot/dts/at91sam9260.dtsi |   22 ++++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9263.dtsi |   22 ++++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9g45.dtsi |   22 ++++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9n12.dtsi |   22 ++++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9x5.dtsi  |   22 ++++++++++++++++++++++
>  5 files changed, 110 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index 6e31dc8..39253b9 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -322,6 +322,24 @@
>  					};
>  				};
>  
> +				spi0 {
> +					pinctrl_spi0: spi0-0 {
> +						atmel,pins =
> +							<0 0 0x1 0x0	/* PA0 periph A SPI0_MISO pin */
> +							 0 1 0x1 0x0	/* PA1 periph A SPI0_MOSI pin */
> +							 0 2 0x1 0x0>;	/* PA2 periph A SPI0_SPCK pin */
> +					};
> +				};
> +
> +				spi1 {
> +					pinctrl_spi1: spi1-0 {
> +						atmel,pins =
> +							<1 0 0x1 0x0	/* PB0 periph A SPI1_MISO pin */
> +							 1 1 0x1 0x0	/* PB1 periph A SPI1_MOSI pin */
> +							 1 2 0x1 0x0>;	/* PB2 periph A SPI1_SPCK pin */
> +					};
> +				};
> +
>  				pioA: gpio@fffff400 {
>  					compatible = "atmel,at91rm9200-gpio";
>  					reg = <0xfffff400 0x200>;
> @@ -477,6 +495,8 @@
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xfffc8000 0x200>;
>  				interrupts = <12 4 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi0>;
>  				status = "disabled";
>  			};
>  
> @@ -486,6 +506,8 @@
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xfffcc000 0x200>;
>  				interrupts = <13 4 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi1>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index 6c6d9ae..94b58ab 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -303,6 +303,24 @@
>  					};
>  				};
>  
> +				spi0 {
> +					pinctrl_spi0: spi0-0 {
> +						atmel,pins =
> +							<0 0 0x2 0x0	/* PA0 periph B SPI0_MISO pin */
> +							 0 1 0x2 0x0	/* PA1 periph B SPI0_MOSI pin */
> +							 0 2 0x2 0x0>;	/* PA2 periph B SPI0_SPCK pin */
> +					};
> +				};
> +
> +				spi1 {
> +					pinctrl_spi1: spi1-0 {
> +						atmel,pins =
> +							<1 12 0x1 0x0	/* PB12 periph A SPI1_MISO pin */
> +							 1 13 0x1 0x0	/* PB13 periph A SPI1_MOSI pin */
> +							 1 14 0x1 0x0>;	/* PB14 periph A SPI1_SPCK pin */
> +					};
> +				};
> +
>  				pioA: gpio@fffff200 {
>  					compatible = "atmel,at91rm9200-gpio";
>  					reg = <0xfffff200 0x200>;
> @@ -469,6 +487,8 @@
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xfffa4000 0x200>;
>  				interrupts = <14 4 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi0>;
>  				status = "disabled";
>  			};
>  
> @@ -478,6 +498,8 @@
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xfffa8000 0x200>;
>  				interrupts = <15 4 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi1>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index e085b8a..cfdf429 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -322,6 +322,24 @@
>  					};
>  				};
>  
> +				spi0 {
> +					pinctrl_spi0: spi0-0 {
> +						atmel,pins =
> +							<1 0 0x1 0x0	/* PB0 periph A SPI0_MISO pin */
> +							 1 1 0x1 0x0	/* PB1 periph A SPI0_MOSI pin */
> +							 1 2 0x1 0x0>;	/* PB2 periph A SPI0_SPCK pin */
> +					};
> +				};
> +
> +				spi1 {
> +					pinctrl_spi1: spi1-0 {
> +						atmel,pins =
> +							<1 14 0x1 0x0	/* PB14 periph A SPI1_MISO pin */
> +							 1 15 0x1 0x0	/* PB15 periph A SPI1_MOSI pin */
> +							 1 16 0x1 0x0>;	/* PB16 periph A SPI1_SPCK pin */
> +					};
> +				};
> +
>  				pioA: gpio@fffff200 {
>  					compatible = "atmel,at91rm9200-gpio";
>  					reg = <0xfffff200 0x200>;
> @@ -538,6 +556,8 @@
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xfffa4000 0x200>;
>  				interrupts = <14 4 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi0>;
>  				status = "disabled";
>  			};
>  
> @@ -547,6 +567,8 @@
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xfffa8000 0x200>;
>  				interrupts = <15 4 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi1>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index f3f87ef3..b2961f1 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -261,6 +261,24 @@
>  					};
>  				};
>  
> +				spi0 {
> +					pinctrl_spi0: spi0-0 {
> +						atmel,pins =
> +							<0 11 0x1 0x0	/* PA11 periph A SPI0_MISO pin */
> +							 0 12 0x1 0x0	/* PA12 periph A SPI0_MOSI pin */
> +							 0 13 0x1 0x0>;	/* PA13 periph A SPI0_SPCK pin */
> +					};
> +				};
> +
> +				spi1 {
> +					pinctrl_spi1: spi1-0 {
> +						atmel,pins =
> +							<0 21 0x2 0x0	/* PA21 periph B SPI1_MISO pin */
> +							 0 22 0x2 0x0	/* PA22 periph B SPI1_MOSI pin */
> +							 0 23 0x2 0x0>;	/* PA23 periph B SPI1_SPCK pin */
> +					};
> +				};
> +
>  				pioA: gpio@fffff400 {
>  					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  					reg = <0xfffff400 0x200>;
> @@ -380,6 +398,8 @@
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xf0000000 0x100>;
>  				interrupts = <13 4 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi0>;
>  				status = "disabled";
>  			};
>  
> @@ -389,6 +409,8 @@
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xf0004000 0x100>;
>  				interrupts = <14 4 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi1>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 77ce2e1..347b438 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -343,6 +343,24 @@
>  					};
>  				};
>  
> +				spi0 {
> +					pinctrl_spi0: spi0-0 {
> +						atmel,pins =
> +							<0 11 0x1 0x0	/* PA11 periph A SPI0_MISO pin */
> +							 0 12 0x1 0x0	/* PA12 periph A SPI0_MOSI pin */
> +							 0 13 0x1 0x0>;	/* PA13 periph A SPI0_SPCK pin */
> +					};
> +				};
> +
> +				spi1 {
> +					pinctrl_spi1: spi1-0 {
> +						atmel,pins =
> +							<0 21 0x2 0x0	/* PA21 periph B SPI1_MISO pin */
> +							 0 22 0x2 0x0	/* PA22 periph B SPI1_MOSI pin */
> +							 0 23 0x2 0x0>;	/* PA23 periph B SPI1_SPCK pin */
> +					};
> +				};
> +
>  				pioA: gpio@fffff400 {
>  					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  					reg = <0xfffff400 0x200>;
> @@ -536,6 +554,8 @@
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xf0000000 0x100>;
>  				interrupts = <13 4 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi0>;
>  				status = "disabled";
>  			};
>  
> @@ -545,6 +565,8 @@
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xf0004000 0x100>;
>  				interrupts = <14 4 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi1>;
>  				status = "disabled";
>  			};
>  		};
> -- 
> 1.7.9.5
> 
On sam9g35 with DMA and PIO (3.9-rc5 + device tree patches)
Tested-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
