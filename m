From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: clps711x: Convert to devm_gpio_request()
Date: Mon, 13 Jan 2014 10:17:17 +0000
Message-ID: <20140113101717.GA29039@sirena.org.uk>
References: <1389512019.13361.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fU5tsrXreH0/dVH0"
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389512019.13361.6.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fU5tsrXreH0/dVH0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 12, 2014 at 03:33:39PM +0800, Axel Lin wrote:
> Also drop unneeded gpio_is_valid() call, the checking is done in the
> implementation of gpio_request().
> With this conversion, then we can also remove spi_clps711x_remove().

This is a duplicate of a patch Alexander sent the other day.

--fU5tsrXreH0/dVH0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS070qAAoJELSic+t+oim95pwP+wdVw13gp5WHJlQYHGMWXeDh
MUXUwZj+ISRC3jk8IxKvhHUQIkybLFuOsWto+o7d+eVxRucN1M3bA4g2LoEZa9QJ
GjIJLQfVz28Ii0ZfR0bDDs3XHDKtqrSNCsOwuQRYQ0EQKvZzAO6YsRw2DoXKAriJ
ifvwXBj1SFj6K2LHlcchvNZ3C4hgzupsr8m8jUA/IHWBmFpQUSONEAI0nYVXrFTD
jZqTI0inZrpiqalE74mkXazqP/6ZIKLTgIztxfMZynI6HCH9eVZsGnQtoKhNCE6I
zxqCrSBpwITQPKLW2WzSuEE/1SVDbsIPsxWti2icPOrC2Src4r9RhkQseb5sP95G
02mcTZoHILd0dgAw0bQpUvBtbkeocvYF9awo/xKxj4Jd8c/c/uKJ5X49gJkAb68n
j9GVSqkQvDAJsgWTtsLTigbdKpkWWGTD+AxbfJGONihdFhjJif47CUBtlca++2g9
wBI4uy9jGxvJ8Qy6KevEQ2YaDW3yGoDd9CiCKP2O07D9R1frNzUxx9C6Fwhtm0EY
EnsAvqouH54mZzKW2ikL6dxj0D9mylUW7rVMJ3jrQBCGQ9S6Byg0h+n63aZaUR23
gJkLd0pRnCDkd/ssOVS3hb9Nbk/eubqNINwe21f394sBNy0XKAEsID7jCA4yCDwJ
mKMIWW2kCqc3WONzjwC/
=A3vv
-----END PGP SIGNATURE-----

--fU5tsrXreH0/dVH0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
