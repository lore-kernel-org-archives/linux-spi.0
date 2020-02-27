From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-bcm-qspi: Use new structure for SPI transfer
 delays
Date: Thu, 27 Feb 2020 15:29:06 +0000
Message-ID: <20200227152906.GD4062@sirena.org.uk>
References: <20200227141050.10969-1-sergiu.cuciurean@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Sergiu Cuciurean <sergiu.cuciurean-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200227141050.10969-1-sergiu.cuciurean-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 04:10:50PM +0200, Sergiu Cuciurean wrote:

>  	if (qt->byte >= qt->trans->len) {
>  		/* we're at the end of the spi_transfer */
>  		/* in TX mode, need to pause for a delay or CS change */
> -		if (qt->trans->delay_usecs &&
> +		if (qt->trans->delay.value &&
> +		    (qt->trans->delay.unit == SPI_DELAY_UNIT_USECS) &&

It doesn't seem ideal that if the delay ends up specified in a unit over
microseconds that we end up just ignoring the delay entirely.  This
probably needs fixing in the core though, for example allowing the
driver to say what range of delays it can actually implement.

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X4EEACgkQJNaLcl1U
h9AuKQf/VwDsH35+efmI58edDRHc3b1P9SXWdUTz+6yZOMfKofhGJlhnhkoHheqt
kfVUG2SxvNDzDpmoZLW5KscTW0WcY3Le/15dLQoXpbRyshvNOiP7y4K/GJrlHCr/
fic/79xluk+5b+abPXyARC/wjaVN2lNgl1dPVuvXvIN7Regl45EbWX53gFPybxiF
lIQkR0ZA64jgUsDMF+ogiqW05kE6/rWo4OkMgqKKvkIAHeFoxSFmpxUxQYXDencr
w8tCW4F86F5FifuAhHOmXv95ZvuIaG8Lyu9MCOOI+EBUj062yM3D0FXbWkdy+umU
qKF0F3Y/cCMHZdzA4LIri/M8lk23VA==
=qSJi
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
