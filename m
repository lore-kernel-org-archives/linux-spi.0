From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi/pxa2xx: fix incorrect SW mode chipselect setting
 for BayTrail LPSS SPI
Date: Tue, 17 Jun 2014 15:46:04 +0100
Message-ID: <20140617144604.GW5099@sirena.org.uk>
References: <1402675045-22460-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T06BQBHjKAm4eKdv"
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402675045-22460-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--T06BQBHjKAm4eKdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2014 at 11:57:25PM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> It was observed that after module removal followed by insertion,
> the SW mode chipselect is not properly set. Thus causing transfer
> failure due to incorrect CS toggling.

Applied, thanks.

--T06BQBHjKAm4eKdv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToFSpAAoJELSic+t+oim9S3EP/j2zdrpytsWPnlPw6umZOjtg
ZIlLVBN6obMRSy3EBtIfxHTA+omTtM03GXPCY1rdVbhNiA+PksCvj0ijL7Lv3Cil
1fJTYfCdvdbvuK7CvaUCRDqLLL9tPX8pbBEoe5o4UeRWKM9AG3qeqbGbFOGTCDVr
7HL4/6usn/xhHevdivLpD1vlR9zF0IKHuN7YRempm08vEDH5nL3Ren4E16tbECnh
bjUMtoCuy2V0pAfdNQMoGjcfw/zDiHyTYpkn0iwR46wOpuhyozlTIWftNT92X1d8
+Zsp1GjEwDBm4py6BkUAVq8KVxk0QKU6YMB4F3ij3euKD6Yqgk3ohOjxPVXBVPau
Ol7qc64+RQmM013d3iO6cVKHaJktRy8X7FSkGNq1pOF6Z48NCfKremz43ErB0QjA
RiAj/9E+ZJRLYonhk4QDCm56iVeYaPrPf2L8TchIwcwJM8uNc3nZef6a/RkFVfa3
ymziccSh7ibPkukhndnUeQgUXOVpQx2AVmLnCqfyn1U2nVwfRkDmyywYdae3nLq8
WouWCDL8HsCmt6w4LUuBWLck8QaRRRwMIhCtjm93GSucb65b5lxwC630bYJNoDXB
ACLxnoH1X3HYUL47+8EJUqj4nWNpbl1xU4klQoUxozMmFdrQt21cdO1Rsk9xKtjo
e9lMlXYlwRtyzZ6qDeLj
=FBcD
-----END PGP SIGNATURE-----

--T06BQBHjKAm4eKdv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
