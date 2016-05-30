From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] RFC spi: sun4i: add DMA support
Date: Mon, 30 May 2016 17:28:10 +0200
Message-ID: <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com> <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk> <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBMVYWG5AKGQEYLHW5VA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160530150343.GL29837-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hello,

On 30 May 2016 at 17:03, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, May 30, 2016 at 02:11:51PM +0200, Geert Uytterhoeven wrote:
>> On Mon, May 30, 2016 at 1:26 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > On Thu, May 26, 2016 at 07:25:25PM -0000, Michal Suchanek wrote:
>> >>  - fallback to previous behaviour when DMA initialization fails
>> >>
>> >>    + this has the problem that when the driver happens to load before the dma
>> >>      driver it will not use dma - can be addressed with a module parameter
>
>> > No, you should pay attention to the error you are getting and let probe
>> > deferral happen if that's the error you get.
>
>> Unfortunately DMA is an optional feature.
>
>> There's no way to distinguish between -EPROBE_DEFER due to the SPI master
>> driver being probed before the DMA engine driver, and -EPROBE_DEFER due to
>> support for the DMA engine not having been compiled in.
>
> I really don't think it's worth caring too much about cases where the
> DMA driver hasn't been compiled in, it's not like SPI is the only thing
> that's going to be using it.  I really think it's better to defer the
> problem - not getting DMA (or worse, only getting DMA on some boots) is
> not great and if people are optimising on that level my feeling is that
> they're probably going to be OK with customizing DT to match.  Ideally
> we would have something a bit nicer than deferred probe but right now
> this seems the more helpful option.

It's what the driver did to start with and it was requested to fall
back to non-DMA in the case DMA is not available.

We get to the much discussed problem that it's never possible to tell
if a driver is available or not.

It's possible to add a parameter like require_dma which could be used
to load the driver without dma if unset. If it was set by default then
driver ordering is not important so long as dma driver is loaded
eventually. Also an informative print that such parameter exists when
probing the driver is deferred would be helpful. It would probably
create quite a bit of log spam, however. The driver can be deferred
several times during boot.

Thanks

Michal
