From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/18] spi/xilinx: Simplify data read from the Rx FIFO
Date: Tue, 27 Jan 2015 17:25:50 +0000
Message-ID: <20150127172550.GA21293@sirena.org.uk>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-4-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CeJGzupbOM8Uylfo"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422029330-10971-4-git-send-email-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CeJGzupbOM8Uylfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2015 at 05:08:35PM +0100, Ricardo Ribalda Delgado wrote:
> The number of words in the read buffer will be exactly the same as the
> number of words written on write buffer, once the transaction has
> finished.

Applied, thanks.

--CeJGzupbOM8Uylfo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx8odAAoJECTWi3JdVIfQ7l8H/13KhfkONQbz5VjeawqGz9YI
AWGJ0pfEGajcrZyfyBOtqUkUmAoUZ2cfigP5A8aMkMxvkS7UBoSWBwzyWgSebObF
v7h5A1gAvDtukMKs/0zue2c1gJMqjsY30H8Wtipx2AUMMDc+IqZ0pjWUme5UFJfJ
ZG0HHuCXXg9mCh5DSBKS3N+MtU4qpASnhF/Uly6w3YjiHFAg2Jn4fCLGPM1eMBPW
dHFC61PejoZQWcZBJusltrlEh6gswxukfT08qwExqWQ3o6jcm9Rqi9IrhswwS6Yy
wWKfEU5N2W3n7kredJ9XRWHvJ1PILCN+2FXfVsksgGxWSAV7+VYwFP0p6SpT4YI=
=jyaf
-----END PGP SIGNATURE-----

--CeJGzupbOM8Uylfo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
