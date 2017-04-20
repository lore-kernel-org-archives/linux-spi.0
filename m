From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/13] Documentation: DT: MIPS: lantiq: Add docs for the
 RCU bindings
Date: Thu, 20 Apr 2017 10:42:22 -0500
Message-ID: <20170420154222.wr6njt4kpfmkibh6@rob-hp-laptop>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-13-hauke@hauke-m.de>
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
In-Reply-To: <20170417192942.32219-13-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 17, 2017 at 09:29:41PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> This adds the initial documentation for the RCU module (a MFD device
> which provides USB PHYs, reset controllers and more).

This should come before the other patches.

> 
> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 82 ++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> new file mode 100644
> index 000000000000..9e5b1e7493e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> @@ -0,0 +1,82 @@
> +Lantiq XWAY SoC RCU binding
> +===========================
> +
> +This binding describes the RCU (reset controller unit) multifunction device,
> +where each sub-device has it's own set of registers.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: The first and second values must be: "simple-mfd", "syscon"
> +- reg		: The address and length of the system control registers
> +
> +
> +-------------------------------------------------------------------------------
> +Example of the RCU bindings on a xRX200 SoC:
> +	rcu0: rcu@203000 {
> +		compatible = "simple-mfd", "syscon";

Needs an SoC specific compatible string here.

> +		reg = <0x203000 0x100>;
> +		big-endian;
> +
> +		gphy0: rcu_gphy@0 {
> +			compatible = "lantiq,xrx200a2x-rcu-gphy";
> +			lantiq,rcu-syscon = <&rcu0 0x20>;

So these are already child nodes. You can get rid of this and use 
reg/ranges instead.

> +			resets = <&rcu_reset0 31>;
> +			reset-names = "gphy";
> +			lantiq,gphy-mode = <GPHY_MODE_GE>;
> +			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
> +			clock-names = "gphy";
> +		};
> +
> +		gphy1: rcu_gphy@1 {
> +			compatible = "lantiq,xrx200a2x-rcu-gphy";
> +			lantiq,rcu-syscon = <&rcu0 0x68>;
> +			resets = <&rcu_reset0 29>;
> +			reset-names = "gphy";
> +			lantiq,gphy-mode = <GPHY_MODE_FE>;
> +			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
> +			clock-names = "gphy";
> +		};
> +
> +		rcu_reset0: rcu_reset@0 {
> +			compatible = "lantiq,rcu-reset";
> +			lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
> +			#reset-cells = <1>;
> +			reset-request = <31>, <29>, <21>, <19>, <16>, <12>;
> +			reset-status  = <30>, <28>, <16>, <25>, <5>,  <24>;
> +		};
> +
> +		rcu_reset1: rcu_reset@1 {
> +			compatible = "lantiq,rcu-reset";
> +			lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
> +			#reset-cells = <1>;
> +		};
> +
> +		usb_phys0: rcu-usb2-phy@0 {
> +			compatible = "lantiq,xrx200-rcu-usb2-phy";
> +
> +			lantiq,rcu-syscon = <&rcu0 0x18 0x38>;
> +			resets = <&rcu_reset1 4>, <&rcu_reset0 4>;
> +			reset-names = "phy", "ctrl";
> +			#phy-cells = <0>;
> +		};
> +
> +		usb_phys1: rcu-usb2-phy@1 {
> +			compatible = "lantiq,xrx200-rcu-usb2-phy";
> +
> +			lantiq,rcu-syscon = <&rcu0 0x34 0x3C>;
> +			resets = <&rcu_reset1 5>, <&rcu_reset0 4>;
> +			reset-names = "phy", "ctrl";
> +			#phy-cells = <0>;
> +		};
> +
> +		reboot {
> +			compatible = "syscon-reboot";
> +			regmap = <&rcu0>;
> +			offset = <0x10>;
> +			mask = <0x40000000>;
> +		};
> +
> +		/* more sub-device nodes (USB PHY, etc.) */
> +	};
> +
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
