From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Sun, 29 Mar 2015 09:55:05 -0700
Message-ID: <20150329165505.GQ1743@sirena.org.uk>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dJyWBSYfjLochwFK"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dJyWBSYfjLochwFK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 29, 2015 at 04:03:25PM +0200, Martin Sperl wrote:
>  reduce interrupts/message

Applied, thanks.  There's something wrong with the way you're sending
patches - long subject lines are being wrapped into the body of the
patch.  Please check this, the easiest thing is most likely to be to use
git format-patch and git send-email to send your patches as that's
pretty much zero effort.

Please while looking at this also look into threading your patches into
a single thread per series, this makes things easier to work with.

--dJyWBSYfjLochwFK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGC5oAAoJECTWi3JdVIfQuf8H/1fBKddAEzrhqZ0O0knpcJkq
9i2hraOUarzlvLZ22PQCjP7CML9ysqykwClz2+AdqWSzVSkhAPYk2Pcyva/7x7oV
BTqobWhHAhOBpOrytXhMEizByVmJGCnkAqJCH6K+G5XQv8m6iYXjyDARznHdVF8K
J0kstpTMdvbFcfbOQbhybdiZD358rPc4Yl9gKMNjA39aDXPOIasp7KOe06iwOOci
/uXdhmJybVShLoImrXS3VRTYzcI0X92XyU+xVhmE5uyfqX3/QK3w49a9zbLQ2ety
FsaVrhlvBDzln6daDnZ7vEzlkbSLwLGi396LwauZcROqcmsAl4MWggoJg7X4iFo=
=5134
-----END PGP SIGNATURE-----

--dJyWBSYfjLochwFK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
