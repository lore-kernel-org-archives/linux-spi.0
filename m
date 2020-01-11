From: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i: H6: Add SPI controllers nodes
 and pinmuxes
Date: Sat, 11 Jan 2020 18:26:39 +0100
Message-ID: <20200111172639.to3lhzros6ca5hj2@gilmour.lan>
References: <20200108101006.150706-1-andre.przywara@arm.com>
 <20200108101006.150706-2-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200108101006.150706-2-andre.przywara-5wv7dgnIgG8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 08, 2020 at 10:10:05AM +0000, Andre Przywara wrote:
> The Allwinner H6 SoC contains two SPI controllers similar to the H3/A64,
> but with the added capability of 3-wire and 4-wire operation modes.
> For now the driver does not support those, but the SPI registers are
> fully backwards-compatible, just adding bits and registers which were
> formerly reserved. So we can use the existing driver for the "normal" SPI
> modes, for instance to access the SPI NOR flash soldered on the PineH64
> board.
> We use an H6 specific compatible string in addition to the existing H3
> string, so when the driver later gains Quad SPI support, it should work
> automatically without any DT changes.
>
> Tested by accessing the SPI flash on a Pine H64 board (SPI0), also
> connecting another SPI flash to the SPI1 header pins.
>
> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 54 ++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 3329283e38ab..40835850893e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -338,6 +338,30 @@
>  				bias-pull-up;
>  			};
>
> +			/omit-if-no-ref/
> +			spi0_pins: spi0-pins {
> +				pins = "PC0", "PC2", "PC3";
> +				function = "spi0";
> +			};
> +
> +			/omit-if-no-ref/
> +			spi0_cs_pin: spi0-cs-pin {
> +				pins = "PC5";
> +				function = "spi0";
> +			};

It seems suspicious to use it in the Pine H64, since PC5 is also used
by the eMMC (and this prevents either the SPI or the emmc controller
to probe, depending on which probed first).

Maxime
