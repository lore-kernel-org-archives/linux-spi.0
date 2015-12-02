From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 08/10] spi: expose master transfer size limitation.
Date: Wed, 2 Dec 2015 10:55:16 +0100
Message-ID: <CAOMqctTbJVpxbGaRHhfNGfN6gVCZBQkiVRLe1Cm8LeGzwtamcQ@mail.gmail.com>
References: <cover.1448988089.git.hramrach@gmail.com> <8c34c7790244489c2ce0072c72bd9bc7c4cdb965.1448988089.git.hramrach@gmail.com>
 <20151201195816.GS1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151201195816.GS1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 1 December 2015 at 20:58, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Dec 01, 2015 at 04:51:06PM -0000, Michal Suchanek wrote:
>> On some SPI controllers it is not feasible to transfer arbitrary amount
>> of data at once.
>>
>> When the limit on transfer size is a few kilobytes at least it makes
>> sense to use the SPI hardware rather than reverting to gpio driver.
>
>> +     /*
>> +      * on some hardware transfer size may be constrained
>> +      * the limit may depend on device transfer settings
>> +      */
>> +     size_t (*max_transfer_size)(struct spi_device *spi);
>
> Heiner submitted a *very* similar patch just now with a straight
> variable plus accessor instead of a function and using a name with _msg.
> I'm ambivalent on the implementation but prefer the naming here since
> that's more the limitation we're trying to express I think (some
> hardware does have limiations about multple transfers too).  Can the two
> of you come up with something that works for both of you?

Sorry, missed there is a patch because it shows in the middle of the
discussion for me.

I don't really care which one it is so long as I can get the last
patch in this series based on it.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
