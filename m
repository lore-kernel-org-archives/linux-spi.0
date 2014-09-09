From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: davinci: add support for adding delay between
 word's transmission
Date: Tue, 9 Sep 2014 17:55:55 +0100
Message-ID: <20140909165555.GD2601@sirena.org.uk>
References: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AHwfuuqjYixMHmQf"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410278851-10783-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--AHwfuuqjYixMHmQf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 07:07:31PM +0300, Grygorii Strashko wrote:

> - ti,spi-c2t-delay: Chip-select-active-to-transmit-start delay
> 	(SPIDELAY.C2TDELAY)

> - ti,spi-t2c-delay: Transmit-end-to-chip-select-inactive delay
> 	(SPIDELAY.T2CDELAY)

Now I look at these they look very much like the standard delay feature
that the SPI subsystem has already - are they?

--AHwfuuqjYixMHmQf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDzEaAAoJECTWi3JdVIfQcxsH/RWFMB9r3ZwsWsqISVqdMESh
fPVCt6Fhu1OLMzY3rYe75Tz7u8Q4AIHNocobXbe8fBbx/Wy4esNf//Zh82W9SpT/
Qz4smeQh2PIn3/QxYKlqoZhsRzL60377C306+nFd3dmDQEFlM/4YTRqLAiemQPeS
7wzCkjQxBkTeBR3ueghpyq84HJaZ0p0wv+Mu5E0KpE5AKRO7iTqwnmeS96fON+at
qryPh5biF1cMNXnY2nrRlGcfOotZCsN01buto3U0uN5wGd2cSPTrcBSgY779lmkI
NMST+Kcj//c5LTDGnQxyUfFjI++6YiRy4Nakzb7BKECvxL4MlgR7plUFxOFk9aU=
=961c
-----END PGP SIGNATURE-----

--AHwfuuqjYixMHmQf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
