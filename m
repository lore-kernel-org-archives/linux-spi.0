From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: added spi_resource management
Date: Wed, 2 Dec 2015 14:04:24 +0100
Message-ID: <565EEC58.4040006@martin.sperl.org>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
 <1448888695-2260-2-git-send-email-kernel@martin.sperl.org>
 <20151201210410.GU1929@sirena.org.uk>
 <56C9120A-8979-4156-B3C4-5851D695BDF0@martin.sperl.org>
 <20151202122953.GG1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151202122953.GG1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02.12.2015 13:29, Mark Brown wrote:
> On Wed, Dec 02, 2015 at 08:30:51AM +0100, Martin Sperl wrote:
>
>>> This has exactly one (tiny) user.  Why is it a separate function?
>
>> Readability, mimicking devres code and the option of adding
>> object caching/reuse here later...
>
> This is *not* helping readability.
Originally it contained a bit more code to avoid repeated allocations,
which was cut out for the initial version of the patch.

>> There is a much higher likelihood that spi_resources will be
>> allocated and then freed several times per second, so this
>> can save cpu cycles and avoid locks...
>
> In what way does splitting this over two functions helping improve
> performance?  If there were multiple users or something perhaps but
> there don't appear to be.
>

It does not help performance per se, but it allows adding more
code in that location that would allow to reuse allocated objects.

As of now I will merge those 2 functions.

The bigger question (based on your comments to Patch 2/3) is:

Do you want to follow the devres approach (i.e: hiding
"struct spi_res" after allocation and returning "void *"
to the data-payload only in spi_res_alloc)?

Or do you prefer to have "struct spi_res" as an explicit member of
a structure (i.e. in Patch 2/3 "struct spi_res_replaced_transfers")?

I want to get this settled before submitting newer versions of the
other patches that address other concerns, because any changes to
spi_res design directly impact these other patches.

Thanks,
	Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
