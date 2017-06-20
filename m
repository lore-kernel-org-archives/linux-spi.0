From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v4 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
Date: Wed, 21 Jun 2017 00:20:49 +0200
Message-ID: <a35bc5b3-fe52-8a06-6bc3-7f974c8b2740@hauke-m.de>
References: <20170619222608.13344-1-hauke@hauke-m.de>
 <20170619222608.13344-15-hauke@hauke-m.de>
 <CAHp75VcYoPBd651s7a=y5yB3mjRG4W+=gWbeKFzwyw04qcg-MQ@mail.gmail.com>
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
        Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VcYoPBd651s7a=y5yB3mjRG4W+=gWbeKFzwyw04qcg-MQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 06/20/2017 01:39 AM, Andy Shevchenko wrote:
> On Tue, Jun 20, 2017 at 1:26 AM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>> the PHY interfaces for each core. The phy instances can be passed to the
>> dwc2 driver, which already supports the generic phy interface.
>>
>> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
>> Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  41 ++++
>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 272 +++++++++++++++++++++
>>  5 files changed, 334 insertions(+), 12 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
>>

....

>> +       /*
>> +        * Power on the USB PHY. We have to do it early because
>> +        * otherwise the second core won't turn on properly.
>> +        */
>> +       ret = clk_prepare_enable(priv->phy_gate_clk);
>> +       if (ret) {
>> +               dev_err(dev, "failed to enable PHY gate\n");
> 
> Disable and unprepare control clock.

Done, is there no devm_ version of this?

>> +               return ret;
>> +       }

...

>> +       ret = ltq_rcu_usb2_start_cores(priv);
>> +       if (ret)
>> +               return ret;
>> +
> 
>> +       provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +       if (IS_ERR(provider))
> 
> Remove line in between.

Done

>> +               return PTR_ERR(provider);
>> +
>> +       dev_set_drvdata(priv->dev, priv);
>> +       return 0;
> 
> You need to carefully check error path that you disabled clocks.

Done

>> +}
>> +

.....

Hauke

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
