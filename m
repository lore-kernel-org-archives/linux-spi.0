From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: m25p80: consider max_transfer_size when reading
Date: Mon, 6 Jun 2016 19:48:10 +0100
Message-ID: <20160606184810.GL7510@sirena.org.uk>
References: <20160606184348.GA135086@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O8/n5iBOhiUtMkxf"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160606184348.GA135086-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--O8/n5iBOhiUtMkxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 06, 2016 at 11:43:48AM -0700, Brian Norris wrote:

> message size / transfer size patterns for arbitrary users. I suppose we
> really just need to figure out what his actual problem is, so we can
> address it generically.

Yes, exactly.

--O8/n5iBOhiUtMkxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVcVpAAoJECTWi3JdVIfQfWYH+wQBW1H5I5ugEk5EwY+hbXv/
dZmzNGNEV2bUlidmWpixHiRFe49rRmWq+gxQwRQfykLyWlboZl4B6LlbadCL6D0H
019jJPFcQuDj3AVMMpZvpn7gryoG2SQJfaTo0sUCxyyTdPISfce7VfQZ8pXqO3yt
7QQLHP+1ndTbjzRdWuo3rv1meKheGR1YzN4JRoADg3DAuuP1S+9dViNFGfLagYH6
bZgHuUnhxicAT2cx555omj/fBAQRssxh0L/49Wze9vuJgbkIDQNcUnzOTawrSjFJ
2l+deaV0Itdn7COII3ZL7IpgZRu3evwHrPBc8KQ5/p0jsfxHUVO7T/biTukPKVU=
=NvL8
-----END PGP SIGNATURE-----

--O8/n5iBOhiUtMkxf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
