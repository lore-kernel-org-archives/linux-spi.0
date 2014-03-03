From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: Let spi core handle validating transfer
 length
Date: Mon, 3 Mar 2014 12:01:45 +0800
Message-ID: <20140303040145.GH2411@sirena.org.uk>
References: <1393329439.6723.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/6pUCPTUcpTjDznW"
Cc: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393329439.6723.6.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/6pUCPTUcpTjDznW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2014 at 07:57:19PM +0800, Axel Lin wrote:
> spi core will handle validating transfer length since commit 4d94bd21b333
> "spi: core: Validate length of the transfers in message".
> So remove the same checking in this driver.

Applied, thanks.

--/6pUCPTUcpTjDznW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE/6lAAoJELSic+t+oim9zO4P/RdXsvbhpinBuh25h0PI8LMQ
05XoNBUJ7IwqJyYlCq9UHZJv53avJm4Fm1J6snzHPRQXg3peHrk/5MKaxnj/buUa
C/xCGtDL12otbro/XEdqPrTzC294P3gEVYHRg88obqPKgVgmX4wF5b1oTlQssDqe
tNPPje8rlue2Un+vfsDT8Rmlv1ROeizvst47xoQAm0dryee7QhjAGxon6ZnwE63f
V5mfnDNIkzQ9TJCJoQCOdynPkgRxJiHhy/1c+ZkOvuOuettYpeFi0T3e+Nq+bT6Y
tJ9OXhZKXXL7bTZFuEj+MQK+jkC2KXC/nLaooPZrmH+GfDyeY0CD2q67BGQuVRp0
esArogvg9qmOyV2heB+ulhwGn4R4Hnspx0TpofQA31AxGSBIrHdmnomjeKu1XPZR
73i6LJOgT+6oF/5pxuvUl+QzKByNUJO4mQ2L01SPwBXAYGRqUew5c62gzlGi/wk+
+9YVQ7S6LJg9SMsyG/+JEvIGKFDIDXJ6R6CZjqD4YpR9AK+nuMy7ZTbfUJF3gEG4
u69PGuaKvJcGj1+Csy2c2IIOyowKwfN1rAMSgRuBkDzZMLrJwEMt0CYX9YLn5Bs9
TdGmdJ4kYl6LT0cycNxPFFYSd1fDpc4rZ8Ct/M5NspD0U0GtIf1420vBihAJazBQ
YENQy2AbHNKIrF3aOEKo
=LbZj
-----END PGP SIGNATURE-----

--/6pUCPTUcpTjDznW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
