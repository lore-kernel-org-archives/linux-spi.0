From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 06/13] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
Date: Tue, 25 Apr 2017 08:56:17 +0200
Message-ID: <8742e3b3-4dc2-bc74-f607-00d96f74512c@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-7-hauke@hauke-m.de>
 <20170420144848.hwvtrhnwxcsxyv7x@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170420144848.hwvtrhnwxcsxyv7x@rob-hp-laptop>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org



On 04/20/2017 04:48 PM, Rob Herring wrote:
> On Mon, Apr 17, 2017 at 09:29:35PM +0200, Hauke Mehrtens wrote:
>> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>
>> This allows using the xbar driver on ARX300 based SoCs which require the
>> same xbar setup as the xRX200 chipsets because the xbar driver
>> initialization is not guarded by an xRX200 specific
>> of_machine_is_compatible condition anymore. Additionally the new driver
>> takes a syscon phandle to configure the XBAR endianness bits in RCU
>> (before this was done in arch/mips/lantiq/xway/reset.c and also
>> guarded by an xRX200 specific if-statement).
>>
>> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
>> ---
>>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  22 +++++
>>  MAINTAINERS                                        |   1 +
>>  arch/mips/lantiq/xway/reset.c                      |   4 -
>>  arch/mips/lantiq/xway/sysctrl.c                    |  41 ---------
>>  drivers/soc/Makefile                               |   1 +
>>  drivers/soc/lantiq/Makefile                        |   1 +
>>  drivers/soc/lantiq/xbar.c                          | 100 +++++++++++++++++++++
>>  7 files changed, 125 insertions(+), 45 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>>  create mode 100644 drivers/soc/lantiq/Makefile
>>  create mode 100644 drivers/soc/lantiq/xbar.c
>>
>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/xbar.txt b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>> new file mode 100644
>> index 000000000000..86e53ff3b0d5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>> @@ -0,0 +1,22 @@
>> +Lantiq XWAY SoC XBAR binding
>> +============================
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties:
>> +- compatible	: Should be "lantiq,xbar-xway"
> 
> This compatible is already in use so it is fine, but you should also 
> have per SoC compatible strings.

I will add a new SoC specific one.
What does per SoC device tree mean? Does it mean for the same silicon,
for the same silicon revision, for the same fusing of a silicon or for
the same marketing name?

I would like to make it per silicon or per silicon revision for the IP
cores which I know are different.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
