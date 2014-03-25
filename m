From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi-topcliff-pch: Transform noisy message to dev_vdbg
Date: Tue, 25 Mar 2014 18:56:25 +0000
Message-ID: <20140325185625.GF2269@sirena.org.uk>
References: <20140219124150.GO2669@sirena.org.uk>
 <1395731432-30027-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgVgbXf0Vb2tUvlQ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395731432-30027-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dgVgbXf0Vb2tUvlQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2014 at 08:10:32AM +0100, Alexander Stein wrote:
> If during a SPI transfer with len larger than PCH_MAX_FIFO_DEPTH and the
> IRQ handler happens to be called when the transmit FIFO is already empty,
> and SPSR_FI_BIT is set consequently, the message

Applied, thanks.  Please use subject lines consistent with the style of
the subsystem.

--dgVgbXf0Vb2tUvlQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMdFVAAoJELSic+t+oim9ZVUP/2E//hyAh9Dv+pgcQR41TIEF
a+572fDUfRr1CjsgGw20fcLQJ/COanX6ozZlbgreuYMy/zt/LPPez3gmo4ut8utK
wHxSpsG3ZvjBnu76mMql60ActKGbdPrJ7IKs6XRtifHEUIN/Cvl4PqrhcL42N3qd
724Kc85g9L5HplXvdgXFx4/8cSJrSVn0VBUMWsh2VvRyJzzIZZlCQcZE8ek4MCa7
Lpt2c9Zl0FSs04rVPQt9aXRyEfh3TbdhWIHF6mTkhvI4BeiiDJQhUuP5CUDsSU/l
9nkQzj6i2FrNYx2A+aAXAaYFARgssvLKu4gYIGViu2J9lTg3u3VJMUGYrjNlZdLJ
lakOfFspTfgG1QOQxMMM7Pp/iD5HOzbcspyNQdxgwDFBl4HwC8vkquoemHftGMQ5
gar+dCqOA42hF+w/k827UFdZJn+YiowaeAx9/23o8HlgahUt7VW9vXBUYJVbCVVR
OH8ocWk9B6jh0liUfcKHJpH7Rlwhn5NCjQ2VcRcPyQtTvIcXKIUiel3k/0rxPSqc
/n0zFaIc5kO43ISW/t3rXqrTtxfUgW+i1sKcPTvYSX/waSMFrkImXGuP1O5c1/en
K/SpYe1dEwqnx+i7N9l/DTsZMj94QjP8I+gQMH3vJFUo4fTotE6VWYNbT3MWauDN
mXAkmad9hVvRTAqYoLKh
=JI41
-----END PGP SIGNATURE-----

--dgVgbXf0Vb2tUvlQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
