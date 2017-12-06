From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM64: dts: meson-axg: add the SPICC controller
Date: Wed, 06 Dec 2017 15:57:50 -0800
Message-ID: <7hy3mfmmtd.fsf@baylibre.com>
References: <20171128132926.19051-1-yixun.lan@amlogic.com>
        <20171128132926.19051-4-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>,
        Sunny Luo <sunny.luo-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
        <linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171128132926.19051-4-yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org> (Yixun Lan's
        message of "Tue, 28 Nov 2017 21:29:26 +0800")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org> writes:

> From: Sunny Luo <sunny.luo-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>
> Add DT info for the SPICC controller which found in
> the Amlogic's Meson-AXG SoC.
>
> Signed-off-by: Sunny Luo <sunny.luo-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>

This patch looks OK but it doesn't apply cleanly.

A quick glance suggests that it's becuase it has a dependency on the PWM
series, but that dependency was not described here (or in the cover
letter.)

If the series does not apply directly on mainline, the cover letter
should describe the dependencies clearly.

In your case, I understand it's difficult because you have many series
in parallel at the same time.  I would suggest that locally, you keep
each series as independent branches based on the latest -rc tag.  It's
pretty easy for me to resolve simple add-add conflicts when there are
two different series adding to the DT, but it can be more time consuming
when I have to figure out the dependencies myself, so I generally don't
do that and just reject the patches instead so the submitter can work
out (and document) the dependencies.

Also some questions...

> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 92 ++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index fe3878f7718c..021b929d8d6e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -208,6 +208,28 @@
>  				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
>  				status = "disabled";
>  			};
> +
> +			spicc_a: spi@13000 {
> +				compatible = "amlogic,meson-axg-spicc";
> +				reg = <0x0 0x13000 0x0 0x3c>;
> +				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc CLKID_SPICC0>;
> +				clock-names = "core";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spicc_b: spi@15000 {
> +				compatible = "amlogic,meson-axg-spicc";
> +				reg = <0x0 0x15000 0x0 0x3c>;
> +				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc CLKID_SPICC1>;
> +				clock-names = "core";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};

Here you use the labels spicc_a and spicc_b, but the datasheet
uses 0 and 1.  Why the difference?

Hmm, but after looking at the pin definitions those are using A and B.
Confusing.

Can you clarify which is the right one, and also work with the datasheet
team on consistency?  Thanks!

Kevin


>  		};
>  
>  		gic: interrupt-controller@ffc01000 {
> @@ -470,6 +492,76 @@
>  						function = "pwm_d";
>  					};
>  				};
> +
> +				spi_a_pins: spi_a {
> +					mux {
> +						groups = "spi_miso_a",
> +							"spi_mosi_a",
> +							"spi_clk_a";
> +						function = "spi_a";
> +					};
> +				};
> +
> +				spi_ss0_a_pins: spi_ss0_a {
> +					mux {
> +						groups = "spi_ss0_a";
> +						function = "spi_a";
> +					};
> +				};
> +
> +				spi_ss1_a_pins: spi_ss1_a {
> +					mux {
> +						groups = "spi_ss1_a";
> +						function = "spi_a";
> +					};
> +				};
> +
> +				spi_ss2_a_pins: spi_ss2_a {
> +					mux {
> +						groups = "spi_ss2_a";
> +						function = "spi_a";
> +					};
> +				};
> +
> +
> +				spi_b_a_pins: spi_b_a {
> +					mux {
> +						groups = "spi_miso_b_a",
> +							"spi_mosi_b_a",
> +							"spi_clk_b_a";
> +						function = "spi_b";
> +					};
> +				};
> +
> +				spi_ss0_b_a_pins: spi_ss0_b_a {
> +					mux {
> +						groups = "spi_ss0_b_a";
> +						function = "spi_b";
> +					};
> +				};
> +
> +				spi_ss1_b_pins: spi_ss1_b {
> +					mux {
> +						groups = "spi_ss1_b";
> +						function = "spi_b";
> +					};
> +				};
> +
> +				spi_b_x_pins: spi_b_x {
> +					mux {
> +						groups = "spi_miso_b_x",
> +							"spi_mosi_b_x",
> +							"spi_clk_b_x";
> +						function = "spi_b";
> +					};
> +				};
> +
> +				spi_ss0_b_x_pins: spi_ss0_b_x {
> +					mux {
> +						groups = "spi_ss0_b_x";
> +						function = "spi_b";
> +					};
> +				};
>  			};
>  		};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
