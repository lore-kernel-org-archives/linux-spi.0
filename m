From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: altera: Add empty implementation of
 setup_transfer callback
Date: Thu, 9 Apr 2015 16:40:45 +0100
Message-ID: <20150409154045.GZ6023@sirena.org.uk>
References: <1428591822-24279-1-git-send-email-per.nilsson@xelmo.com>
 <1428591822-24279-2-git-send-email-per.nilsson@xelmo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eSxef1sC1lPl9rZw"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428591822-24279-2-git-send-email-per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--eSxef1sC1lPl9rZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 05:03:42PM +0200, Pelle Nilsson wrote:

> This callback is mandatory since txrx_bufs callback is defined. The lack of
> it causes a kernel panic on first SPI transaction.

Why is the callback mandatory if an empty implementation is OK?

--eSxef1sC1lPl9rZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJp18AAoJECTWi3JdVIfQltIH/2JCmNNJdBavugRiMUEJ7kFd
N3oWJ+o3sPidEtVxUAdsIYzEayHTHSG84XfjM7CY7tfwJNxZktNPqeFaJSiQE3kn
s1puZ2uF6ey8Tg+oYxtW6RWGXNgKmotqLk2o7f6MhrfnaQlnI2qiYfVB/pF57Lyt
Ewf4cRjcYcWLgagFvyn+kee84b2kDigtKql7yyTwN9VQASjFQv72BWPqVGP7ms9Y
BRrWo5JkhdUL8gegIEYGalgspIfXv08w0MVtpFEeEfD5KQjggPLYNQNV3+zV8R+F
WqhqeaFvYusFwfYfpf8uzmvrDwAjeeBOV2a+ym15q3G07AK2B/kXRrTla1350/4=
=8O43
-----END PGP SIGNATURE-----

--eSxef1sC1lPl9rZw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
