From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v4 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Date: Wed, 21 Jun 2017 00:17:04 +0200
Message-ID: <9a0479f2-e40d-fabb-38ce-8ea366f3da40@hauke-m.de>
References: <20170619222608.13344-1-hauke@hauke-m.de>
 <20170619222608.13344-11-hauke@hauke-m.de>
 <CAHp75Vc+UGCat0QcVeDuxEugc9r=yB5HNPnHuzAdmQnkK2=hGg@mail.gmail.com>
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
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vc+UGCat0QcVeDuxEugc9r=yB5HNPnHuzAdmQnkK2=hGg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 06/20/2017 01:29 AM, Andy Shevchenko wrote:
> On Tue, Jun 20, 2017 at 1:26 AM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
>> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>
>> The reset controllers (on xRX200 and newer SoCs have two of them) are
>> provided by the RCU module. This was initially implemented as a simple
>> reset controller. However, the RCU module provides more functionality
>> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
>> The old reset controller driver implementation from
>> arch/mips/lantiq/xway/reset.c did not honor this fact.
>>
>> For some devices the request and the status bits are different.
>>
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> One nit below.
> 
>> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
>> Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> ---
>>  .../devicetree/bindings/reset/lantiq,reset.txt     |  29 +++
>>  drivers/reset/Kconfig                              |   6 +
>>  drivers/reset/Makefile                             |   1 +
>>  drivers/reset/reset-lantiq.c                       | 215 +++++++++++++++++++++
>>  4 files changed, 251 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
>>  create mode 100644 drivers/reset/reset-lantiq.c

......

>> +static int lantiq_rcu_reset_status_timeout(struct reset_controller_dev *rcdev,
>> +                                          unsigned long id, bool assert)
>> +{
>> +       int ret;
>> +       int retry = LANTIQ_RCU_RESET_TIMEOUT;
>> +
>> +       do {
>> +               ret = lantiq_rcu_reset_status(rcdev, id);
>> +               if (ret < 0)
>> +                       return ret;
> 
>> +               if (ret == assert)
>> +                       break;
> 
> return 0;
> 
>> +               usleep_range(20, 40);
>> +       } while (--retry);
>> +
> 
>> +       return retry ? 0 : -ETIMEDOUT;
> 
> return -ETIMEDOUT;
> 
Changed

...

Hauke


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
