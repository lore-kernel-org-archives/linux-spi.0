From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Applied "spi: omap2-mcspi: Undo broken fix for dma transfer of
 vmalloced buffer" to the spi tree
Date: Fri, 13 May 2016 01:47:07 +0900
Message-ID: <CAC5umyj0Qn75aPvm50eMSL+wqWvquf9Z7gEV8PCbMnJwPSuccw@mail.gmail.com>
References: <1460140995-4062-1-git-send-email-akinobu.mita@gmail.com>
 <E1apndq-0002S5-8J@debutante> <CAC5umyg2fJxYKOB4J96+3igkNx+eJs5MET8S8NnafZ3hcPPEag@mail.gmail.com>
 <20160511162030.GN6261@sirena.org.uk> <CAC5umyjoKfMBbO1JPyTjqsz4zuiZMQDZcKHxonZuEwqGpJxb_g@mail.gmail.com>
 <20160512154436.GE6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160512154436.GE6261-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2016-05-13 0:44 GMT+09:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, May 12, 2016 at 10:49:15PM +0900, Akinobu Mita wrote:
>
>> If we have an optional callback to get the actual DMA transfer length
>> instead of using spi_transfer->len for each spi_transfer in the
>> framework, we can use it to determine the correct map size used by
>> spi_map_buf() in spi.c.
>
> That sounds plausible, we can also do some querying of the dmaengine at
> the same place we call that when we get around to that.  Can you try to
> come up with an implementation?

OK, I'll try and see how it looks like.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
