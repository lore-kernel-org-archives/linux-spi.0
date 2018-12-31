From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio
 to register as a clk provider
Date: Mon, 31 Dec 2018 17:50:34 +0000
Message-ID: <20181231175034.GI1846@sirena.org.uk>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
 <a89c7974-672f-e5d0-8022-d2c2f9ffeac0@suse.de>
 <d22f1f18-0c93-a537-a439-07363174a03b@suse.de>
 <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nEsDIrWrg+hrB7l1"
Cc: Ben Whitten <ben.whitten@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
        linux-kernel@vger.kernel.org, starnight@g.ncu.edu.tw,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 30, 2018 at 11:55:46AM +0100, Andreas F=E4rber wrote:
> + linux-spi, LAKML

> Given that observed symptoms were CPU stalls, workqueue hangs and RCU
> problems, requiring a power-cycle to recover, I wonder whether we are
> running into some atomic/locking issue with clk_enable()? Is it valid at
> all to use SPI/regmap for clk_enable()? If it is, is there a known issue
> specific to spi-sun6i (A64) in 4.20.0?
> I already tried setting .disable_locking =3D true in both regmap_configs.
> Any suggestions how to further debug?

You can't use SPI for clk_enable(), clk_enable() needs to be doable in
atomic context since we need to wait for the bus operations to complete
(you can start SPI transfers in atomic context but you still need to
wait for them to complete).  Any clocks that are only accessible via a
slow bus like I2C or SPI need to do the enable/disable in the
prepare/unprepare operations which aren't done in atomic context.

regmap can be used in atomic contexts, though you need to configure it
to use spinlocks instead of mutexes and ensure that no register cache
allocations happen during I/O (eg, by providing defaults for all
registers or by not using a cache).

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwqVuoACgkQJNaLcl1U
h9B/iwf7BlSQzbOQ0KksQFHM3Zo+w60UAruaEM3FZHfuKjMa19b2GVVEYt6jfcrh
tpvudfBIi3vlkx4Z0adtfhOb5oGv8Y3owUOBMWWpS4Bn/ZHOBvZOdh2EWHw85Jvb
6YijmsoqAj1fNooCPEXFD6SCEAGfyRjVz3hANVIZmiBQYKrU2KT32/hNQ/WC6XK2
AG6ZlNDFZJHyuP6dQ9hOhH3fUyYZSYEB7xopOje8ZTCrdO5htJNA17P4C+zojRR8
5KO2RrumYLTaEdeXCIq+qvFaErgsYAg30mJwGVZLb14KPy0z4w8SFriJDNKG/0K3
fcTWnePlEZ7GfuI2t+b9vyV0xJgKxQ==
=OefZ
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--
