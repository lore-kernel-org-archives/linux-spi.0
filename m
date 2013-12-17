From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/11] spi: mpc512x: Use devm_*() functions
Date: Tue, 17 Dec 2013 22:53:13 +0000
Message-ID: <20131217225313.GT28455@sirena.org.uk>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
 <000e01cef4c7$53d9e060$fb8da120$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SSJ6yXlPvEk0CmSI"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Gerhard Sittig' <gsi-ynQEQJNshbs@public.gmane.org>,
	'Anatolij Gustschin' <agust-ynQEQJNshbs@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000e01cef4c7$53d9e060$fb8da120$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SSJ6yXlPvEk0CmSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 09, 2013 at 07:13:38PM +0900, Jingoo Han wrote:
> Use devm_*() functions to make cleanup paths simpler.

This doesn't seem to apply against current code, can you check please?

--SSJ6yXlPvEk0CmSI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsNXWAAoJELSic+t+oim9CE8P/0rTBTZXiXf2KxD8D/6KjXWs
gcGEp+CE6YsCzpg7LfzhbGih35xE52vDc8ZAJPHVzvDqZbjXKMHpqYtvTY/i1Y1B
Fj03Jm6uLwbLp9oEWj7E9W68MaXBOSbrXK26cMuWajlh5b4Eoxz6PChWnfGsJQBZ
//kgEpvM5IGTVLqRnp07swWGwOrhJBpARJ1+OO4+l9AoL4IFTXTGJRRbPU0JWOam
EiPX4PVJIlv3gxN8am2KPiTkRCqPV1RTyX5ZNiM3S+7q5YF1SwV1U4B8Z0TDsmvt
RNeekS93IYWdJUUwsiofp76wGyuDVB14+Mis8TPXpvYLSxh7TYaE9DulKDME9SJu
XSe56/VHkH2o8w77+KsRKvousbIwahFrfxDaGj3KweMSvQHqJlXeJOWRWMUqcHEk
C75rj1K4oSFtuPtGFBmC3cS1hq5FIRcykV/pHLW2e1s7vr3Fz02XKJzUfWLP72Op
5oy2j5D83B1E3GJDHv5BlpQWAsiSFwJ9byFYtdXsRkqU+I+7PpmBNC6M611Zf5og
yAFNQKkp/MGq1oCsAf/Wl0oFIZdLV21L2l0wii3fkOg9q5ABMLzcvRwT+PNxrwYa
N5AfRj3JdrZbiwaslfKE2rR5DRtYAPbvA5+Vww/KArnJ+i7SN8K968rt8lfVClkq
rARPY+dH5b3YHdRrYyBN
=/egt
-----END PGP SIGNATURE-----

--SSJ6yXlPvEk0CmSI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
