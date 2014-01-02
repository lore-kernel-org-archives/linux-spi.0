From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/8] spi: rspi: Add support for more than one interrupt
Date: Thu, 2 Jan 2014 11:25:36 +0100
Message-ID: <CAMuHMdU8HjLgix0dvrECm3tan909s8kF_OznP1060KUN2dDTaw@mail.gmail.com>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
	<1387885248-28425-4-git-send-email-geert+renesas@linux-m68k.org>
	<2037815.gDYqhVmlrl@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	linux-spi@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2037815.gDYqhVmlrl@avalon>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Laurent,

On Tue, Dec 31, 2013 at 12:38 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 24 December 2013 12:40:43 Geert Uytterhoeven wrote:
>> +     int irq[MAX_NUM_IRQ];
>
> Should this field be called irqs ?

OK.

>> +     unsigned int numirq;
>
> This driver seems to use underscores to separate words in variable names,
> maybe you could use num_irq (or num_irqs) instead.

OK.

>> +     int i, ret = 0;
>
> i is an unsigned loop index, could you please make it an unsigned int ?

OK.

>> @@ -948,6 +948,19 @@ static int rspi_probe(struct platform_device *pdev)
>>       rspi->ops = ops;
>>       rspi->master = master;
>>
>> +     for (i = 0; i < MAX_NUM_IRQ; i++) {
>> +             irq = platform_get_irq(pdev, i);
>> +             if (irq < 0) {
>> +                     if (rspi->numirq)
>> +                             break;
>> +                     dev_err(&pdev->dev, "platform_get_irq error\n");
>> +                     ret = -ENODEV;
>> +                     goto error1;
>> +             }
>> +             rspi->irq[i] = irq;
>> +             rspi->numirq++;
>> +     }
>> +
>>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>       rspi->addr = devm_ioremap_resource(&pdev->dev, res);
>>       if (IS_ERR(rspi->addr)) {
>> @@ -979,14 +992,16 @@ static int rspi_probe(struct platform_device *pdev)
>>       master->transfer = rspi_transfer;
>>       master->cleanup = rspi_cleanup;
>>
>> -     ret = devm_request_irq(&pdev->dev, irq, rspi_irq, 0,
>> -                            dev_name(&pdev->dev), rspi);
>> -     if (ret < 0) {
>> -             dev_err(&pdev->dev, "request_irq error\n");
>> -             goto error1;
>> +     for (i = 0; i < rspi->numirq; i++) {
>> +             ret = devm_request_irq(&pdev->dev, rspi->irq[i], rspi_irq, 0,
>> +                                    dev_name(&pdev->dev), rspi);
>> +             if (ret < 0) {
>> +                     dev_err(&pdev->dev, "request_irq %d error\n",
>> +                             rspi->irq[i]);
>> +                     goto error1;
>> +             }
>>       }
>
> Just an idea, what about combining the two loops ?

I was a bit concerned about dependencies and cleanup, but indeed, it seems
to be possible.

>> --- a/include/linux/spi/rspi.h
>> +++ b/include/linux/spi/rspi.h
>> @@ -1,7 +1,7 @@
>>  /*
>>   * Renesas SPI driver
>>   *
>> - * Copyright (C) 2012  Renesas Solutions Corp.
>> + * Copyright (C) 2012, 2013  Renesas Solutions Corp.
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License as published by
>
> This change seems to be unrelated. You might want to squash it into patch 1/8.

I'll move it to the first patch that actually adds code to rspi.h.

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
