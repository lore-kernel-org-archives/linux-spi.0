From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 02/11] PCI: Provide pci_match_id() with CONFIG_PCI=n
Date: Sun, 4 Nov 2018 13:02:26 +0100
Message-ID: <20181104120225.GN23864@amd>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-3-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0kRkyLZR5zsR9u2P"
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010170936.316862-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--0kRkyLZR5zsR9u2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:09:27, Lubomir Rintel wrote:
> This spares drivers from #ifdef-ing on CONFIG_PCI if the driver can be
> optionally built on machines without PCI bus.
>=20
> Consistent with acpi_driver_match_device() and similar.
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0kRkyLZR5zsR9u2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve39EACgkQMOfwapXb+vLo7wCfVr9Ov7i84YWFMz6uKkOTmCsG
BwcAmwaOQxx+O5fZHqEi+JsNzH3eYXbS
=oR86
-----END PGP SIGNATURE-----

--0kRkyLZR5zsR9u2P--
