From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Clean up probe and remove functions
Date: Fri, 14 Feb 2014 15:03:41 +0000
Message-ID: <20140214150341.GC4451@sirena.org.uk>
References: <20140213152841.390de00f@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140213152841.390de00f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2014 at 03:28:41PM +0100, Jean Delvare wrote:
> While backporting 33cf00e5 ("spi: attach/detach SPI device to the ACPI
> power domain"), I noticed that the code changes were suboptimal:
>=20
> * Why use &spi->dev when we have dev at hand?
>=20
> * After fixing the above, spi is used only once, so we don't really
>   need a local variable for it.

I've applied this but I have to say it's a bit marginal as a cleanup -
for example while we do only use the SPI device once it's not entirely
idiomatic to use to_spi_device() in the middle of the code rather than
at the top of the function so it's a small speed bump to see that.

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/jBKAAoJELSic+t+oim9nboP/0Flxx+z76Pv5CnZm46olauE
vl5sdoO5xm+r1xzKHiVrU5uRNdt2dUhTAyPhRP6nD8j0pUFiPpW+CaJR2N9BEEV3
gYxV81snPegicfVAYBo04ysqNgoN7upGKxHfm7Uq8cIJAfZAlZDjL2L9eoFmtVT3
gUi/amGNwpHqizNROiEsJYAOe6DvQUPkCzSnv4LY/Hcf2bdsRgoJqwPhHKcZ5vIZ
kESM576ogIzpnLu1N2GxM2WvCgs8ZAcKqheaIbsO5TvbkXPq4ADO2736v2nbjY53
e4+5WpKT43bO0TZej4c8M2OZ6jHq25m8i/8d4Eo6M/vs1mLEcymQI1anYiYkM+Ls
P6PY0nA9zOB6MIii3Y8k+SOosaZOZdEeD4P34PYQ88RXnuKlouUREWvqweZWvYPo
AYEinmJ8Mg1Iwz5FxjdY2wHGYfppoTc8+Zy5VmqtcPhjcdReE3D4mDWYEFI7I0lN
DuqREG5Fo4xfs6wDGZnW2BJnIj2Sxzaz2WescgaaBSbDG/X0yDI83+dx333UCr1a
ch6kCcFQYSgedMCrTpVMod39+euVFd63e9ZlccQLZFeKvsCAWb3z+MO/5reYwAhU
k/0PWEpux0snT0k2vjzHRmHj4wUqzwvINCcQ4M36xMEyAZhYwGE3QZgvlA4P0JF1
zlpg+KCVA7HjSdnWGNfD
=cog1
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
