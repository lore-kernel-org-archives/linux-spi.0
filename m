From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 1/2] spi: spidev: Use 'new_id' sysfs file for enabling
 spidev
Date: Mon, 18 Apr 2016 14:01:26 +0100
Message-ID: <20160418130126.GC3217@sirena.org.uk>
References: <1460978308-8062-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1460978308-8062-2-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qXCixuLMVvZDruUh"
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Stefan Agner <stefan.agner-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460978308-8062-2-git-send-email-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qXCixuLMVvZDruUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 04:48:27PM +0530, Bhuvanchandra DV wrote:

> +++ b/Documentation/ABI/testing/sysfs-bus-spi-spidev
> @@ -0,0 +1,8 @@
> +What:		/sys/bus/spi/drivers/spidev/new_id
> +Date:		March 2016
> +Description:
> +		This allows to load spidev at runtime. new_id file accepts bus
> +		number and chip select in 'B.C' format.
> +		e.g.
> +		To load spidev1.1 at runtime:
> +		$ echo 1.1 > /sys/bus/spi/drivers/spidev/new_id

I would expect a new_id file to allow a new device identifier to be
added to a driver at runtime but this isn't doing that, it's specifying
by bus and chip select instead which is totally different to how we
normally bind SPI devices.  That seems likely to cause confusion down
the line.  I'd expect to be able to supply a DT compatible string or a
Linux SPI ID.

--qXCixuLMVvZDruUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFNqlAAoJECTWi3JdVIfQTDMH/2HJIsAShm4GQm+704J27Xou
7aNGkHO0BxrBYPyEYa1nngmC/PnBeDHCuA3qXIKIbaBrUNXBffdVKpanNDrMYo7+
+NlAwbx7+UUypiRc1LciWoRPHD0BJCy15uKtJygPXd3yyC58ulKWnWVFxHqEC6hR
xjjYrZlI+7mvc2BO8zHBG2GHuUgjq+I0/yrusCHmPkZSjNDTJWvwZ0Yi9Ixj7hV3
fqWCVlEGIgOqZHtUY+4JrBV5Oj5C8fsDJ60dQDabnwIH8ArH7huONiLtEGtBzYI8
F7fF1eZ0lI3bZzSCeBXpvRF+t7upNADpbgUSD1CjH5bjGxRHnBGk/nRL8dkuApc=
=v+f+
-----END PGP SIGNATURE-----

--qXCixuLMVvZDruUh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
