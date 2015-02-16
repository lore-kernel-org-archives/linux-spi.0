From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: only use up TX/RX bounce buffer space when
 needed
Date: Mon, 16 Feb 2015 13:13:21 +0900
Message-ID: <20150216041321.GM9110@finisterre.sirena.org.uk>
References: <1423743188-1821-1-git-send-email-abbotti@mev.co.uk>
 <20150214044910.GF9110@finisterre.sirena.org.uk>
 <54E0753E.30208@mev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YS7t75H5cNTCpbja"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54E0753E.30208-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YS7t75H5cNTCpbja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 15, 2015 at 10:30:22AM +0000, Ian Abbott wrote:
> On 14/02/15 04:49, Mark Brown wrote:

> >This is a bit hard to parse.  I think you're talking about buffers in
> >spidev here but it's unclear and you've not described in what way you're
> >changing the code and we do currently only seem to copy data when the
> >user has asked for it.

> Yes, I was talking about spidev. I did tag it in the subject line of the
> commit message, though I'm sorry if the rest of it is difficult to parse.

Right, but it's not clear if you mean that this is something to do with
the device drivers for SPI controllers or spidev itself.

> Yes, the patch limits the total user-specified TX data and the total
> user-specified RX data to the pre-allocated buffer size individually rather
> than limiting the total sum of user RX and TX data.

Your commit message needs to say this rather than requiring the user to
reverse engineer it from the code - a key part of reviewing a code
change is making sure that it does what the commit message says that it
does to make sure that it is having the indended effect.

> The check against INT_MAX is there because a struct spi_ioc_transfer might
> have rx_buf==NULL, tx_buf==NULL and len!=0, in which case it would no longer
> use up space in either of the pre-allocated buffers so neither rx_total nor
> tx_total would increase.  Checking the sum of the len fields against INT_MAX
> prevents arithmetic overflow in the return value of the function.

If that's what the code is supposed to do then someone reading the code
needs to be able to tell that without too much effort, I'd not expect
that to be possible as things are.  Maintainability is very important.

--YS7t75H5cNTCpbja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU4W5hAAoJECTWi3JdVIfQeCUH/ArjimmpQsuDgvrdHWU6TWQ9
jxXZSJebwzm8goRIP9JUFk+x8qxED+8sWvcIbIJz+TCNqqAF/qhlwmOupAhAxvF0
LXzXWn0OGM3UYTFfwtWVlCrzCtqn1TwnIftO8zoK+Xu1h6JcXLyWJmUEMe2DbOhO
mjhVo2XUOAOji2O6658Uydx6Nz7/JELN0hAizNcH2DNBuGQkdGNKaYjjeQTA0kd6
Q4Jcp2y1dmEXWjSVppEwYgc+HNWSWbcoOHQuRbc1O6zM2JANFVSvhqV88+jHq6B8
duZmdUiRri1hfvLeeUhhGNBLIq/DCxerMdP/UL/TT0EDBOI06Y1dCUH/7gHHVUw=
=4gec
-----END PGP SIGNATURE-----

--YS7t75H5cNTCpbja--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
