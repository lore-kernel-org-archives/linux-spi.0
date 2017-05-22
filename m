From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 07/15] MIPS: lantiq: Convert the xbar driver to a platform_driver
Date: Mon, 22 May 2017 09:05:53 +0300
Message-ID: <CAHp75VeQgekiWc+YxP5sDFBB4fvmRs1=heFcdYS6mAgqPACW7g@mail.gmail.com>
References: <20170521130918.27446-1-hauke@hauke-m.de> <20170521130918.27446-8-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170521130918.27446-8-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, May 21, 2017 at 4:09 PM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>
> This allows using the xbar driver on ARX300 based SoCs which require the
> same xbar setup as the xRX200 chipsets because the xbar driver
> initialization is not guarded by an xRX200 specific
> of_machine_is_compatible condition anymore. Additionally the new driver
> takes a syscon phandle to configure the XBAR endianness bits in RCU
> (before this was done in arch/mips/lantiq/xway/reset.c and also
> guarded by an VRX200 specific if-statement).

> +#include <linux/ioport.h>

I'm not sure you need this.

> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>

> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>

And these lines are under question, see below.

> +#include <linux/regmap.h>
> +

> +#include <lantiq_soc.h>

This rather should be "lantiq_soc.h"

> +static int ltq_xbar_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct resource res_xbar;
> +       struct regmap *rcu_regmap;
> +       void __iomem *xbar_membase;
> +       u32 rcu_ahb_endianness_reg_offset;
> +       u32 rcu_ahb_endianness_val;
> +       int ret;
> +

> +       ret = of_address_to_resource(np, 0, &res_xbar);
> +       if (ret) {
> +               dev_err(dev, "Failed to get xbar resources");
> +               return ret;
> +       }
> +
> +       if (!devm_request_mem_region(dev, res_xbar.start,
> +                                    resource_size(&res_xbar),
> +               res_xbar.name)) {
> +               dev_err(dev, "Failed to get xbar resources");
> +               return -ENODEV;
> +       }
> +
> +       xbar_membase = devm_ioremap_nocache(dev, res_xbar.start,
> +                                               resource_size(&res_xbar));
> +       if (!xbar_membase) {
> +               dev_err(dev, "Failed to remap xbar resources");
> +               return -ENODEV;
> +       }

And what's wrong with traditional pattern

y = platform_get_resource(IOMEM);
x = devm_ioremap_resource(y);
if (IS_ERR(x))
 return PTR_ERR(x);

?

> +
> +       /* RCU configuration is optional */
> +       rcu_regmap = syscon_regmap_lookup_by_phandle(np, "lantiq,rcu-syscon");
> +       if (!IS_ERR_OR_NULL(rcu_regmap)) {

> +               if (of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
> +                       &rcu_ahb_endianness_reg_offset)) {

device_property_*() ?

> +                       dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (of_device_is_big_endian(np))

Do we have common helper for this (I mean resource provider agnostic one)?

> +                       rcu_ahb_endianness_val = RCU_VR9_BE_AHB1S;
> +               else
> +                       rcu_ahb_endianness_val = 0;
> +
> +               if (regmap_update_bits(rcu_regmap,
> +                                       rcu_ahb_endianness_reg_offset,
> +                                       RCU_VR9_BE_AHB1S,
> +                                       rcu_ahb_endianness_val))
> +                       dev_warn(&pdev->dev,
> +                               "Failed to configure RCU AHB endianness\n");
> +       }
> +
> +       /* disable fpi burst */
> +       ltq_w32_mask(XBAR_FPI_BURST_EN, 0,
> +                    xbar_membase + XBAR_ALWAYS_LAST);
> +
> +       return 0;
> +}

> +builtin_platform_driver(xbar_driver);

Why it can't be module?

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
