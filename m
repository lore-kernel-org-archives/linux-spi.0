From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v7 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
Date: Tue, 11 Jul 2017 23:16:31 +0200
Message-ID: <231fc92f-5e3e-bff0-9a59-081e291f83e8@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-15-hauke@hauke-m.de>
 <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
 <30adb3f5-50b5-35e3-685f-9fe0fa8c31f8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <30adb3f5-50b5-35e3-685f-9fe0fa8c31f8-l0cyMroinI0@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 07/11/2017 08:38 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Friday 07 July 2017 07:53 PM, Rob Herring wrote:
>> On Mon, Jul 03, 2017 at 12:40:49AM +0200, Hauke Mehrtens wrote:
>>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>>> the PHY interfaces for each core. The phy instances can be passed to the
>>> dwc2 driver, which already supports the generic phy interface.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
>>> Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> 
> I see you have added my name in cc but for some reason I don't have the patch
> in my mailbox. Can you resend it please?

I send it to you and I did not receive any error message from the mail
servers involved, I will check my mail server log files the next time.

I assume that your mail server just silently drops my mails.

>>> ---
>>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  42 ++++
>>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>>  drivers/phy/Kconfig                                |   8 +
>>>  drivers/phy/Makefile                               |   1 +
>>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++++++++
> 
> Please create a new directory withing phy for adding a phy driver.

Should I use lantiq or intel as folder name? Lantiq was bought by Intel
and the Lantiq brand will be replaced by the Intel brand in the future.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
