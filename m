From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: dw: Initialize of_node to discover DT node
 children
Date: Tue, 7 Oct 2014 21:40:26 +0100
Message-ID: <20141007204026.GK4609@sirena.org.uk>
References: <1412711297-31857-1-git-send-email-tthayer@opensource.altera.com>
 <1412711297-31857-2-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TgMkQZ2qGgUcJEW2"
Cc: jkosina@suse.cz, pawel.moll@arm.com, robh+dt@kernel.org,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, dinguyen@opensource.altera.com,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, tthayer.linux@gmail.com,
	tthayer@altera.com, axel.lin@ingics.com, baruch@tkos.co.il,
	andriy.shevchenko@linux.intel.com
To: tthayer@opensource.altera.com
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412711297-31857-2-git-send-email-tthayer@opensource.altera.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TgMkQZ2qGgUcJEW2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 02:48:16PM -0500, tthayer@opensource.altera.com wro=
te:
> From: Thor Thayer <tthayer@opensource.altera.com>
>=20
> 1. The of_node element must be initialized to enable discovery of node
> children. The discovery takes place in the of_register_spi_devices() func=
tion.
> 2. Grabbing the bus-num from the device tree.
> 3. Update the SOCFPGA configuration.

No, each of these should be in a separate patch - it's especially bad to
be updating the defconfig in the same patch as the driver, these changes
should be totally unrelated.

--TgMkQZ2qGgUcJEW2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNE+5AAoJECTWi3JdVIfQv9QH/3axZXylCof8yoTQA1LpiL9u
c5bbYMMByYymXmLN/ME5kAiaguWqwdljxZ9C5zva0BeWgEX22vaz2LuC6dl/ekV3
UybK2lh+YQSxDKPv9xE8g0SoJVmnVskPJ6C1Z+Vwd0TC4JPYxuB3aGwLwyEAoAfZ
tLBocEZhBAH3NVl8DqpeUqU28xU5ZhSCiDffWYn8pnquM1R9ps6d2cGwldv4/ZpU
PCT8tIA+dVlTtP3XNJAkYi3FhS6Rq8rOuSKF2P1AUq6LPdKENaRKKNj9uRw3ag1R
l1yLMGQ7mjufq9NyH5zHL/mMVNdtXk5EKR6JUpWBQvktWm09p7N4OYzeJj0HUAo=
=9uVO
-----END PGP SIGNATURE-----

--TgMkQZ2qGgUcJEW2--
