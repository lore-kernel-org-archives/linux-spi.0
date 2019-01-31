From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/2] spi: support inter-word delay requirement for
 devices
Date: Thu, 31 Jan 2019 12:46:13 +0000
Message-ID: <20190131124613.GD20797@sirena.org.uk>
References: <20190129205502.7741-1-jonas@norrbonn.se>
 <20190129205502.7741-2-jonas@norrbonn.se>
 <CAMuHMdXv6U-VeznbXrTNk9oY1kCkYu-b+_o3KH_R6BMgpVn7YA@mail.gmail.com>
 <d9c495ac-825e-6dd0-5455-817c3f27b840@norrbonn.se>
 <CAMuHMdXAjLBpQ6OXLwRsCzt5ydjuGFK6M6dKuFU4EL+6o0NB6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Cc: Jonas Bonn <jonas@norrbonn.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXAjLBpQ6OXLwRsCzt5ydjuGFK6M6dKuFU4EL+6o0NB6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 30, 2019 at 09:15:09AM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 30, 2019 at 9:10 AM Jonas Bonn <jonas@norrbonn.se> wrote:

> > And with that said, if you insist having a u16 for this, I'll change it.
> >   Just let me know.

> I'll defer that to the maintainer (Mark).

It's an internal kernel thing, if we end up needing more space we can
just change it.

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxS7hQACgkQJNaLcl1U
h9Blbgf/UdZ/fY6wb4r2MpFasZi5arBoDtRp9jFfNtbLbH/ydhvLOQbNDVX3Kcs2
sUbSgUbzBwmyK8vG4IgAKSLZIDenVwmlQNsIamLzo5sHHz0XWfMD4hWRlPrEc3zK
FR7Xb7A3HugGnruRQM8WNJmGABn2Zv8XP7G8NuQ0WuoPip5UO9H2up46PTtqQXOV
h042QZGPXO1AuFJfeFmPeUF+XIstPdX/HwvebpKAev8pZJ87Qg8IBE+NwgldmxgS
0xKV08PhvDlHF0JqUsaMuSYtSpBKBQFxy56pEf0EyedJIcLXg2U05hsR2DyAHx1b
kIvh/KifBVjBDBVcgnFJxznRWwopiQ==
=Og52
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
