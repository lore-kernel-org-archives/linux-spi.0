From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 4/8] mtd: m25p80: Let m25p80_read() fallback to spi
 transfer
Date: Thu, 4 Aug 2016 22:07:47 +0100
Message-ID: <20160804210747.GN10383@sirena.org.uk>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-5-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BHMq0+oGliEfCAkH"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vigneshr-l0cyMroinI0@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469830393-13295-5-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BHMq0+oGliEfCAkH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 29, 2016 at 06:13:09PM -0400, Kamal Dasu wrote:
> In m25p80_read() even though spi_flash_read() is supported
> by some drivers, under certain circumstances like unaligned
> buffer, address or address range limitations on certain SoCs
> let it fallback to core spi reads. Such drivers are expected
> to return -EAGAIN so that the m25p80_read() uses standard
> spi transfer.

You need to send this to the MTD maintainers, I see you've CCed the list
but not Brian and any comaintainers he has AFAICT.

--BHMq0+oGliEfCAkH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXo66iAAoJECTWi3JdVIfQ7e0H/1YN54yTzY0FzVXL4YZI2kU1
K0pS+1xT3YiD6dG5U7i97KS9BqBJpwd1geLL0Q1ZBnPti/e9/+JNEOQD1LPE8xhH
5S/OAbUKwzuMWErXpAZroneEWR/NFqnigkj+kY7ivuc36DDFNe2+CRjsTuJFLyk7
t1O6mJEnQvwiMaNEjrCeGt3ySCF4Ekl6paOvqZNDNTEMrw7CLmvrUOkPFmkTXq8a
36qWzOFtEu0/fZTVyLCPLBA0NUG1ZNg9CcbEkD1/K0LSALx3xwUzuuK7qHR2u21x
/zM28rxxQnmtnQFzyCTf9M1CXH/I35gaDRSZL/VAK8o1KZO7KhgxE297Fj4NQMU=
=IcZO
-----END PGP SIGNATURE-----

--BHMq0+oGliEfCAkH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
