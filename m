From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT][PATCH 2/2] spi: sirf: Add missing
 spi_master_{resume,suspend} calls to PM callbacks
Date: Thu, 13 Mar 2014 09:57:42 +0000
Message-ID: <20140313095742.GM366@sirena.org.uk>
References: <1394003843.18343.2.camel@phoenix>
 <1394003949.18343.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jB+02Y6wHc2pEa2x"
Cc: Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394003949.18343.4.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jB+02Y6wHc2pEa2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 03:19:09PM +0800, Axel Lin wrote:
> This is required since commit 2025172e3280 "spi/bitbang: Use core message pump".
> spi-bitbang now uses core message pump, so it needs to call spi_master_suspend/
> spi_master_resume to stop/start the queue while suspend/resume.

Applied, thanks.

--jB+02Y6wHc2pEa2x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIYESAAoJELSic+t+oim9r+AP/3wSCtIXk5fImFDrJN0PcXBZ
8sBhSyrG2b2c3l/sIPr7ils0wlQh+ELrK8HoQ3wF5yto+UJhHuV6T6cwqu0c65FR
4d8O9e8j6tqQ7OCDLzYm8m11d5qLSopNbkaMAOfeg+ZHTuyac1buFaGt8cpFR2jQ
kJYN59yQ88HK0WC9oyKlnJ7dxvAVlvq4Fs4CsCofT7hOTkcwj+42Bex89yi+hms+
f/fxnhkEOdAV/I4Ljv+mbeuEh5ge+c/eT+Db5tzUfKx1oN6wd3/a4te9DywdrKNd
1hnTekIIxGOIr1t+vfpJsl7tZ+5EBLehgyZPg5cEwoA0VQOSduLpC9Uqs0oR0ens
1jNLc2YFfvjBaILcm5NZQGy87e2xmYKzVmdJCtim7FgAEgcD8Y6FWlErKRq4kumD
aWRmy4GkXgtOVyr8SKHhbgNKuPwQ/+kXu99u3su3acJGcxOiT8mviCjLe3urB+Il
eA01XtEofKMBdYMEYo7NmCiA1TG/e7aGkbac1akfS3uQg5c3NSrbDgPDK0vLgQmF
rKykyVwDWHJSyNqD2OqNvAafTOtegK9+bYFmxVP3rgp17i5IihEU8IMFdwwllWXg
GuGORgFtqJIV25X+qQaowmJWDQYRs1fPNqLPQ8+mTjGZjHZXBjN+YEk7mpdyXVbd
sHcuJMkKUi/IP48yNAmL
=ow/c
-----END PGP SIGNATURE-----

--jB+02Y6wHc2pEa2x--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
