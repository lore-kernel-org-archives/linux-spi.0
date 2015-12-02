From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: added spi_resource management
Date: Wed, 2 Dec 2015 08:30:51 +0100
Message-ID: <56C9120A-8979-4156-B3C4-5851D695BDF0@martin.sperl.org>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org> <1448888695-2260-2-git-send-email-kernel@martin.sperl.org> <20151201210410.GU1929@sirena.org.uk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151201210410.GU1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> On 01.12.2015, at 22:04, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
>> On Mon, Nov 30, 2015 at 01:04:52PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> 
>> +static struct spi_res *__spi_res_alloc(struct spi_device *spi,
>> +                       spi_res_release_t release,
>> +                       size_t size,
>> +                       gfp_t gfp)
> 
> This has exactly one (tiny) user.  Why is it a separate function?
Readability, mimicking devres code and the option of adding
object caching/reuse here later...
There is a much higher likelihood that spi_resources will be
allocated and then freed several times per second, so this
can save cpu cycles and avoid locks...

> 
>> +    sres = kzalloc(tot_size, gfp);
>> +    if (unlikely(!sres))
>> +        return NULL;
> 
> Don't use likely() or unlikely() annotations unless the code is *really*
> performance critical, just let the optimiser get on with things.  The
> annotations most likely cost more time in reading the code than they'll
> ever save.
Same code structure was used with devres, so I copied it.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
