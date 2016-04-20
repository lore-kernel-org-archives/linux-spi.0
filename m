From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 1/2] spi: spidev: Use 'new_id' sysfs file for enabling
 spidev
Date: Wed, 20 Apr 2016 13:17:04 +0100
Message-ID: <20160420121704.GI3217@sirena.org.uk>
References: <1460978308-8062-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1460978308-8062-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20160418130126.GC3217@sirena.org.uk>
 <5717726C.2090302@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NzlXNccsnmbvA4eK"
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Stefan Agner <stefan.agner-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5717726C.2090302-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--NzlXNccsnmbvA4eK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2016 at 05:43:32PM +0530, Bhuvanchandra DV wrote:

> SPI drivers bind to the device as configured in DT, but in case of
> spidev(non DT approach) the device is not available in hand to bind the
> driver. So tried this approach of creating the device and then bind spidev.
> I agree this is not a standard way we bind SPI devices. With out a device
> available, seems it is not possible to bind spidev in non DT approach.
> Please correct me if i'm wrong.

The DT should describe the hardware so the DT should describe whatever
device is connected to the spidev, what you're trying to do is have
spidev bind to these new compatible strings.

--NzlXNccsnmbvA4eK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXF3M/AAoJECTWi3JdVIfQ5vwH/jwdoqIDuj8ECfsJhiog2CdQ
V3Sa+sqqybwD9rStSEADKDFAdV8tMydxXeHS8CbOaO87gU3o46B9260SyocDKaxX
T0QnsV+J+mPmNP8Wsy5cWJpmHij1hnVYzLGBvVxYq4ZJ1atR3gFsen8cb0R8pt03
ndrblsMQua7FULIxSZozOhp/Oic3zJJclwOv9qGMfudmi2oBsLkj1mwFvrdQPYPD
c6lupU66wEMoRjXLZauZRe8oz12bpvzumBpoVpjnv78dU89oIR1lbPN1mbVSBlVg
+2gGTZt9//VansO12UNWdm98cBd+z+muzPHyMfwD42mmPi3iH0xDOFUHPjrkJvo=
=8RLN
-----END PGP SIGNATURE-----

--NzlXNccsnmbvA4eK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
