From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: davinci: fix to support more than 2 chip selects
Date: Thu, 31 Jul 2014 20:35:46 +0100
Message-ID: <20140731193546.GP17528@sirena.org.uk>
References: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com>
 <1406827995-30913-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QwqEysHDLt9UhJtE"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406827995-30913-2-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QwqEysHDLt9UhJtE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2014 at 08:33:14PM +0300, Grygorii Strashko wrote:
> From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>=20
> Currently, the driver defines SPI_MAX_CHIPSELECT as 2 and
> use per device array bytes_per_word based on this. This breaks
> if num_chipselect per device is greater than 2. This patch
> fix this and allocate memory for this array based on
> num_chipselect.

Applied, thanks.

--QwqEysHDLt9UhJtE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2pqPAAoJELSic+t+oim9ELUP/00TGZae3se+abIfczZ71Qk6
V9Ldp8zpa/gwCk76fidGvWzjtoiJOeAEwhg1Kr8liVs984BFdjYUAwLSZX2z7ena
Oi1GSt+Yq/QE/EFl/iA+RIvwJkpAO5itf5/EueWoz87956mNZEN6xsqxlIJI3HF2
Y7znCarE3MRY6XNRhv7VizqWdWAk7hf509M4AS69vRhjv5wPLsJ2eQgULK3lC4kK
MVm0VDyi/xzO5KOjYyqkeD3+JxpiDG+/Mt7SbUBrowYph5uWT7UGCHRSPKSa81OP
OTKKpVs8HpHFrNAXYiMyVjNYaBuE5rpsbR4np083L8OTlhvUtb0wJmjJ8PIDA8IA
B386doqD98/0LvcwEruF4GAdQ3jCnXxuqMO+tjfDeoK/tkE+k3JVUAQ6f5VcE2If
AW+fNJ1AYptd3hMrCP8wqBkf6y05eY0OmCmM294iiFXvF+u3YbJSmdoWWT/Yq28K
53RETwzijxvVcaioXAwVUSAbrHdGk8HruuYXqq8Mb+lt+VFBXS+oyL8PqpjC7jAl
kVNiZQIb07Ha68Gb/o/WZLZLyNKINdAlnG74SBkdUzSa1qrrMwemRAitDZM2f3Vn
S+PPrnE2IqkTiN+ab2PN8cGMs8t2Pp4AW7FL+IKjldUwB14lxHkXQL3px1mcIUBO
ofkvPab0I91uqqlHn5Ej
=xso+
-----END PGP SIGNATURE-----

--QwqEysHDLt9UhJtE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
