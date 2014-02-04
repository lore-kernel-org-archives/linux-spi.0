From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/5] spi: sunxi: Add Allwinner A31 SPI
 controller driver
Date: Tue, 4 Feb 2014 00:21:10 +0000
Message-ID: <20140204002110.GP22609@sirena.org.uk>
References: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391165752-1819-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140131124809.GE22609@sirena.org.uk>
 <20140131224704.GI2950@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4xvrXxpSOutbQOB9"
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBBXFYCLQKGQEGU5AMNA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140131224704.GI2950@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--4xvrXxpSOutbQOB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 11:47:04PM +0100, Maxime Ripard wrote:
> On Fri, Jan 31, 2014 at 12:48:09PM +0000, Mark Brown wrote:
> > On Fri, Jan 31, 2014 at 11:55:50AM +0100, Maxime Ripard wrote:

> > > +	pm_runtime_enable(&pdev->dev);
> > > +	if (!pm_runtime_enabled(&pdev->dev)) {
> > > +		ret = sun6i_spi_runtime_resume(&pdev->dev);
> > > +		if (ret) {
> > > +			dev_err(&pdev->dev, "Couldn't resume the device\n");
> > > +			return ret;
> > > +		}
> > > +	}

> > No, as discussed don't do this - notice how other drivers aren't written
> > this way either.  Like I said leave the device powered on startup and
> > then let it be idled by runtime PM.

> Well, some SPI drivers are actually written like that (all the tegra

It's not been done consistently, no - that should be fixed.

> SPI drivers for example). It's not an excuse, but waking up the device
> only to put it back in suspend right away seems kind of

It isn't awesome, no.  Ideally the runtime PM code would do this but
then you couldn't ifdef the operations which as far as I can tell is the
main thing people want from disabling it and it gets complicated for
devices that genuinely do power up on startup so here we are.

> inefficient. Plus, the pm_runtime_idle callback you suggested are
> actually calling runtime_idle, while we want to call runtime_suspend.

Yeah, I didn't actually check if I was looking at the right call there.

--4xvrXxpSOutbQOB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8DJyAAoJELSic+t+oim9sG0P/2nOyF7gVt73C5f6UGLn9sUC
rUbhIwsFP8Id9mnbIXQ0DaF1aPw3wuwlIt1JB393+syeO6z3MlozdTySZTp3DdYw
U1AJ82s7dKC6rGgK2IF2gi/QV0P8zqf0MiUWQlGbJ1Bv37LOX2X0Et2Je7uXgyph
jRndtefN/VGYKCB82xs68Cp8q/UDzCJdoqT4RyslliBo4O3OY4LhlZkQfn4KQhfY
Nll8TVuXs7+MR4MoCIfwqmYrvjYMJ1etqHZYotSSf5QSmMhBQ6lLDtmKa3rGaKGS
VnCyYmY0DZsWoNF8UX/etfDyaJKHMd6twR7OVf/uORRlnS94fdFR2MRZ8Y1Y7rXQ
zimm3sb4p5hCwmtZeIFKZJYgEnxqNTuNiBpXBGIHHYrYQrmLhSUU2WqnkzQOzBFD
89eQWWCBKMukBPsqwTrQa0TWsppiq+tYtRHX/TA7x1rzxyEgp3k8ZIpj2ptGeDpK
rCZ/cvnqxa6OHv69knY1NSGwtIlmUID7Uu6AAvAHzAoMtNkTlaBxjInQFRkbFF9R
5MuRxoDJj9jDh0AHw/MAFAJtfUCMU8iu3LrAN6VrT2blTJ6YC/TRUx/lazTFcyTN
QB/UL23bBP6N1l05yCf3/1bI8SW9GNmKfPdiI6i6tbTxD3RbyU/55wGQX4C9MM/y
4xMLaTZIbUPcOdpsjPQK
=CUIv
-----END PGP SIGNATURE-----

--4xvrXxpSOutbQOB9--
