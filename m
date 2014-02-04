From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/5] spi: sunxi: Add Allwinner A31 SPI controller
 driver
Date: Tue, 4 Feb 2014 11:02:09 +0000
Message-ID: <20140204110209.GQ22609@sirena.org.uk>
References: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391165752-1819-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140131124809.GE22609@sirena.org.uk>
 <20140131224704.GI2950@lukather>
 <20140204002110.GP22609@sirena.org.uk>
 <20140204090926.GI25625@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pNTAM9ZU3uJ+Foyt"
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>,
	linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140204090926.GI25625@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pNTAM9ZU3uJ+Foyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 10:09:26AM +0100, Maxime Ripard wrote:
> On Tue, Feb 04, 2014 at 12:21:10AM +0000, Mark Brown wrote:

> > It isn't awesome, no.  Ideally the runtime PM code would do this but
> > then you couldn't ifdef the operations which as far as I can tell is the
> > main thing people want from disabling it and it gets complicated for
> > devices that genuinely do power up on startup so here we are.

> We discussed it with Kevin on IRC, and he suggested that we move that
> pm_runtime initialization to the SPI core, but I guess that would also
> mean that all drivers shouldn't ifdef the operations, so that the core
> can call the runtime_resume callback directly.

No, that's not going to be robust - it means drivers can't do any power
sequencing of their own.

> However, I don't really get why any driver should be doing so, since
> you still need these functions to at least to the device
> suspend/resume in the probe/remove, and you don't really want to
> duplicate the code.

I don't think it's particularly useful to support disabling runtime PM
in the first place but some drivers do different things when doing
runtime management to those they do on first init - for example there
may be additional steps that only need to be done during first power up.

--pNTAM9ZU3uJ+Foyt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8MitAAoJELSic+t+oim9xgkP/joV3euZEX/ko4Nk5pCOa1ZT
udQL6wL0FvY8Lmzipk6YfDjpP8lQg41nSGhT+9A1RXxM6iG6VTPFAUX8Ld/uTBRt
aM53x68YW7dRZydtW9fuw14zQ0bAGTQDds/3REM5fsAxYfyOy2mi+0OJnEho1DQK
sAtw51OVwz5KU0IQhgRTiuzPWYmoLyT6pJeDbWekkd5Q+ytl87e0jJYJniVCUW0F
/7p5eW/XdVyPdUnT13gh/5PQ/IepbIFQe6XF7OBHXPs9+T53lYKG2HW7mWrK8bp2
56rhxqelfPGXoUvLuVqsBpW5ZiDCIavQPsZ1VDoIhdMi3oPOv+sZy9euLszLadL+
3jCfrgmAUaYthERd2T7Q1oKUcjaOkkiTVGKULW2ejj1KfILdnMRmJdukeqIlmC0I
D/zcnqt02hgTN0BLccDp/vQUp0zdz0f9VNluURDpMirSXr7ZErsc2uK0+mVIqYIj
cCqo5f/+tATXtZAlFeXwR4lAKXdIY6RpAiHSiisAfE3mhb6sfFoKsSNG3zclVq4D
aEsgA19N1goiCbn0PLaCl9KPe6KtMmOyU9XzIXg/AypV9mMAh4syqAzz2R01bOrM
ht5AH80Z6AqOi6LYPMS9dgl7F0TaYlUFxSYNTBUWVf/KlxTCzRSFKy0QbQ7mNUN2
Ymxc+tDS62ugUFI1XQSF
=ExHT
-----END PGP SIGNATURE-----

--pNTAM9ZU3uJ+Foyt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
