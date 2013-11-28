From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx: Restore private register bits.
Date: Thu, 28 Nov 2013 11:22:35 +0000
Message-ID: <20131128112235.GA27568@sirena.org.uk>
References: <1385662391-27573-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385662391-27573-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2013 at 02:13:11AM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> The Intel LPSS SPI private register bits have to be restored
> when system resume from S3 suspend.

Applied, thanks.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlyd4AAoJELSic+t+oim9slMQAIw7FQ288zfP6Md+WEf8tUl8
JpLjW5rpwQ1OgHgTPAuVCDNCjRjpTHo6e1FpQLMevpJqf4ASK8dxm8TmTA4WnVq9
0sQNrIMcnJmkIrdfvyhGiil55YOeA6BcH3t55Y/tCyRvtjgPHpyRpDM2nCAmsyLV
8GpxaODp5XzimNE5NuuCqClvwpdKDPTFaQL4RTkx1wvMfKc2EL87IYYIE2CEyjR4
7Ubp/uDBDlwQ3mZj0ouNPGcB5EL+SmrWVf3ygvDGTm6UrGzND4moGn4iyNTXLfih
u532UM0Qt/KMhIq7w0AGPWkd3kexKtX7JwStsWTkv524rvr32D6nemrsKK3uDZ/W
dv7dmUSRAsE5/KRuMM+hwiR6zJI19cKxd43liurY+HMHmcASL+OfAN+Vw4veJYKF
kLbKGDpPJ9dYkTEBX1r0IQfMvtPOJXV3bFs4Pm34HIsbVcLC6Y2Dg8iVdGLX130O
oK3oYkTcsaHcnbc9VXDlH3qsQAPcFgZKRLMeZjJkhiJ9dQsMhGX7cwhHfU/8ZWFR
P2mEBp1GRjMWDn5eMlBO1fd9Qvbq/rSYbH3uif2CQHUft+3KyKKV7CjOkNPq2Bqp
3W+BXC+TcYt60oMZudIToKjcPZxD5xT9UE0R/RpMDeInYR9Laa8vxkm97vU1ltV4
idBdWV4NcAnwzx5e652m
=101M
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
