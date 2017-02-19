From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v4 1/2] mtd: spi-nor: Added spi-nor init function
Date: Sun, 19 Feb 2017 11:37:51 +0100
Message-ID: <54393706-cd93-603a-193b-25fbf52b2d83@denx.de>
References: <1487086368-4118-1-git-send-email-kdasu.kdev@gmail.com>
 <1487086368-4118-2-git-send-email-kdasu.kdev@gmail.com>
 <b6079dbb-82fc-7579-32b2-b8c071ef02ef@denx.de>
 <CAKekbesKKS_s873D=xy2tQcVYei_26gYipn2ru1rVY4ihXbsXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKekbesKKS_s873D=xy2tQcVYei_26gYipn2ru1rVY4ihXbsXw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/19/2017 10:47 AM, Kamal Dasu wrote:
> On Sat, Feb 18, 2017 at 5:29 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>> On 02/14/2017 04:32 PM, Kamal Dasu wrote:
>>> Refactored spi_nor_scan() code to add spi_nor_init() function that
>>> programs the spi-nor flash to:
>>> 1) remove flash protection if applicable
>>> 2) set read mode to quad mode if configured such
>>> 3) set the address width based on the flash size and vendor
>>>
>>> spi_nor_scan() now calls spi_nor_init() to setup nor flash.
>>>
>>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Changelog missing ?
> 
> Yes will add it and resend.
> 
>>
>>> ---
>>>  drivers/mtd/spi-nor/spi-nor.c | 72 +++++++++++++++++++++++++++----------------
>>>  include/linux/mtd/spi-nor.h   | 18 ++++++++++-
>>>  2 files changed, 62 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>>> index 70e52ff..2bf7f4f 100644
>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>> @@ -1526,6 +1526,44 @@ static int s3an_nor_scan(const struct flash_info *info, struct spi_nor *nor)
>>>       return 0;
>>>  }
>>>
>>> +int spi_nor_init(struct spi_nor *nor)
>>> +{
>>> +     int ret = 0;
>>> +     const struct flash_info *info = nor->info;
>>> +     struct device *dev = nor->dev;
>>> +
>>> +     /*
>>> +      * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
>>> +      * with the software protection bits set
>>> +      */
>>> +
>>> +     if (JEDEC_MFR(info) == SNOR_MFR_ATMEL ||
>>> +         JEDEC_MFR(info) == SNOR_MFR_INTEL ||
>>> +         JEDEC_MFR(info) == SNOR_MFR_SST ||
>>> +         info->flags & SPI_NOR_HAS_LOCK) {
>>> +             write_enable(nor);
>>> +             write_sr(nor, 0);
>>> +             spi_nor_wait_till_ready(nor);
>>> +     }
>>> +
>>> +     if (nor->flash_read == SPI_NOR_QUAD) {
>>> +             ret = set_quad_mode(nor, info);
>>> +             if (ret) {
>>> +                     dev_err(dev, "quad mode not supported\n");
>>> +                     return ret;
>>> +             }
>>> +     }
> 
> quad mode is being set in the above block of code.
> 
>>> +
>>> +     if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
>>> +         info->flags & SPI_NOR_4B_OPCODES)
>>> +             spi_nor_set_4byte_opcodes(nor, info);
>>> +     else
>>> +             set_4byte(nor, info, 1);
>>> +
>>> +     return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(spi_nor_init);
>>> +
>>>  int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>>>  {
>>>       const struct flash_info *info = NULL;
>>> @@ -1571,6 +1609,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>>>               }
>>>       }
>>>
>>> +     nor->info = info;
>>>       mutex_init(&nor->lock);
>>>
>>>       /*
>>> @@ -1581,20 +1620,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>>>       if (info->flags & SPI_S3AN)
>>>               nor->flags |=  SNOR_F_READY_XSR_RDY;
>>>
>>> -     /*
>>> -      * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
>>> -      * with the software protection bits set
>>> -      */
>>> -
>>> -     if (JEDEC_MFR(info) == SNOR_MFR_ATMEL ||
>>> -         JEDEC_MFR(info) == SNOR_MFR_INTEL ||
>>> -         JEDEC_MFR(info) == SNOR_MFR_SST ||
>>> -         info->flags & SPI_NOR_HAS_LOCK) {
>>> -             write_enable(nor);
>>> -             write_sr(nor, 0);
>>> -             spi_nor_wait_till_ready(nor);
>>> -     }
>>> -
>>>       if (!mtd->name)
>>>               mtd->name = dev_name(dev);
>>>       mtd->priv = nor;
>>> @@ -1669,11 +1694,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>>>
>>>       /* Quad/Dual-read mode takes precedence over fast/normal */
>>>       if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
>>> -             ret = set_quad_mode(nor, info);
>>> -             if (ret) {
>>> -                     dev_err(dev, "quad mode not supported\n");
>>> -                     return ret;
>>> -             }
>>>               nor->flash_read = SPI_NOR_QUAD;
>>
>> So from here on, any user will expect quad mode to be correctly set, but
>> it really isn't. Is that OK ?
> 
> It is being set in spi_nor_init() based on the  nor->flash_read == SPI_NOR_QUAD;
> 

But that's invoked later, so whoever adds code between this place and
the invocation of spi_nor_init() will be misled into believing the SPI
NOR is set up in quad-mode, while it would not be, right ?

[...]

-- 
Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
