From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] spi: Add option to insert delay between transactions
Date: Fri, 1 Jul 2016 09:16:36 +0100
Message-ID: <20160701081636.GC6247@sirena.org.uk>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
 <1467258867-117727-3-git-send-email-apronin@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G5yIW5EaChZ5gJdA"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: apronin@chromium.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467258867-117727-3-git-send-email-apronin@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--G5yIW5EaChZ5gJdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2016 at 08:54:26PM -0700, apronin@chromium.org wrote:

> Some devices may need CS to be deasserted for some time
> between transactions. Added a new capability to guarantee
> a delay between SPI transactions for the device.

This seems like even more of a per device thing - it's a very rare
requirement (I'm guessing for some SPI controller coprocessor) and
there's such a wide range of potential patterns that might be needed
by different devices. =20

> +       if (msg->spi->xfer_delay)
> +               mdelay(msg->spi->xfer_delay);
> +
>         spi_set_cs(msg->spi, true);

This isn't a delay between messages, it's a delay before asserting
chip select which will happen every single time we do anything
regardless of if there was any activity immediately before or not.

--G5yIW5EaChZ5gJdA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdibjAAoJECTWi3JdVIfQZoMH/3DSY6u5/SgZ4LQlWAM86hlf
D17E78t1j/bhpUZka7+FOhgly7Ly5HqJ57Gh4R0049KzvUr6pe0+LN6U5bO/OHyW
5JXmodaOA6oSS9Wy9DAKrGP2V+cKC2fP+wl8J4BSGoFKpZ7r+cGtrdx+tBHrFOwz
gmTjB1G7QRK6gAg/gco3Nyfv8yW0Ur6Ay8uyTv9hz7T6b8PAGUcBBscQjcZqLtov
C7Ise+vXz+ZyQC2UezpCsrYX79p17GDXF6BgntbsH7eP9nUwtfHEcflpbc/G16jI
o9ufP81N9qkqW699kvUyb1A2KzS5z9CecY7AGymWU3I/yfRrBi9mvMoveKxDsKA=
=r6ig
-----END PGP SIGNATURE-----

--G5yIW5EaChZ5gJdA--
