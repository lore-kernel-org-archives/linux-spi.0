From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4 RESEND v2] spi: s3c64xx: clean up runtime PM if
 driver registration fails
Date: Mon, 14 Sep 2015 18:58:05 +0100
Message-ID: <20150914175805.GZ12027@sirena.org.uk>
References: <55E8AFD6.2030107@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RJctCcHBI8aUAyUP"
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55E8AFD6.2030107-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RJctCcHBI8aUAyUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 03, 2015 at 10:38:46PM +0200, Heiner Kallweit wrote:

> Fix missing runtime PM cleanup if driver registration fails.

Applied all, but please don't put noise like RESEND in the subject lines
especially if it's not actually a resend :(

--RJctCcHBI8aUAyUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9wqsAAoJECTWi3JdVIfQnYcH+gMZtQjooDPaOR0hNt66URcR
1Awud03FcaYOlC+GMxBILD1wiDxPKNMjCB7wtJjjUhzAdXpH7dw337NA5gcxy94V
EtzdXUToajAAvm01oBJEMZcAfsfrX+ZEHq+UpSNks3VUB014AKDR5WcAMC4Jm4kf
YzY3uPOa3+Y8nAMyNrzlp2zMeZnSscd+zHKxIQAMogrY5F6feCC0N25IvtLqoW0J
85HepwUKk+HEZBTUahsNlallTv8a3UwAwFcAuLAMlyRlh+7FpeU9YKawohIIthQY
ftaS+FhRj33nyzrqmi4e7d63PfEm3+BnDlhcrNI6taT3zwEv9FGZ83ONaE+MGks=
=pwEo
-----END PGP SIGNATURE-----

--RJctCcHBI8aUAyUP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
