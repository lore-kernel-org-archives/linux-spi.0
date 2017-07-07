From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 05/16] watchdog: lantiq: add device tree binding
 documentation
Date: Fri, 7 Jul 2017 09:08:34 -0500
Message-ID: <20170707140834.nugjw5jxkyzwrmzq@rob-hp-laptop>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-6-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170702224051.15109-6-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 03, 2017 at 12:40:40AM +0200, Hauke Mehrtens wrote:
> The binding was not documented before, add the documentation now.
> 
> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
> ---
>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> new file mode 100644
> index 000000000000..c3967feebb6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> @@ -0,0 +1,24 @@
> +Lantiq WTD watchdog binding
> +============================
> +
> +This describes the binding of the Lantiq watchdog driver.
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,wdt"
> +				"lantiq,xrx100-wdt"
> +				"lantiq,xrx200-wdt"
> +				"lantiq,falcon-wdt"
> +- lantiq,rcu		: A phandle to the RCU syscon (required for
> +			  "lantiq,falcon-wdt", "lantiq,xrx200-wdt" and
> +			  "lantiq,xrx100-wdt")
> +
> +-------------------------------------------------------------------------------
> +Example for the watchdog on the xRX200 SoCs:
> +		watchdog@803f0 {
> +			compatible = "lantiq,xrx200-wdt", "lantiq,xrx100-wdt";

This is still mismatched. If the example is correct, then the compatible 
list should be:

"lantiq,wdt"
"lantiq,xrx100-wdt"
"lantiq,xrx200-wdt", "lantiq,xrx100-wdt"
"lantiq,falcon-wdt"

You can also remove "lantiq,xrx200-wdt" from the driver if you want as 
"lantiq,xrx100-wdt" is good enough to match on.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
