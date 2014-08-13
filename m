From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC][PATCH] spi: bcm53xx: driver for SPI controller on Broadcom
 bcma SoC
Date: Wed, 13 Aug 2014 13:43:42 +0100
Message-ID: <20140813124342.GU17528@sirena.org.uk>
References: <1407933212-20530-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g+bbWMxjJfJi+1z/"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407933212-20530-1-git-send-email-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--g+bbWMxjJfJi+1z/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2014 at 02:33:32PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> Broadcom 53xx ARM SoCs use bcma bus that contains various cores (AKA
> devices). If board has a serial flash, it's connected over SPI and the
> bcma bus includes a SPI controller. Example log from such a board:
> bus0: Found chip with id 53010, rev 0x00 and package 0x02
> (...)
> bus0: Core 18 found: SPI flash controller (manuf 0x4BF, id 0x50A, rev 0x0=
1, class 0x0)
>=20
> This patch adds a bcma driver for SPI core, it registers SPI master
> controller and "bcm53xxspiflash" SPI device.
> ---

You need to sign off your changes, please see Documentation/SubmittingPatch=
es
for details.

--g+bbWMxjJfJi+1z/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6117AAoJELSic+t+oim9GeIP/05rcm9njxxYa9F3flCGtSkG
fikfrk+LoNxi87ctFDE1/m7Y/qJXwhr3VdPb4w5GJ+KthryKt7k5PC24YbOr8CjU
qgGo8+jL/qKHT3JGEPjwQeHzokVeXawsL4/Bb7hZoW9OiDqaZzgEWgVIuokvwQfK
rS9oJAvHfGpq43aBMCStXuz1qMSC6IuRrBuda9qC4zOG/VElV8f8HUEW8s1xdGk3
gWmukq4WOsC9XVtCDOYR4PoLyGnNLMI8juQe21f9lu100T8vGmW8e9a3BMeRLSJ7
bk4lrqapvI8s68pwh/N+QjCzt+4haIcQsxFH8wgmrfo3NV4HE0XT4dTZHvZn+S2k
By14Ku90mppHFcgy2yG4cDlURHrManl0EwuJeem81GT3yagKJEXO94KZPnzQY3tK
VSRFgGF2nci3rvRGpPQRXZZqHUsc9rI6tERpK376TgyDwljIQ6TwRIOPp8+tZZWz
1o+yOhRStMf9QWjw+RZIhU7PGFD3yPSKZI/QofEsi7x6k/ftgvojrvgO2NWtbKzd
pFMaCOtjkRauOFiwlW/RDSDydsimOkhqIZUkR/WsJpu8AlwIIocHyTsT+75cdfeX
vmJvTPReMJzRnhhguPpOOgtiwc/0WmJbbTZMYd+sNvrGqMEg5jmK2HAM65c0+Xgx
vv20dj6CjFolygFswTvW
=EBb8
-----END PGP SIGNATURE-----

--g+bbWMxjJfJi+1z/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
