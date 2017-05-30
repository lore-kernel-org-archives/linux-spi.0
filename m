From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v3 08/16] MIPS: lantiq: Convert the fpi bus driver to a
 platform_driver
Date: Wed, 31 May 2017 00:02:36 +0200
Message-ID: <6d18d1d4-b69c-70dd-f64e-2209685fe360@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-9-hauke@hauke-m.de>
 <CAHp75VcU3cF07GQG5vPV9uhmpOzO2aGD8Fj9-Do4yN3BXNN1Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VcU3cF07GQG5vPV9uhmpOzO2aGD8Fj9-Do4yN3BXNN1Rg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/30/2017 08:23 PM, Andy Shevchenko wrote:
> On Sun, May 28, 2017 at 9:39 PM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
>> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>
>> Instead of hacking the configuration of the FPI bus into the arch code
>> add an own bus driver for this internal bus. The FPI bus is the main
>> bus of the SoC. This bus driver makes sure the bus is configured
>> correctly before the child drivers are getting initialized. This driver
>> will probably also be used on different SoC later.
> 
>> +Optional properties:
>> +- regmap               : A phandle to the RCU syscon
> 
>> +- offset-endianness    : Offset of the endianness configuration register
> 
> Shouldn't be one of
> 
> big-endian;
> little-endian;
> native-endian;
> 
> ?

The offset-endianness is the offset of the endianes register in the RCU
register range which is accessed through the syscon. For the SoCs where
I checked it is the same value. I should add a documentation of big-endian.

> For what purpose that register is used?
> Is it configurable in RTL? IOW why you need to have it in DT?
> 
>> +               offset-endianness = <0x4c>;
>> +               big-endian;
> 
>> +       /* RCU configuration is optional */
>> +       rcu_regmap = syscon_regmap_lookup_by_phandle(np, "regmap");
> 
>> +       if (!IS_ERR_OR_NULL(rcu_regmap)) {
> 
> _OR_NULL is suspicious. You are doing something wrong.
> 

This is only needed for some SoCs, some chips do not have this register.
Should I do this based on the compatibility string?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
