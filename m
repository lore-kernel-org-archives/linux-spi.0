From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
Date: Tue, 30 May 2017 21:31:27 +0300
Message-ID: <CAHp75Ve9bV99=WCzmXU-Rth-gar5gqvy4taZ7NMQQHGKcVbHHw@mail.gmail.com>
References: <20170528184006.31668-1-hauke@hauke-m.de> <20170528184006.31668-15-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "martin.blumenstingl" <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
        john <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "hauke.mehrtens" <hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170528184006.31668-15-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, May 28, 2017 at 9:40 PM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
> the PHY interfaces for each core. The phy instances can be passed to the
> dwc2 driver, which already supports the generic phy interface.

> +static void ltq_rcu_usb2_start_cores(struct platform_device *pdev)

It should return int. See below.

> +{

> +       /* Power on the USB core. */
> +       if (clk_prepare_enable(priv->ctrl_gate_clk)) {

You basically shadow the error, why?

> +               dev_err(dev, "failed to enable CTRL gate\n");
> +               return;
> +       }

> +       if (clk_prepare_enable(priv->phy_gate_clk)) {
> +               dev_err(dev, "failed to enable PHY gate\n");
> +               return;
> +       }

Ditto.

> +static int ltq_rcu_usb2_of_probe(struct device_node *phynode,
> +                                   struct ltq_rcu_usb2_priv *priv)
> +{
> +       struct device *dev = priv->dev;
> +       const struct of_device_id *match =
> +               of_match_node(ltq_rcu_usb2_phy_of_match, phynode);
> +       int ret;
> +

> +       if (!match) {
> +               dev_err(dev, "Not a compatible Lantiq RCU USB PHY\n");
> +               return -EINVAL;
> +       }

Can it ever happen?

> +
> +       priv->reg_bits = match->data;

I think there is a helper to get driver data directly from node.

> +       if (priv->reg_bits->have_ana_cfg) {
> +               ret = device_property_read_u32(dev, "offset-ana",
> +                                              &priv->ana_cfg1_reg_offset);
> +               if (ret) {
> +                       dev_dbg(dev, "Failed to get RCU ANA CFG1 reg offset\n");
> +                       return ret;
> +               }
> +       }

ret = device_property_...(...);
if (ret && priv->reg_bits->have_ana_cfg) {
 ...
 return ret;
}

?


> +       priv->dev = &pdev->dev;

> +       dev_set_drvdata(priv->dev, priv);

Move this to the end of function. Ideally it should be run if and only
if the function returns 0.

> +       provider = devm_of_phy_provider_register(&pdev->dev,
> +                                                of_phy_simple_xlate);
> +
> +       return PTR_ERR_OR_ZERO(provider);

I would do explicitly, though it's up to you and maintainer.

if (IS_ERR(provider))
 return PTR_ERR();

return 0;

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
