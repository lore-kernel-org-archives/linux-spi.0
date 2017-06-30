From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Date: Fri, 30 Jun 2017 15:22:56 +0300
Message-ID: <CAHp75Ve+oO7Zzk4jN3BOVCWWsEVki0yNQfpkfuw4Q5K85CMQHg@mail.gmail.com>
References: <20170629213951.31176-1-hauke@hauke-m.de> <20170629213951.31176-11-hauke@hauke-m.de>
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
        Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170629213951.31176-11-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jun 30, 2017 at 12:39 AM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:

> +static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev,
> +                                  unsigned long id, bool assert)
> +{
> +       struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
> +       unsigned int set = id & 0x1f;


> +       int ret;
> +       u32 val;
> +
> +       if (assert)
> +               val = BIT(set);
> +       else
> +               val = 0;

I would put this as

u32 val = assert ? BIT(set) : 0;
int ret;

...but it's up to you.

The rest looks fine.

> +
> +       ret = regmap_update_bits(priv->regmap, priv->reset_offset, BIT(set),
> +                                val);
> +       if (ret) {
> +               dev_err(priv->dev, "Failed to set reset bit %u\n", set);
> +               return ret;
> +       }
> +
> +
> +       ret = lantiq_rcu_reset_status_timeout(rcdev, id, assert);
> +       if (ret)
> +               dev_err(priv->dev, "Failed to %s bit %u\n",
> +                       assert ? "assert" : "deassert", set);
> +
> +       return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
