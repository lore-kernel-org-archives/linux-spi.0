From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Side effect of SPI GPIO descriptor usage
Date: Wed, 4 Dec 2019 15:15:43 +0000
Message-ID: <20191204151543.GV1998@sirena.org.uk>
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk>
 <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
 <20191203163521.GM1998@sirena.org.uk>
 <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5218009039338748058=="
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============5218009039338748058==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oAjj1ZwgLg4oRN9q"
Content-Disposition: inline


--oAjj1ZwgLg4oRN9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2019 at 03:46:56PM +0100, Linus Walleij wrote:

> and I can find one more outlier:

> drivers/mmc/host/mmc_spi.c, function mmc_spi_initsequence()

> This very clearly want the inverse polarity of whatever was the default,
> but the code assumes that SPI_CS_HIGH implies that this is the
> actual physical level and forces it high, then low. I will send
> a patch for this: what they want to achieve is the inverse of
> whatever was configured.

Yes, that's the first one I looked at when I was poking around
and I agree with that analysis.

> I am a bit sorry about the semantics of "HIGH" here when the right
> word should rather be "asserted": it's named like this for historical
> reasons.

There's quite a few things I'd do differently if I were designing
the API.

> An alternative would be to let SPI use gpiod_set_raw_value()
> to steamroll all the inversion semantics in the GPIO library,
> and SPI_CS_HIGH would literally mean to drive the physical
> line high.

> This may seem like an intuitively correct solution but
> it has implications for everything using device tree to define
> SPI clients: spi-cs-high in a device tree means that the
> CS is active high, which gpiolib currently detects and
> handles by way of disabling internal inversion (the default
> for SPI devices is active low). Previously the SPI core would
> set SPI_CS_HIGH and we would then just double-assign
> that in the SPI core and then again in some drivers, it doesn't
> seem much better to me.

Yeah, my general thought is that trying to do anything other than
making a new interface for this and actively deleting all the old
ones is probably just going to be pushing the problem around and
not actually any better.

> I could also additionally patch the whole kernel to rename
> SPI_CS_HIGH into SPI_CS_ASSERTED if this makes things
> better. (Would be a two-step patch rocket adding the additional
> define and switching everyone over before deleting the
> SPI_CS_HIGH.)

I think that's probably worth it mainly in the context of also
auditing all the users and possibly making a bigger change which
makes it harder for users to trigger problems.  That's a lot more
work though and needs more thought about what a better interface
would be.

--oAjj1ZwgLg4oRN9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3nzZ8ACgkQJNaLcl1U
h9Dzfwf/bpA6+7EWaEVCm94apDxJdxpI/9Mq6ANh+9+2NtoxQnn2bm7uiOPM8LLL
U4GqU5zR7wht6CcoTd7iU7Z2UO06dwUZdAJBLvvVPAJQO+AYaHhTuzoADN5NgrLy
BLeTydYtRuCZSUhF6mkClLtthjB9ecMA21FHwNS8sRGCWPqIEgvwSNxGWJqDKlIr
Tg3ElLH4pb0iXm1z0ElHewWoZiVjmvjmawrEiDQAEd9JbFjQWO4LmQEIF4nVYERQ
XRtpc3paFLbIyUjnmKzOFXgYaWrv0Eh4Q8nLi0GJ7SsCTgCV6XrN3EYOYRjVSM21
LQa7hSBaAG4qEeF3aGBoYlxsSVvkDg==
=foD7
-----END PGP SIGNATURE-----

--oAjj1ZwgLg4oRN9q--


--===============5218009039338748058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============5218009039338748058==--
