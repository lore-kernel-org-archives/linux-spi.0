From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: Re: Re: [PATCH 5/5] RFC spi: sun4i: add DMA support
Date: Thu, 02 Jun 2016 07:42:26 +0300
Message-ID: <1464842546.23881.3.camel@plaes.org>
References: <cover.1464130597.git.hramrach@gmail.com>
	 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
	 <20160530112610.GJ29837@sirena.org.uk>
	 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
	 <20160530150343.GL29837@sirena.org.uk>
	 <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
	 <20160530155016.GO29837@sirena.org.uk> <20160601180056.GA4908@lukather>
Reply-To: plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven
 <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Chen-Yu
 Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
 <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
 <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBDJLTBEBXENBBM7SX25AKGQEUXKPTGY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160601180056.GA4908@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On Wed, 2016-06-01 at 20:00 +0200, Maxime Ripard wrote:
> Hi,
>=20
> On Mon, May 30, 2016 at 04:50:16PM +0100, Mark Brown wrote:
> >=20
> > On Mon, May 30, 2016 at 05:28:10PM +0200, Michal Suchanek wrote:
> > >=20
> > > On 30 May 2016 at 17:03, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > >=20
> > > >=20
> > > > I really don't think it's worth caring too much about cases
> > > > where the
> > > > DMA driver hasn't been compiled in, it's not like SPI is the
> > > > only thing
> > >=20
> > > It's what the driver did to start with and it was requested to
> > > fall
> > > back to non-DMA in the case DMA is not available.
> > Why?=C2=A0=C2=A0I really can't see any sensible use case for this that
> > doesn't
> > have a better solution available.
> SPI works just fine without DMA, which might just be considered an
> (optional) optimisation.
>=20
> We've been using it without DMA for years now, and it was working
> just
> fine, and it will work even better with the other patches in this
> serie. There's no reason to add a hard dependency on something that
> we
> don't really need.
>=20

Actually it non-DMA case works fine if you don't need SPI transfers
larger than=C2=A0SUN4I_FIFO_DEPTH - 1, which is 63 bytes.

This was addressed by this patch, but was never applied:
http://permalink.gmane.org/gmane.linux.kernel.spi.devel/18950

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
