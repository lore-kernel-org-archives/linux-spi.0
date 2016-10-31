From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] fpga: Add support for Lattice iCE40 FPGAs
Date: Mon, 31 Oct 2016 01:33:17 -0500
Message-ID: <20161031063317.fqoaqemoiqhrrjzg@rob-hp-laptop>
References: <1477776746-3678-1-git-send-email-joel@airwebreathe.org.uk>
 <1477776746-3678-2-git-send-email-joel@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1477776746-3678-2-git-send-email-joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Oct 29, 2016 at 03:32:26PM -0600, Joel Holdsworth wrote:
> The Lattice iCE40 is a family of FPGAs with a minimalistic architecture
> and very regular structure, designed for low-cost, high-volume consumer
> and system applications.
> 
> This patch adds support to the FPGA manager for configuring the SRAM of
> iCE40LM, iCE40LP, iCE40HX, iCE40 Ultra, iCE40 UltraLite and iCE40
> UltraPlus devices, through slave SPI.
> 
> The iCE40 family is notable because it is the first FPGA family to have
> complete reverse engineered bit-stream documentation for the iCE40LP and
> iCE40HX devices. Furthermore, there is now a Free Software Verilog
> synthesis tool-chain: the "IceStorm" tool-chain.
> 
> This project is the work of Clifford Wolf, who is the maintainer of
> Yosys Verilog RTL synthesis framework, and Mathias Lasser, with notable
> contributions from "Cotton Seed", the main author of "arachne-pnr"; a
> place-and-route tool for iCE40 FPGAs.
> 
> Having a Free Software synthesis tool-chain offers interesting
> opportunities for embedded devices that are able reconfigure themselves
> with open firmware that is generated on the device itself. For example
> a mobile device might have an application processor with an iCE40 FPGA
> attached, which implements slave devices, or through which the processor
> communicates with other devices through the FPGA fabric.
> 
> A kernel driver for the iCE40 is useful, because in some cases, the FPGA
> may need to be configured before other devices can be accessed.
> 
> An example of such a device is the icoBoard; a RaspberryPI HAT which
> features an iCE40HX8K with a 1 or 8 MBit SRAM and ports for
> Digilent-compatible PMOD modules. A PMOD module may contain a device
> with which the kernel communicates, via the FPGA.
> ---
>  .../bindings/fpga/lattice-ice40-fpga-mgr.txt       |  23 +++

It's preferred that bindings are a separate patch.

>  drivers/fpga/Kconfig                               |   6 +
>  drivers/fpga/Makefile                              |   1 +
>  drivers/fpga/ice40-spi.c                           | 219 +++++++++++++++++++++
>  4 files changed, 249 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
>  create mode 100644 drivers/fpga/ice40-spi.c
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
> new file mode 100644
> index 0000000..3d2917c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
> @@ -0,0 +1,23 @@
> +Lattice iCE40 FPGA Manager
> +
> +Required properties:
> +- compatible:		should contain "lattice,ice40-fpga-mgr"
> +- reg:			SPI chip select
> +- spi-max-frequency:	Maximum SPI frequency (>=1000000, <=25000000)
> +- cdone-gpio:		GPIO connected to CDONE pin

-gpios is preferred.

Please state direction and polarity.

> +- creset_b-gpio:	GPIO connected to CRESET_B pin. Note that CRESET_B is

Don't use '_'. In this case, I'd just do cresetb-gpios.

> +			treated as an active-low output because the signal is
> +			treated as an enable signal, rather than a reset. This

Though for enable signals, enable-gpios is fairly standard even if that 
deviates from the pin name.

> +			is necessary because the FPGA will enter Master SPI
> +			mode and drive SCK with a clock signal, potentially
> +			jamming other devices on the bus, unless CRESET_B is
> +			held high until the firmware is loaded.
> +
> +Example:
> +	ice40: ice40@0 {
> +		compatible = "lattice,ice40-fpga-mgr";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		cdone-gpio = <&gpio 24 GPIO_ACTIVE_HIGH>;
> +		creset_b-gpio = <&gpio 22 GPIO_ACTIVE_LOW>;
> +	};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
