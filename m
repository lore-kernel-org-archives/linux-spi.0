From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2 07/15] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
Date: Thu, 25 May 2017 20:54:34 +0200
Message-ID: <5a7ebea5-d98b-f84b-64a0-86127ed31feb@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de>
 <20170521130918.27446-8-hauke@hauke-m.de>
 <CAHp75VeQgekiWc+YxP5sDFBB4fvmRs1=heFcdYS6mAgqPACW7g@mail.gmail.com>
 <aa0f9259-b96f-f072-93d4-a42e05fadc82@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <aa0f9259-b96f-f072-93d4-a42e05fadc82-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 05/25/2017 08:22 PM, Hauke Mehrtens wrote:
> On 05/22/2017 08:05 AM, Andy Shevchenko wrote:
>> On Sun, May 21, 2017 at 4:09 PM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
>>> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>>
>>> This allows using the xbar driver on ARX300 based SoCs which require the
>>> same xbar setup as the xRX200 chipsets because the xbar driver
>>> initialization is not guarded by an xRX200 specific
>>> of_machine_is_compatible condition anymore. Additionally the new driver
>>> takes a syscon phandle to configure the XBAR endianness bits in RCU
>>> (before this was done in arch/mips/lantiq/xway/reset.c and also
>>> guarded by an VRX200 specific if-statement).
>>
>>
>>> +builtin_platform_driver(xbar_driver);
>>
>> Why it can't be module?
> 
> Currently this is used to load it early. This sets the AHB bus system
> which connects the USB and the PCIe controllers to the system to big
> Endian mode, this is needed for at least some accesses to these
> components. It would be better to have a dependency in device tree to
> reflect this.
> Should I use a phandle to connect them?
> 
> Hauke
> 

I will try to make this a bus driver which should be used instead of the
smiple-bus.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
