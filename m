From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC 0/2] spi: sh-msiof: Add DT DMA support on r8a7791
Date: Sat, 21 Jun 2014 11:21:01 +0100
Message-ID: <20140621102101.GN5099@sirena.org.uk>
References: <1403259638-13774-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6F8T1i0Ve2X0M5tc"
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403259638-13774-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6F8T1i0Ve2X0M5tc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2014 at 12:20:36PM +0200, Geert Uytterhoeven wrote:
> This preliminary patch series add DT support to the Renesas MSIOF SPI
> driver, and enables DMA support for MSIOF on r8a7791.

These look good, can you please resend when the dependencies are
resolved.

--6F8T1i0Ve2X0M5tc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpVyKAAoJELSic+t+oim9/McP+QFIc5DIignVH+qhtUu5R7jT
oEEQ12roY/cMEmEAH2QznRhVAzlp8Pfbc7tmTK5O8bWWLbJ/AKGugz8X0dokQwio
rz5gxuzdR0rX6T4aTkUL21Zr+6+wi1bsfD7ofueyTqy6GdI+zp1lpcyOH6OkMMxS
dfyX228QBYWwQYp+RwaSXP8xiszj2hoqNc35GN23yvDAhZGxuuAZbulskwGg5k3l
huhZB4FBkvNe+Qtj5+g/jKA7/xpxfqxJmq/NxHdRCwDH7oE1co+QfWEaPUdPyiC2
tRwQag1PueULmKRhakEAW9hJ9eb62x9iPuSNym/QRgCqt/YP6IncD6JZoHNcG0/J
5CjNdRDS0VlvKkOwll4WhM7hIMdRbTAxXjPJqDRAflzE0GAlul15x1efjjHYaW7N
ol2Ju8/j56M3W+x5l1elt4V5T7Jyt2wGGkE58BvEhufVcdHrj/yps7L57fSCfcUD
iSSoqMG1oKA4n3rI4LHoBqOaZ7dc8uAtt+i26LhasSZ8ThYfTPXP5aDmdVS3fjvw
GFp1RgYoDl7m7IAlI9bidGkX7ocVWJyggSKlmDOlPNhgJLSmYQfKtTXomMkOxSHt
7vyI6D5PVA+TBDzIMSLvP3kIyEf1yYSZZyok2Q09+irf35kr1WnzdMo3aQ1ctN/v
+kfkAQwh/6z5bl+AEi2Y
=ZjSn
-----END PGP SIGNATURE-----

--6F8T1i0Ve2X0M5tc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
