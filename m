From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2 07/15] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
Date: Thu, 25 May 2017 20:22:26 +0200
Message-ID: <aa0f9259-b96f-f072-93d4-a42e05fadc82@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de>
 <20170521130918.27446-8-hauke@hauke-m.de>
 <CAHp75VeQgekiWc+YxP5sDFBB4fvmRs1=heFcdYS6mAgqPACW7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VeQgekiWc+YxP5sDFBB4fvmRs1=heFcdYS6mAgqPACW7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 05/22/2017 08:05 AM, Andy Shevchenko wrote:
> On Sun, May 21, 2017 at 4:09 PM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
>> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>
>> This allows using the xbar driver on ARX300 based SoCs which require the
>> same xbar setup as the xRX200 chipsets because the xbar driver
>> initialization is not guarded by an xRX200 specific
>> of_machine_is_compatible condition anymore. Additionally the new driver
>> takes a syscon phandle to configure the XBAR endianness bits in RCU
>> (before this was done in arch/mips/lantiq/xway/reset.c and also
>> guarded by an VRX200 specific if-statement).
> 
>> +#include <linux/ioport.h>
> 
> I'm not sure you need this.
> 
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
> 
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_address.h>
> 
> And these lines are under question, see below.

I will remove them they look unneeded.

>> +#include <linux/regmap.h>
>> +
> 
>> +#include <lantiq_soc.h>
> 
> This rather should be "lantiq_soc.h"

lantiq_soc.h is located here:
arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
I do not think that #include "lantiq_soc.h" would work.
It is only needed for ltq_w32_mask(), I will probably inline this and
then this include is not needed any more.

>> +static int ltq_xbar_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +       struct resource res_xbar;
>> +       struct regmap *rcu_regmap;
>> +       void __iomem *xbar_membase;
>> +       u32 rcu_ahb_endianness_reg_offset;
>> +       u32 rcu_ahb_endianness_val;
>> +       int ret;
>> +
> 
>> +       ret = of_address_to_resource(np, 0, &res_xbar);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to get xbar resources");
>> +               return ret;
>> +       }
>> +
>> +       if (!devm_request_mem_region(dev, res_xbar.start,
>> +                                    resource_size(&res_xbar),
>> +               res_xbar.name)) {
>> +               dev_err(dev, "Failed to get xbar resources");
>> +               return -ENODEV;
>> +       }
>> +
>> +       xbar_membase = devm_ioremap_nocache(dev, res_xbar.start,
>> +                                               resource_size(&res_xbar));
>> +       if (!xbar_membase) {
>> +               dev_err(dev, "Failed to remap xbar resources");
>> +               return -ENODEV;
>> +       }
> 
> And what's wrong with traditional pattern
> 
> y = platform_get_resource(IOMEM);
> x = devm_ioremap_resource(y);
> if (IS_ERR(x))
>  return PTR_ERR(x);
> 
> ?

Your suggestion looks better, I will change it.

>> +
>> +       /* RCU configuration is optional */
>> +       rcu_regmap = syscon_regmap_lookup_by_phandle(np, "lantiq,rcu-syscon");
>> +       if (!IS_ERR_OR_NULL(rcu_regmap)) {
> 
>> +               if (of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
>> +                       &rcu_ahb_endianness_reg_offset)) {
> 
> device_property_*() ?

The device tree property looks like this:
lantiq,rcu-syscon = <&rcu0 0x4c>;

This would would probably return a pointer to phandle and not to 0x4c. I
would use an array here, and access it at [1], but I do not think that
is better.
device_property_read_u32(dev, "lantiq,rcu-syscon",
			  &rcu_ahb_endianness_reg_offset);

>> +                       dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               if (of_device_is_big_endian(np))
> 
> Do we have common helper for this (I mean resource provider agnostic one)?

I am not aware of any. This will check for this device tree property:
big-endian;

> 
>> +                       rcu_ahb_endianness_val = RCU_VR9_BE_AHB1S;
>> +               else
>> +                       rcu_ahb_endianness_val = 0;
>> +
>> +               if (regmap_update_bits(rcu_regmap,
>> +                                       rcu_ahb_endianness_reg_offset,
>> +                                       RCU_VR9_BE_AHB1S,
>> +                                       rcu_ahb_endianness_val))
>> +                       dev_warn(&pdev->dev,
>> +                               "Failed to configure RCU AHB endianness\n");
>> +       }
>> +
>> +       /* disable fpi burst */
>> +       ltq_w32_mask(XBAR_FPI_BURST_EN, 0,
>> +                    xbar_membase + XBAR_ALWAYS_LAST);
>> +
>> +       return 0;
>> +}
> 
>> +builtin_platform_driver(xbar_driver);
> 
> Why it can't be module?

Currently this is used to load it early. This sets the AHB bus system
which connects the USB and the PCIe controllers to the system to big
Endian mode, this is needed for at least some accesses to these
components. It would be better to have a dependency in device tree to
reflect this.
Should I use a phandle to connect them?

Hauke

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
