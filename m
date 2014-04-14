From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/5] spi: sirf: make GPIO chipselect function work well
Date: Mon, 14 Apr 2014 21:03:45 +0100
Message-ID: <20140414200345.GV25182@sirena.org.uk>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-4-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MUnXZt0Uv08c1hBe"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397457001-5266-4-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MUnXZt0Uv08c1hBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2014 at 02:29:59PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> orignal GPIO chipslect is not standard because it don't take care to the
> chipselect signal: BITBANG_CS_ACTIVE and BITBANG_CS_INACTIVE.

Applied, thanks.

--MUnXZt0Uv08c1hBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTD8dAAoJELSic+t+oim9870QAJhvr04NC5bLrMx494scd2ZJ
6HyuZGI+XQ+WeSA4Ifc+GeaGNYc7oKni6ZSZfz5VxlI5HMUglLgClA9FwNWUp/iO
ehjEMVaoYWdWz88EgvzW6wyL4OO01FjsGkrxOKpYeMtpMcBETQE7k6AqcI8J93Cp
9SJ6LMDjJkaSD2wZLbwsvR3zQCmySBlzC0dbG9a3BOYu4MsAM1GGt1AiUXx45dt0
rWz2f1e4Wg9Za0mg/Igr35hktxRm+M1XYHgfZ1H9jbbSWaCHriYUWRk7WQrbPBqz
tsUoSyfq68ffjKBGkFVcYL10wo4lCWsBnOA4wfRky8bwuBFyM/vOop5Z7W0RHAZ7
hePu+7elgA4BY1z1e0D/Kj2rzumDrAAGmko2pTAkqxnk+kuZUkXlKuS5feivAm0A
sMrdW2q/swbhWmCvKINQ2e349Zfaok/VrQ4cjRVC5t42o9qJecq+U2+hYxQ5qQ2A
RColN5iMTSPEFURDTIa/moz8HkUk9yhJd0ieADOOX+94+UJq+A/UHhIwe/9C75bd
PLuHgJn3AgmZs5LGjTVpPH/zsZqzGxqDRAERTrR5oD5SLlnJJVer2X53e+qJSKuH
RAz8UJlyxy911JIe21kIJirNP6IBtPrUnCkxgS57Mx83mxHAoisIL4+WbFrOeZaM
aXmcWuP9aY2iac9a+z9x
=AHA3
-----END PGP SIGNATURE-----

--MUnXZt0Uv08c1hBe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
