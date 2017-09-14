From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: Add ADI driver for Spreadtrum platform
Date: Thu, 14 Sep 2017 09:50:55 +0800
Message-ID: <CAMz4kuK+cLc07CGifhShYr8ODpM+DL8_ShEH9jk3m59zM46u6A@mail.gmail.com>
References: <d1c5720eccf12ee5ea6bffcbe4c1555680638fcc.1504859001.git.baolin.wang@spreadtrum.com>
 <4573c724b795c569e1ccea2a1a4f6c0bdd602744.1504859001.git.baolin.wang@spreadtrum.com>
 <20170913194548.qsyfyyboitz3mpcr@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170913194548.qsyfyyboitz3mpcr@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Rob,

On 14 September 2017 at 03:45, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Sep 08, 2017 at 04:33:42PM +0800, Baolin Wang wrote:
>> This patch adds ADI driver based on SPI framework for
>> Spreadtrum SC9860 platform.
>>
>> Signed-off-by: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
>> ---
>
> [...]
>
>> +++ b/drivers/spi/spi-sprd-adi.c
>> @@ -0,0 +1,419 @@
>> +/*
>> + * Copyright (C) 2017 Spreadtrum Communications Inc.
>> + *
>> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> Kernel code should generally not be MIT license.

OK. Will fix in next version.

>
> [...]
>
>> +static int sprd_adi_drain_fifo(struct sprd_adi *sadi)
>> +{
>> +     u32 timeout = ADI_FIFO_DRAIN_TIMEOUT;
>> +     u32 sts;
>> +
>> +     do {
>> +             sts = readl_relaxed(sadi->base + REG_ADI_ARM_FIFO_STS);
>> +             if (sts & BIT_FIFO_EMPTY)
>> +                     break;
>> +
>> +             cpu_relax();
>> +     } while (--timeout);
>
> You can use readl_poll_timeout.

The readl_poll_timeout() function might be sleep, but we can not sleep
when reading/writing data through ADI controller, since the routine is
under hardware spinlock protection. Moreover it is usually very quick
to jump the loop and we no need to sleep here.

>
>> +
>> +     if (timeout == 0) {
>> +             dev_err(sadi->dev, "drain write fifo timeout\n");
>> +             return -EBUSY;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int sprd_adi_fifo_is_full(struct sprd_adi *sadi)
>> +{
>> +     return readl_relaxed(sadi->base + REG_ADI_ARM_FIFO_STS) & BIT_FIFO_FULL;
>> +}
>> +
>> +static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
>> +{
>> +     int read_timeout = ADI_READ_TIMEOUT;
>> +     u32 val, rd_addr;
>> +
>> +     /*
>> +      * Set the physical register address need to read into RD_CMD register,
>> +      * then ADI controller will start to transfer automatically.
>> +      */
>> +     writel_relaxed(reg_paddr, sadi->base + REG_ADI_RD_CMD);
>> +
>> +     /*
>> +      * Wait read operation complete, the BIT_RD_CMD_BUSY will be set
>> +      * simultaneously when writing read command to register, and the
>> +      * BIT_RD_CMD_BUSY will be cleared after the read operation is
>> +      * completed.
>> +      */
>> +     do {
>> +             val = readl_relaxed(sadi->base + REG_ADI_RD_DATA);
>> +             if (!(val & BIT_RD_CMD_BUSY))
>> +                     break;
>> +
>> +             cpu_relax();
>> +     } while (--read_timeout);
>
> readl_poll_timeout

The same reason as above. Thanks for your comments.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
