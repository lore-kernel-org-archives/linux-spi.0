From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/13] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
Date: Thu, 20 Apr 2017 10:36:06 -0500
Message-ID: <20170420153606.fdhedc7ovvhc66qd@rob-hp-laptop>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-12-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-12-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 17, 2017 at 09:29:40PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
> the PHY interfaces for each core. The phy instances can be passed to the
> dwc2 driver, which already supports the generic phy interface.
> 
> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
> ---
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  59 ++++
>  arch/mips/lantiq/xway/reset.c                      |  43 ---
>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 325 +++++++++++++++++++++
>  6 files changed, 405 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> new file mode 100644
> index 000000000000..0ec9f790b6e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> @@ -0,0 +1,59 @@
> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
> +===========================================
> +
> +This binding describes the USB PHY hardware provided by the RCU module on the
> +Lantiq XWAY SoCs.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties (controller (parent) node):
> +- compatible		: Should be one of
> +				"lantiq,ase-rcu-usb2-phy"
> +				"lantiq,danube-rcu-usb2-phy"
> +				"lantiq,xrx100-rcu-usb2-phy"
> +				"lantiq,xrx200-rcu-usb2-phy"
> +				"lantiq,xrx300-rcu-usb2-phy"

The first x in xrx seems to be a wildcard. Don't use wildcards in 
compatible strings.

> +- lantiq,rcu-syscon	: A phandle to the RCU module and the offsets to the
> +			  USB PHY configuration and USB MAC registers.

Same comment as gphy.

> +- address-cells		: should be 1
> +- size-cells		: should be 0
> +- phy-cells		: from the generic PHY bindings, must be 1

Missing the '#'

> +
> +Optional properties (controller (parent) node):
> +- vbus-gpio		: References a GPIO which enables VBUS all given USB
> +			  ports.

-gpios is preferred form.

> +
> +Required nodes		:  A sub-node is required for each USB PHY port.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties (port (child) node):

Where's the sub nodes in the example?

> +- reg        	: The ID of the USB port, usually 0 or 1.
> +- clocks	: References to the (PMU) "ctrl" and "phy" clk gates.
> +- clock-names	: Must be one of the following:
> +			"ctrl"
> +			"phy"
> +- resets	: References to the RCU USB configuration reset bits.
> +- reset-names	: Must be one of the following:
> +			"analog-config" (optional)
> +			"statemachine-soft" (optional)
> +
> +Optional properties (port (child) node):
> +- vbus-gpio	: References a GPIO which enables VBUS for the USB port.
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the USB PHYs on an xRX200 SoC:
> +	usb_phys0: rcu-usb2-phy@0 {

usb-phy@...

> +		compatible      = "lantiq,xrx200-rcu-usb2-phy";

Extra spaces.

> +		reg = <0>;
> +
> +		lantiq,rcu-syscon = <&rcu0 0x18 0x38>;
> +		clocks = <&pmu PMU_GATE_USB0_CTRL>,
> +			 <&pmu PMU_GATE_USB0_PHY>;
> +		clock-names = "ctrl", "phy";
> +		vbus-gpios = <&gpio 32 GPIO_ACTIVE_HIGH>;
> +		resets = <&rcu_reset1 4>, <&rcu_reset0 4>;
> +		reset-names = "phy", "ctrl";
> +		#phy-cells = <0>;
> +	};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
