From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/atmel: add support for runtime PM
Date: Fri, 17 Oct 2014 16:31:18 +0200
Message-ID: <20141017143118.GW1820@sirena.org.uk>
References: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
 <7hk33yhms4.fsf@deeprootsystems.com>
 <20141017135716.GS1820@sirena.org.uk>
 <7hd29qhj3i.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5KENZRfAmuo1v8rU"
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7hd29qhj3i.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5KENZRfAmuo1v8rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2014 at 07:22:09AM -0700, Kevin Hilman wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
> > On Fri, Oct 17, 2014 at 06:02:35AM -0700, Kevin Hilman wrote:
> >> Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:

> >> > +	if (!pm_runtime_suspended(dev)) {
> >> > +		clk_disable_unprepare(as->clk);
> >> > +		pinctrl_pm_select_sleep_state(dev);
> >> > +	}

> >> a.k.a. pm_runtime_put_sync() since the ->runtime_suspend() callback does
> >> the same thing.

> > Will that do the right thing when runtime PM is disabled in Kconfig?

> Good point.

> Then the way to make this cleaner, and obvious on inspection that system
> suspend/resume are doing the same thing as runtime suspend/resume is to
> have ->suspend call the runtime_suspend function.

> The runtime suspend/resume functions then should be wrapped in CONFIG_PM
> instead of CONFIG_PM_RUNTIME.

That sounds reasonable, yes.  I keep on wishing we didn't have so much
configurability in the PM :/

--5KENZRfAmuo1v8rU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQSg2AAoJECTWi3JdVIfQgQ8H/3enb5+hhx5DglTBT4P1B1ao
WD0HhPTvdG8DpVZl1TyfBq6Zi+mstvO/o0wsIL52C8ssx8cIVZuCWzYS4/ogRAtx
NAXffYiIriEL0uTgsTOZsAFmmm25bF9eggwu9G0ZXhmNl47l8oRRrs9etGkLsQG/
f85rDgtvkp8M8iBB6s5EeGsn0CcspiJi8DB8xYE2Qb5zp5p/fWXLCASIm9m0O/OY
7XJyNXvgrCO6s8qvQZURZk1g+OxlqeGm4sNvBv/CdEk4QQRUkI4ryNKfNc4R/Fqv
QLRQw0fF5ta62LZp49xtzgUuWBQ20ApgXexBsH+ZkWT80s4uBL81j+P87AOu30Q=
=eO2V
-----END PGP SIGNATURE-----

--5KENZRfAmuo1v8rU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
