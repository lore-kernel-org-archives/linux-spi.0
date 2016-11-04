From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/1] ARM: spi supports 32bytes buffer for DUAL and QUAD
Date: Fri, 4 Nov 2016 09:49:30 -0600
Message-ID: <20161104154930.6fepg25wma2l2gz2@sirena.org.uk>
References: <1478248734-32044-1-git-send-email-cm-hiep@jinso.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ejjqwutpjpvbq2in"
Cc: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
        ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org, h-inayoshi-HEF513clHfp3+QwDJ9on6Q@public.gmane.org
To: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1478248734-32044-1-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ejjqwutpjpvbq2in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2016 at 05:38:53PM +0900, Cao Minh Hiep wrote:
> From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>=20
> Hi,
>=20
> This patch will improve the DUAL and QUAD's performance of SPI,
> that supported for GEN2 r8a7790 SOC in PIO mode.=20
> It sends/receives each 32bytes of data instead of each byte data=20
> as current situation.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--ejjqwutpjpvbq2in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYHK4GAAoJECTWi3JdVIfQjy4H/idxpMwb3CKN0976NMcAiCRF
G7xWmCTPQIhBYe9JN1GyL59jIKM/at5hyM6AcnLUdY+xbOEXd8QLa9wkJCRUEKt+
GfNLwRcHL0Rz3UDxQ1SYdZZE2r1w+ELHDG8CG33AJi8te5F0px1YzcxpLjeZWSKv
a+W9dnKc/xn74WSKP8tCbkSLMMGd8UCatNTH11OgkN5N3Tshx+RTU9Tp+Ki7v/9x
3+LucSRtr5cL01vNMopI6r/cDpBAgwGgqMTlpgggAk7lYlrpJWlKqS64pSqtV4/y
rE4olzapfHWcAUy8vH+Q9k/+Sk7KoZiGxDFbZkMo2Q81crLl0KPr+qtYOhCqCrw=
=EDrK
-----END PGP SIGNATURE-----

--ejjqwutpjpvbq2in--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
