From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: Constify ACPI device ids
Date: Mon, 15 Jun 2015 10:53:44 +0100
Message-ID: <20150615095344.GE18309@sirena.org.uk>
References: <1434198134-8278-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Mathias Krause <minipli-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434198134-8278-1-git-send-email-minipli-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 13, 2015 at 02:22:14PM +0200, Mathias Krause wrote:
> Constify the ACPI device ID array, it doesn't need to be writable at
> runtime.

Applied, please do make an effort to CC relevant people working on the
code when contributing patches (I'm not seeing any of the people working
on the Intel platforms here and I'm at a bit of a loss why Rafael and
Len are in the CCs).

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfqCnAAoJECTWi3JdVIfQkrsH/iZ4WiACCSQh3twjWaf5OZY6
GoD5O3lASaUX9n6+m4VYnSmKpi/aw4VIcEDObMVpj2PF4m13OjzzL5vzGnelibna
cBP6/IGxHpAimY4tSyupPaphTgYsmRAzjSlZmAzxi8u8AHQ8psgibHE3Q/CnvtgC
+eIWaXOFPwvGKGRvfU/2NClmQ6FhoPPw54K2Uhu+J6Ji2xjkm4ZkyM5Ue1ntjn1g
m5LzBc9HkdP6/LdRNKlziwdOJu6Ic3MfaKSjiNtsgVaXF3AEoZRsr7jAZ5wSnd6P
FzKl1MQr5s5qBFB20fANrLR9CCuwAlq33NVTL1GFpCeE0Tl/slMxmADFdbyWrl4=
=xkEN
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
