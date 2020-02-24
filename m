From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
Date: Mon, 24 Feb 2020 21:59:05 +0300
Message-ID: <ec545462-54ed-9e23-049e-1807d24ec084@cogentembedded.com>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
 <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
 <5603f393-554d-e2a8-c2d8-6bafc20f4169@cogentembedded.com>
 <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org
To: "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
Content-Language: en-MW
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 02/24/2020 08:46 AM, Behme Dirk (CM/ESO2) wrote:

>>>> Add the memory driver for Renesas RPC-IF which registers either SPI or
>>>> HyperFLash device depending on the contents of the device tree subnode.
>>>> It also provides the absract "back end" device APIs that can be used by
>>>> the "front end" SPI/MTD drivers to talk to the real hardware.
>>>>
>>>> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
>>>>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>>
>>> FYI, please find below [1] the changes I did locally on this driver. It seems to read & write successfully on my custom M3 (R8A7796) device, now.
>>
>>     Not for me...
>>     BTW, your patch had whitespace ruined, I had to apply it by hand, you'd better
>> attach the patches, not paste. :-/
> 
> 
> Ok. There are other mailing lists complaining about attachments ;)

   All Linux MLs prefer patches inline. :-)
   But you seem to paste the patches to the mail edited in some MUA (which does ruin
whitespace). Don't do that, it's better to just attach.

> Even better, maybe we should put what we have so far publicly anywhere, e.g. github.

  Cogent has an accout there, I'll try asking the management if it could also be used...

>>> Best regards
>>>
>>> Dirk
>>>
>>> [1]
>>>
>>>  From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
>>> From: Dirk Behme <dirk.behme@de.bosch.com>
>>> Date: Tue, 4 Feb 2020 08:39:31 +0100
>>> Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
>>>   clean up
>>>
>>> This is required to make the driver work correctly in my M3 environment.
>>>
>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>> ---
>>>   drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
>>>   1 file changed, 25 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
>>> index 04be92b64bfa..f4356b066384 100644
>>> --- a/drivers/memory/renesas-rpc-if.c
>>> +++ b/drivers/memory/renesas-rpc-if.c
>> [...]
>>> @@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
>>>       pm_runtime_get_sync(rpc->dev);
>>>
>>>       regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
>>> -    regmap_write(rpc->regmap, RPCIF_DRCR,
>>> -             RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
>>> -    regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
>>> -    regmap_write(rpc->regmap, RPCIF_DREAR,
>>> -             RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
>>> -    regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
>>> -    regmap_write(rpc->regmap, RPCIF_DRENR,
>>> -             rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
>>> -    regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
>>> -    regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
>>
>>     The driver somehow works only with this left in place (with 2 bytes eaten
>> as before), otherwise all the flash reads all 0xff (via dirmap).
> 
> 
> Do you boot from hyperflash?

   No, I have arewto say 'cpld write 30 1' in U-Boot before a boot a kernel.
Normally, the V3x Starter Kit boards are wired for the QSPI flash chips.

> The system I'm using for testing boots from hyperflash. So most probably all registers
> I don't touch in the driver are put into a reasonable state by the boot code, already.
> If you don't boot from hyperflash, that at least would explain our different behavior.

   Yes. Mind dumping the registers and sending to me?

> Best regards
> 
> Dirk

MBR, Sergei
