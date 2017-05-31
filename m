From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Date: Wed, 31 May 2017 15:58:06 -0500
Message-ID: <20170531205806.uohn2tr6qtrocpl6@rob-hp-laptop>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-11-hauke@hauke-m.de>
 <1496053214.17695.49.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1496053214.17695.49.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 29, 2017 at 12:20:14PM +0200, Philipp Zabel wrote:
> Hi Hauke,
> 
> On Sun, 2017-05-28 at 20:40 +0200, Hauke Mehrtens wrote:
> [...]
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
> > @@ -0,0 +1,30 @@
> > +Lantiq XWAY SoC RCU reset controller binding
> > +============================================
> > +
> > +This binding describes a reset-controller found on the RCU module on Lantiq
> > +XWAY SoCs.
> > +
> > +
> > +-------------------------------------------------------------------------------
> > +Required properties:
> > +- compatible		: Should be one of
> > +				"lantiq,reset-danube"
> > +				"lantiq,reset-xrx200"
> > +- regmap		: A phandle to the RCU syscon
> > +- offset-set		: Offset of the reset set register
> > +- offset-status		: Offset of the reset status register
> > +- #reset-cells		: Specifies the number of cells needed to encode the
> > +			  reset line, should be 2.
> > +			  The first cell takes the reset set bit and the
> > +			  second cell takes the status bit.
> > +
> > +-------------------------------------------------------------------------------
> > +Example for the reset-controllers on the xRX200 SoCs:
> > +	reset0: reset-controller@0 {
> > +		compatible = "lantiq,reset-xrx200";
> > +
> > +		regmap = <&rcu0>;
> 
> Why not place these nodes as children of &rcu0 ? This property would be
> superfluous then.

They are children. So it should be removed and made clear that these are 
child nodes of rcu (here and in other patches in this series).

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
