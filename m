From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add Spreadtrum ADI controller
 documentation
Date: Wed, 13 Sep 2017 14:51:19 -0500
Message-ID: <20170913195119.es5weqo3rbjbgsyl@rob-hp-laptop>
References: <d1c5720eccf12ee5ea6bffcbe4c1555680638fcc.1504859001.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d1c5720eccf12ee5ea6bffcbe4c1555680638fcc.1504859001.git.baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 08, 2017 at 04:33:41PM +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum ADI
> controller device.
> 
> Signed-off-by: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
> ---
> Changes since v1:
>  - Add more documentation the 'sprd,hw-channels' property and why need
>  one hardware spinlock.
> ---
>  .../devicetree/bindings/spi/spi-sprd-adi.txt       |   58 ++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
> new file mode 100644
> index 0000000..0f76336
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
> @@ -0,0 +1,58 @@
> +Spreadtrum ADI controller based on SPI framework

"SPI framework" is not relevant to bindings.

> +
> +ADI is the abbreviation of Anolog-Digital interface, which is used to access
> +analog chip (such as PMIC) from digital chip. ADI controller follows the SPI
> +framework for its hardware implementation is alike to SPI bus and its timing
> +is compatile to SPI timing.
> +
> +ADI controller has 50 channels including 2 software read/write channels and
> +48 hardware channels to access analog chip. For 2 software read/write channels,
> +users should set ADI registers to access analog chip. For hardware channels,
> +we can configure them to allow other hardware components to use it independently,
> +which means we can just link one analog chip address to one hardware channel,
> +then users can access the mapped analog chip address by this hardware channel
> +triggered by hardware components instead of ADI software channels.
> +
> +Thus we introduce one property named "sprd,hw-channels" to configure hardware
> +channels, the first value specifies the hardware channel id which is used to
> +transfer data triggered by hardware automatically, and the second value specifies
> +the analog chip address where user want to access by hardware components.
> +
> +Another hand since we have multi-subsystems will use unique ADI to access analog

Drop "Another hand"

> +chip, when one system is reading/writing data by ADI software channels, that
> +should be under one hardware spinlock protection to prevent other systems from
> +reading/writing data by ADI software channels at the same time, or two parallel
> +routine of setting ADI registers will make ADI controller registers chaos to
> +lead incorrect results. Then we need one hardware spinlock to synchronize between
> +the multiple subsystems.
> +
> +Required properties:
> +- compatible: Should be "sprd,sc9860-adi".
> +- reg: Offset and length of ADI-SPI controller register space.
> +- hwlocks: Reference to a phandle of a hwlock provider node.
> +- hwlock-names: Reference to hwlock name strings defined in the same order
> +	as the hwlocks, should be "adi".
> +- #address-cells: Number of cells required to define a chip select address
> +	on the ADI-SPI bus. Should be set to 1.
> +- #size-cells: Size of cells required to define a chip select address size
> +	on the ADI-SPI bus. Should be set to 0.
> +
> +Optional properties:
> +- sprd,hw-channels: The first value specifies the hardware channel id which
> +	is used to transfer data triggered by hardware automatically, and
> +	the second value specifies the analog chip address where user want
> +	to access by hardware components.

Need to say this is an array of values up to ? channels.

I wonder if this should be a slave property. Is there a relationship 
between the SPI address (i.e. chip select) and the "analog chip 
address"? It sounds like the h/w channels are a protocol specific to a 
particular PMIC/MFD that this controller supports.

> +
> +SPI slave nodes must be children of the SPI controller node and can contain
> +properties described in Documentation/devicetree/bindings/spi/spi-bus.txt.
> +
> +Example:
> +	adi_bus: spi@40030000 {
> +		compatible = "sprd,sc9860-adi";
> +		reg = <0 0x40030000 0 0x10000>;
> +		hwlocks = <&hwlock1 0>;
> +		hwlock-names = "adi";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		sprd,hw-channels = <30 0x8c20>;
> +	};
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
