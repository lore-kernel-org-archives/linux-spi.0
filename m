From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v2 00/12] spi: moving to struct gpio_desc
Date: Sat, 29 Jul 2017 16:23:57 +0300
Message-ID: <CAHp75VfX4feUUidvDWAJezgbSA8ah7TOV_bMja7wrc3B9gqA7g@mail.gmail.com>
References: <20170727220322.26654-1-chris.packham@alliedtelesis.co.nz> <CAHp75VeVijF13AO=SqkxtAaiYhss92gwrtCZ2WnxkkKtvjVS3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VeVijF13AO=SqkxtAaiYhss92gwrtCZ2WnxkkKtvjVS3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Jul 29, 2017 at 4:15 PM, Andy Shevchenko
<andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Jul 28, 2017 at 1:03 AM, Chris Packham
> <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:

> I briefly looked at the code, first 6 patches for my taste could be
> submitted w/o RFC tag.
> One comment to them though, better to use u32 instead of unsigned int
> when operate with 32-bit registers.

>> H Hartley Sweeten (6):
>>   spi: spi-ep93xx: use 32-bit read/write for all registers
>>   spi: spi-ep93xx: add spi master prepare_transfer_hardware()
>>   spi: spi-ep93xx: absorb the interrupt enable/disable helpers
>>   spi: spi-ep93xx: pass the spi_master pointer around
>>   spi: spi-ep93xx: remove private data 'current_msg'
>>   spi: spi-ep93xx: use the default master transfer queueing mechanism

So, after addressing above feel free to add my

Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

to patches 1-6.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
