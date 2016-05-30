From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] RFC spi: sun4i: add DMA support
Date: Mon, 30 May 2016 16:03:43 +0100
Message-ID: <20160530150343.GL29837@sirena.org.uk>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBXVMWG5AKGQE454MAYA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org


--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, May 30, 2016 at 02:11:51PM +0200, Geert Uytterhoeven wrote:
> On Mon, May 30, 2016 at 1:26 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Thu, May 26, 2016 at 07:25:25PM -0000, Michal Suchanek wrote:
> >>  - fallback to previous behaviour when DMA initialization fails
> >>
> >>    + this has the problem that when the driver happens to load before the dma
> >>      driver it will not use dma - can be addressed with a module parameter

> > No, you should pay attention to the error you are getting and let probe
> > deferral happen if that's the error you get.

> Unfortunately DMA is an optional feature.

> There's no way to distinguish between -EPROBE_DEFER due to the SPI master
> driver being probed before the DMA engine driver, and -EPROBE_DEFER due to
> support for the DMA engine not having been compiled in.

I really don't think it's worth caring too much about cases where the
DMA driver hasn't been compiled in, it's not like SPI is the only thing
that's going to be using it.  I really think it's better to defer the
problem - not getting DMA (or worse, only getting DMA on some boots) is
not great and if people are optimising on that level my feeling is that
they're probably going to be OK with customizing DT to match.  Ideally
we would have something a bit nicer than deferred probe but right now
this seems the more helpful option.
--Qgd2S+2VS1hsWwXW--
