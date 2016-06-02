From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [linux-sunxi] Re: [PATCH 5/5] RFC spi: sun4i: add DMA support
Date: Thu, 2 Jun 2016 14:14:26 +0200
Message-ID: <CAOMqctRMi8Zuwqvakka8LkgvecWVAfzUcER9+ui9WBYS78fWtQ@mail.gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com> <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk> <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk> <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
 <20160530155016.GO29837@sirena.org.uk> <20160601180056.GA4908@lukather> <1464842546.23881.3.camel@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464842546.23881.3.camel-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2 June 2016 at 06:42, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org> wrote:
> On Wed, 2016-06-01 at 20:00 +0200, Maxime Ripard wrote:
>> Hi,
>>
>> On Mon, May 30, 2016 at 04:50:16PM +0100, Mark Brown wrote:
>> >
>> > On Mon, May 30, 2016 at 05:28:10PM +0200, Michal Suchanek wrote:
>> > >
>> > > On 30 May 2016 at 17:03, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > >
>> > > >
>> > > > I really don't think it's worth caring too much about cases
>> > > > where the
>> > > > DMA driver hasn't been compiled in, it's not like SPI is the
>> > > > only thing
>> > >
>> > > It's what the driver did to start with and it was requested to
>> > > fall
>> > > back to non-DMA in the case DMA is not available.
>> > Why?  I really can't see any sensible use case for this that
>> > doesn't
>> > have a better solution available.
>> SPI works just fine without DMA, which might just be considered an
>> (optional) optimisation.
>>
>> We've been using it without DMA for years now, and it was working
>> just
>> fine, and it will work even better with the other patches in this
>> serie. There's no reason to add a hard dependency on something that
>> we
>> don't really need.
>>
>
> Actually it non-DMA case works fine if you don't need SPI transfers
> larger than SUN4I_FIFO_DEPTH - 1, which is 63 bytes.
>
> This was addressed by this patch, but was never applied:
> http://permalink.gmane.org/gmane.linux.kernel.spi.devel/18950

And the code added in that patch will never run unless you

1) use long spi transfers
2) compile in/load SPI without DMA support

There is no reason for doing 2) since we have do DMA support for sunxi.

So that's another code path that needs maintenance and testing and
likely will not get it.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
