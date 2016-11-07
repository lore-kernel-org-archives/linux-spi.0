From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v8 2/3] Documentation: Add binding document for Lattice
 iCE40 FPGA manager
Date: Mon, 7 Nov 2016 18:53:39 +0100
Message-ID: <7876f66a-f8c2-409b-0f18-e8055ddc7784@denx.de>
References: <1478486962-26794-1-git-send-email-joel@airwebreathe.org.uk>
 <1478486962-26794-2-git-send-email-joel@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>,
        atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org,
        geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478486962-26794-2-git-send-email-joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/07/2016 03:49 AM, Joel Holdsworth wrote:
> This adds documentation of the device tree bindings of the Lattice iCE40
> FPGA driver for the FPGA manager framework.
> 
> Signed-off-by: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
> ---
>  .../bindings/fpga/lattice-ice40-fpga-mgr.txt        | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
> new file mode 100644
> index 0000000..7e7a78b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
> @@ -0,0 +1,21 @@
> +Lattice iCE40 FPGA Manager
> +
> +Required properties:
> +- compatible:		Should contain "lattice,ice40-fpga-mgr"
> +- reg:			SPI chip select
> +- spi-max-frequency:	Maximum SPI frequency (>=1000000, <=25000000)
> +- cdone-gpios:		GPIO input connected to CDONE pin
> +- reset-gpios:		Active-low GPIO output connected to CRESET_B pin. Note
> +			that unless the GPIO is held low during startup, the
> +			FPGA will enter Master SPI mode and drive SCK with a
> +			clock signal potentially jamming other devices on the
> +			bus until the firmware is loaded.
> +
> +Example:
> +	ice40: ice40@0 {
> +		compatible = "lattice,ice40-fpga-mgr";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		cdone-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;

Wouldn't it make more sense to have "gpios" and "gpio-names" ? That
scales better imo, although in this case we cannot really talk about
scaling.

> +	};
> 


-- 
Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
