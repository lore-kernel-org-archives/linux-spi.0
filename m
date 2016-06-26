From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Sun, 26 Jun 2016 02:15:00 +0100
Message-ID: <20160626011500.GF28202@sirena.org.uk>
References: <cover.1466696079.git.hramrach@gmail.com>
 <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8JAmzYDSl0Sjbh5d"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>,
	Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>,
	Nikolay Aleksandrov <nikolay-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>,
	Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Adrien Schildknecht <adrien+dev-Yk6CzqVXkG6lnMjI0IkVqw@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8JAmzYDSl0Sjbh5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2016 at 05:41:20PM -0000, Michal Suchanek wrote:
> SPI slave devices are not created when looking up driver for the slave
> fails. Create a device anyway so it can be manually bound to a driver.

> @@ -1543,11 +1542,10 @@ of_register_spi_device(struct spi_master *master,=
 struct device_node *nc)
>  	/* Device speed */
>  	rc =3D of_property_read_u32(nc, "spi-max-frequency", &value);
>  	if (rc) {
> -		dev_err(&master->dev, "%s has no valid 'spi-max-frequency' property (%=
d)\n",
> +		dev_warn(&master->dev, "%s has no valid 'spi-max-frequency' property (=
%d)\n",
>  			nc->full_name, rc);
> -		goto err_out;
> -	}
> -	spi->max_speed_hz =3D value;
> +	} else
> +		spi->max_speed_hz =3D value;
> =20

I can't relate this hunk to the changelog and there's a coding style
problem, if there's { } on one side of an if statement it should be on
both sides.  Why are we making this change?

--8JAmzYDSl0Sjbh5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXbyyTAAoJECTWi3JdVIfQthYH/0/FesGL9pQ7W79XcKvvmHp4
QAS4srcF10Z070N8LKsIxM1fVFV0KDNl5TdFxivu7uBZimlV2w0cZjSivosaZ8/1
goWpVpYwH2DLs+y8TecLNbNOUvl5mT6/MRak69+HHwL71UY5Zgzf/LrdTCKKPnFt
GRayD7qp5evYAXPldrDq0JT7M3Rp6YqWmBM7ag9Rdkqhzw2pENQxbev5TiVDID4L
CmjM7I3b8jF2ZGZuvJNQdKSCWdfFdsBpWvI4LSijoa/y+wQhY5M5542gGWtLhl82
QXGVTSJEP3EZhQZ2laUQvj9TLP9bZDyD3Pa9xFUlzicqV4of4SnsXiElwa1a74Y=
=EKtd
-----END PGP SIGNATURE-----

--8JAmzYDSl0Sjbh5d--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
