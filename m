From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: davinci: add support to configure gpio cs
 through dt
Date: Fri, 1 Aug 2014 18:26:20 +0100
Message-ID: <20140801172620.GA30458@sirena.org.uk>
References: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
 <1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YOxyDEsNCn0QNWql"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406911233-18999-2-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YOxyDEsNCn0QNWql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2014 at 07:40:32PM +0300, Grygorii Strashko wrote:
> From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>=20
> Currently driver supports only configuration of GPIO CS through
> platform data. This patch enhances the driver to configure GPIO
> CS through DT. Also update the DT binding documentation to
> reflect the availability of cs-gpios.

Please submit an incremental patch with whatever the changes were from
the version of this that I applied already.

--YOxyDEsNCn0QNWql
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2825AAoJELSic+t+oim9uq4P/2MBs/rvvBj7luODTtlVVWTi
ruNvsNBJzaRZa+XPk5dvAu3rNBdd1gQp1tqR0hs2qDvlI952TWR79zgcZL6iJOyx
8HIIa5m5h3i0WIBRT9KkdVoMFcakYxilPqR2uB2Meg6UkW2Olnj/B3MmWrLaSqIV
iaW1LpxVxm6vuF0UYkq6Bt0qOOKSN7NImeYSSqqs654iW/JPSoKpHkZse1RFGC8g
x8sjkacoLXAMdCkMKQm0WTlTltLJ9MAqRVQHcAerqwIJVI0eqBClc6/SkLYZ+O1R
jJM9SqGa++kpCCjgXgz7d0GsGxMSJUy4Z9KdJHMXCQ3DMrMsRqfxJX18ncBkuj/M
AlYYkfWdubCvNo2gP5Sy4K8h9FtC6fFqm7ripk4gZMgmbzDSCUEU/ZnFkfGsWBw6
Lgd6vQx0IFtwe6to8TYXlTTyabBkxsDL0Q9TOXh/nN6FYYdWm8WnZhTnKECvIzu4
gG9+0/t1SfvnPS8q4OJDgwpnVU7L1Hbu3NCipa78qJZkdRm9HAU0jqeVVg+jprQB
ct9K11DVIR1w1r9D5KvHdtUxHOa+N0JqrIl0wxJvVWFQYDXHEf+PwM4/Wo/rbBkc
ppYKAwY09pb9wUoQvTflyQFFIATQbFfyE/0AlqZS7oPJfuyVfSZDAb99hcqs33zU
9pfKE99COtw+pdihkLyU
=jXKl
-----END PGP SIGNATURE-----

--YOxyDEsNCn0QNWql--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
