From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH 5/5] RFC spi: sun4i: add DMA support
Date: Mon, 6 Jun 2016 12:36:00 +0100
Message-ID: <20160606113600.GB7510@sirena.org.uk>
References: <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk>
 <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
 <20160530155016.GO29837@sirena.org.uk>
 <20160601180056.GA4908@lukather>
 <1464842546.23881.3.camel@plaes.org>
 <CAOMqctRMi8Zuwqvakka8LkgvecWVAfzUcER9+ui9WBYS78fWtQ@mail.gmail.com>
 <20160602142649.GJ2282@sirena.org.uk>
 <CAOMqctQwFif=yFF1snfZJc7+sGS7wcC-6oNTCfjW_MSUWHw+xQ@mail.gmail.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Cc: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBLWB2W5AKGQEL4JCPJY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAOMqctQwFif=yFF1snfZJc7+sGS7wcC-6oNTCfjW_MSUWHw+xQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sun, Jun 05, 2016 at 01:27:11PM +0200, Michal Suchanek wrote:
> On 2 June 2016 at 16:26, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Thu, Jun 02, 2016 at 02:14:26PM +0200, Michal Suchanek wrote:

> >> And the code added in that patch will never run unless you

> >> 1) use long spi transfers
> >> 2) compile in/load SPI without DMA support

> >> There is no reason for doing 2) since we have do DMA support for sunxi.

> > Well, presumably such code exists and is being worked on?

> Which code are you referring to?

> This is a reply to patch which adds DMA support to the SPI driver so
> that it can work for arbitrarily long transfers.

It sounded like there might be a missing DMA driver?  Though I think I
was misreading the above.

> > Oh, come on.  You might not want to use it yourself but the chances are
> > that someone will want to use it just like the situation with all the
> > other SPI drivers.  It's a perfectly reasonable and sensible feature to
> > support upstream.

> Is it?

> Once we have *one* driver that works for arbitrarily long transfers
> and it works out of the box with the board defconfig 99% of people who
> will use the SPI driver for anything will use this driver. Any other
> variant will go untested.

We don't want multiple drivers for this and general maintainability
reasons, I'm not sure where the idea that we might want multiple drivers
came from?

> And for the driver to also work without DMA you have to *tell* it to
> probe without DMA because it cannot know you are not going to load a
> DMA driver later.

Yes.  This puts the cost on the special snowflake systems that
absolutely cannot have any DMA support in their systems for some reason
while keeping the driver featureful by default, and keeps that cost
fairly small.

> > I really do not understand why there is such a strong desire to have
> > these devices be a special snowflake here, the worst that's likely to
> > happen here is that you're going to end up having to either remove the
> > DMA controller from the DT or load the driver for it neither of which
> > seem like the end of the world.

> Why would you do that?

Like I say I really don't understand why this is.  I'm just saying there
are ways to do this fairly simply if people really want it on their
systems.
--Bn2rw/3z4jIqBvZU--
