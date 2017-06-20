From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v4 12/16] MIPS: lantiq: Add a GPHY driver which uses the
 RCU syscon-mfd
Date: Wed, 21 Jun 2017 00:19:09 +0200
Message-ID: <c3fae486-6ded-0bb2-d7e4-89ada96986d0@hauke-m.de>
References: <20170619222608.13344-1-hauke@hauke-m.de>
 <20170619222608.13344-13-hauke@hauke-m.de>
 <CAHp75VcDgC7n3FVig0r0RBg=B655sv_jWQt7RWXU9uPx9QGvqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
In-Reply-To: <CAHp75VcDgC7n3FVig0r0RBg=B655sv_jWQt7RWXU9uPx9QGvqA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/20/2017 01:36 AM, Andy Shevchenko wrote:
> On Tue, Jun 20, 2017 at 1:26 AM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
>> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>
>> Compared to the old xrx200_phy_fw driver the new version has multiple
>> enhancements. The name of the firmware files does not have to be added
>> to all .dts files anymore - one now configures the GPHY mode (FE or GE)
>> instead. Each GPHY can now also boot separate firmware (thus mixing of
>> GE and FE GPHYs is now possible).
>> The new implementation is based on the RCU syscon-mfd and uses the
>> reeset_controller framework instead of raw RCU register reads/writes.
>>
> 
> Couple of comments, otherwise FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
>> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
>> ---
>>  .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  36 +++
>>  arch/mips/lantiq/xway/sysctrl.c                    |   6 +-
>>  drivers/soc/lantiq/Makefile                        |   1 +
>>  drivers/soc/lantiq/gphy.c                          | 261 +++++++++++++++++++++
>>  include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 ++
>>  5 files changed, 317 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>>  create mode 100644 drivers/soc/lantiq/gphy.c
>>  create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h

......

>> +
>> +       /*
>> +        * GPHY cores need the firmware code in a persistent and contiguous
>> +        * memory area with a 16 kB boundary aligned start address.
>> +        */
>> +       priv->size = fw->size + XRX200_GPHY_FW_ALIGN;
>> +
>> +       priv->fw_addr = dma_alloc_coherent(dev, priv->size,
>> +                                          &priv->dma_addr, GFP_KERNEL);
> 
> dmam_ ?

Thanks, didn't know this functions was looking for something with devm_
prefix, but dmam_ makes the code simpler.

....

>> +
>> +       ret = xway_gphy_load(dev, priv, &fw_addr);
>> +       if (ret)
> 
> You need to disable and unprepare a clock.

Done

>> +               return ret;
>> +

....
> 
>> +       dma_free_coherent(dev, priv->size, priv->fw_addr, priv->dma_addr);
> 
> It will go away if dmam_ variant is in use.

Done

>> +
>> +       ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
>> +       if (ret)
>> +               dev_warn(dev, "Failed to unregister reboot notifier\n");
...

Hauke

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
