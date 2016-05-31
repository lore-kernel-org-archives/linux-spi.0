From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] RFC spi: sun4i: add DMA support
Date: Tue, 31 May 2016 16:19:28 +0200
Message-ID: <CAOMqctSWnbUaOveMUhz+yOJqTOK4EhDd5jUqKoHCohfndNAjWA@mail.gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com> <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk> <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk> <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
 <20160530155016.GO29837@sirena.org.uk> <CAOMqctQijjO2amwSmSMGp96KBRGrLb0fvXRwnybOEqvV3-HZ0g@mail.gmail.com>
 <20160531132706.GC29837@sirena.org.uk>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBGF3W25AKGQEBAJUVWQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160531132706.GC29837-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 31 May 2016 at 15:27, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, May 31, 2016 at 12:44:54PM +0200, Michal Suchanek wrote:
>> On 30 May 2016 at 17:50, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > On Mon, May 30, 2016 at 05:28:10PM +0200, Michal Suchanek wrote:
>
>> >> It's what the driver did to start with and it was requested to fall
>> >> back to non-DMA in the case DMA is not available.
>
>> > Why?  I really can't see any sensible use case for this that doesn't
>> > have a better solution available.
>
>> Of course, the solution is to compile in the DMA driver.
>
>> It's been argued that some drivers which use only short transfers will
>> just work.
>
> With nothing else in the system that needs DMA?  It's making the
> performance of the system less reliable for the benefit of a very narrow
> use case.

Some of the platform devices have dedicated DMA *controller* built
into the device IP so the DMA engine really is optional on many sunxi
devices. Besides SPI you definitely need the DMA engine for audio. You
probably don't need it for storage and graphics. I don't have any idea
if it's used for USB and Ethernet.

Thanks

Michal
