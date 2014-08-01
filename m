From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: davinci: add support to configure gpio cs
 through dt
Date: Fri, 1 Aug 2014 19:21:10 +0100
Message-ID: <20140801182110.GI30458@sirena.org.uk>
References: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
 <1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vt4ed5MNefdcgji4"
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


--vt4ed5MNefdcgji4
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

Applied both, thanks.

--vt4ed5MNefdcgji4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT29qTAAoJELSic+t+oim9gugP/1p6z/WeoE06pYHUyxvaE7G8
OGOi1c+ZHYGqQONZ749Gx4VVe99LIllmUAFCABMYKZXbEGbzNduqJH7j7cGO7WTS
n9UE/+OhQUwFgAExgYXIr/yv8zkYC7OEsFKG6e7lAVwxk0yzn70AWBZyhTJPDkSv
C/X93hKeJuniQBjy270QQJ1LSczoh0cHc7CUdto2NNq6tGPC4sM7aBJ2kKSU9rk8
+b+OH3NLz3jC8GXY1p0M1OOjXW5ymi7Q6iSL+G8pGGeDKs3QFn3FCpNFiv6Gt+Ea
pwHyPwSNqmJD0T09prd1gH5dLUZjUX792bjRTFmiN/Nt2Q+K/NYzKAU9x+b9DEQT
h9N0tbUcFlfO7C7gAdoK36koYP8w5mXcOfSdbpsF+vcy657P51ur779kfTu1GW7t
ey7RbXtUKCIxTnMO19fW9Cn+UBIQQXk4KEL5H6G/3DULsBPa6dNAO02S7nCV/ycw
o5wSi6xInYy3M6x3DY4LsJexyHCczSqnOQqNqHX2mmr29b1nMCCRM0xgl0jYjvmV
bd5a53ZEx4k33hi0JBjGjZLVcLY7DxLR6Vy/3Z44FF9baVGwB+iTUvUcuKQTmT3s
O0bGIdSCyAkkpVoJMG5TSwd29p/6NeCbDnuBxESHerTdK7TupH++1fiXcKBRTikV
QKjOUrwLjlc4p8ErJ8bv
=2EYg
-----END PGP SIGNATURE-----

--vt4ed5MNefdcgji4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
