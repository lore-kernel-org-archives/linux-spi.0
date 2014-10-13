From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Use separate TX and RX bounce buffers
Date: Mon, 13 Oct 2014 13:07:26 +0200
Message-ID: <20141013110726.GT27755@sirena.org.uk>
References: <rjui@broadcom.com>
 <1412878765-29088-1-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80FmgzPrdF8O9k7o"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	JD Zheng <jdzheng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412878765-29088-1-git-send-email-rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--80FmgzPrdF8O9k7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2014 at 11:19:25AM -0700, Ray Jui wrote:
> By using separate TX and RX bounce buffers, we avoid potential cache
> flush and invalidation sequence issue that may be encountered when a
> single bounce buffer is shared between TX and RX

Applied, thanks.

--80FmgzPrdF8O9k7o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO7JtAAoJECTWi3JdVIfQczgH/33EOoph6nnr17oswSdKgMe0
V1ToWcU3XovTDlHV0uVcZqfpdOAMzXfcz4xd5gB2si2rrVfDlDwgYVyVgGG41FJo
m8nVSg43dBwcKmf07se2gF2JHRQeZShDktoD/1pIrHWmBhZj7ZXxw/lrVZ1kEh/7
f4MgJPC8CVuQ7kWMr3vO18fY4ZLhySD5Lj4NYysl0euxhzzc22xFxxDyXD4LJeMz
n/bYmW+aNg5OVpHoxfYg27W0TGmLcUscmJDTqELFS6+XaBqq7kQhUXOT7h4pHQpL
2QBu80OMCf89MfUBg7E4e75kttQ47azCxHHWTXEh3sQBrA7gKfAWsi3B0GF7orE=
=rRC8
-----END PGP SIGNATURE-----

--80FmgzPrdF8O9k7o--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
