From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
Date: Tue, 3 Mar 2020 09:42:45 +0000
Message-ID: <f6f21e75-7cee-89da-bb87-95327a4ec2cc@huawei.com>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
 <CAMuHMdW7Xu6EzfmVFx1+i1byy3KOS5A+h2GuMb8nkZ+-jD1=BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdW7Xu6EzfmVFx1+i1byy3KOS5A+h2GuMb8nkZ+-jD1=BA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi Geert,

> 
> On Fri, Feb 28, 2020 at 4:23 PM John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
>> Currently ACPI firmware description for a SPI device does not have any
>> method to describe the data buswidth on the board.
>>
>> So even through the controller and device may support higher modes than
>> standard SPI, it cannot be assumed that the board does - as such, that
>> device is limited to standard SPI in such a circumstance.
>>
>> As a workaround, allow the controller driver supply buswidth override bits,
>> which are used inform the core code that the controller driver knows the
>> buswidth supported on that board for that device.
> 
> Just wondering: can't the controller just override this (e.g. in the .setuup()
> callback) without having to touch the generic code?

I think that this is a good idea.

However, where we call .setup() in spi_setup() looks a little too late - 
at the point we call .setup(), most of the work on vetting/fixing the 
mode bits is complete. And I would not want the SPI controller driver 
just to disregard this work and overwrite the bits (in this way).

And if we wanted to move the .setup callback earlier, then I would be 
worried here with 2 things:
1. Some SPI controller drivers may rely on spi->mode being set finally 
when .setup() is called
2. We may need to undo the work of .setup() if we later error in 
spi_setup(), like for invalid mode bits

However, maybe another callback could be introduced, .early_setup().

Thanks,
John
