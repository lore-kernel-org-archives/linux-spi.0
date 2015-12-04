From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 08/10] spi: expose master transfer size limitation.
Date: Fri, 4 Dec 2015 17:45:28 +0100
Message-ID: <CAOMqctRVT9vLOgePJ_NzTdt-gTWA8cfUJ9CRtH9BmLSZ5qk=0A@mail.gmail.com>
References: <cover.1448988089.git.hramrach@gmail.com> <8c34c7790244489c2ce0072c72bd9bc7c4cdb965.1448988089.git.hramrach@gmail.com>
 <20151201231233.GA1929@sirena.org.uk> <5FC39638-EEE0-4CFA-B464-0B4743CB6AB6@sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	=?UTF-8?B?QmVhbiBIdW8g6ZyN5paM5paM?= <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	Furquan Shaikh <furquan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5FC39638-EEE0-4CFA-B464-0B4743CB6AB6-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 4 December 2015 at 15:30, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org> wrote:
>
>> On 02.12.2015, at 00:12, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>
>> On Tue, Dec 01, 2015 at 04:51:06PM -0000, Michal Suchanek wrote:
>>
>>> +static inline size_t
>>> +spi_max_transfer_size(struct spi_device *spi)
>>> +{
>>> +    struct spi_master *master = spi->master;
>>> +    if (!master->max_transfer_size)
>>> +            return 0;
>>> +    return master->max_transfer_size(spi);
>>> +}
>>
>> Can we change this to return SIZE_MAX instead (ie, the maximum value for
>> a size_t)?  That way callers don't need to worry if there is a limit, if
>> they want to handle it they can just unconditionally assume that a limit
>> will be provided.
>
> As I just came across: spi_master.max_dma_len, so I wonder how this
> value would differ from the proposed spi_master.max_transfer_size
> on specific HW?
>
> For all practical purposes I would assume both are identical.

They aren't.

Some SPI masters don't use DMA. Some SPI master drivers can drive CS
manually so they can glue multiple DMA (or whatever) transfers into
single logical SPI transfer transparently. And some cannot. Hence this
limit.

That said I don't know what is the purpose of spi_master.max_dma_len.
It is seldom used. It seems to be used as a hint for the DMA buffer
size in spi.c only.

It is set in 3 drivers.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
