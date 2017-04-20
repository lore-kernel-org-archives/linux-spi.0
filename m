From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/13] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Date: Thu, 20 Apr 2017 09:54:05 -0500
Message-ID: <20170420145405.7s3iapxggr5575d2@rob-hp-laptop>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-9-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-9-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 17, 2017 at 09:29:37PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> The reset controllers (on xRX200 and newer SoCs have two of them) are
> provided by the RCU module. This was initially implemented as a simple
> reset controller. However, the RCU module provides more functionality
> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> The old reset controller driver implementation from
> arch/mips/lantiq/xway/reset.c did not honor this fact.
> 
> For some devices the request and the status bits are different.
> 
> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
> ---
>  .../devicetree/bindings/reset/lantiq,rcu-reset.txt |  43 ++++
>  arch/mips/lantiq/xway/reset.c                      |  68 ------
>  drivers/reset/Kconfig                              |   6 +
>  drivers/reset/Makefile                             |   1 +
>  drivers/reset/reset-lantiq-rcu.c                   | 231 +++++++++++++++++++++
>  5 files changed, 281 insertions(+), 68 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
>  create mode 100644 drivers/reset/reset-lantiq-rcu.c
> 
> diff --git a/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
> new file mode 100644
> index 000000000000..7f097d16bbb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
> @@ -0,0 +1,43 @@
> +Lantiq XWAY SoC RCU reset controller binding
> +============================================
> +
> +This binding describes a reset-controller found on the RCU module on Lantiq
> +XWAY SoCs.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties (controller (parent) node):
> +- compatible		: Should be "lantiq,rcu-reset"
> +- lantiq,rcu-syscon	: A phandle to the RCU syscon, the reset register
> +			  offset and the status register offset.
> +- #reset-cells		: Specifies the number of cells needed to encode the
> +			  reset line, should be 1.
> +
> +Optional properties:
> +- reset-status		: The request status bit. For some bits the request bit
> +			  and the status bit are different. This is depending
> +			  on the SoC. If the reset-status bit does not match
> +			  the reset-request bit, put the reset number into the
> +			  reset-request property and the status bit at the same
> +			  index into the reset-status property. If no
> +			  reset-request bit is given here, the driver assume
> +			  status and request bit are the same.
> +- reset-request		: The reset request bit, to map it to the reset-status
> +			  bit.

These should either be implied by SoC specific compatible or be made 
part of the reset cells. In the latter case, you still need the SoC 
specific compatible.

> +-------------------------------------------------------------------------------
> +Example for the reset-controllers on the xRX200 SoCs:
> +	rcu_reset0: rcu_reset {
> +		compatible = "lantiq,rcu-reset";
> +		lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
> +		#reset-cells = <1>;
> +		reset-request = <31>, <29>, <21>, <19>, <16>, <12>;
> +		reset-status  = <30>, <28>, <16>, <25>, <5>,  <24>;
> +	};
> +
> +	rcu_reset1: rcu_reset {
> +		compatible = "lantiq,rcu-reset";

These 2 blocks are identical? Given different registers sizes, I'd say 
not. So they should have different compatible strings.

> +		lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
> +		#reset-cells = <1>;
> +	};
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
