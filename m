From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v3 1/6] spi: core: add support for wakeup-source dts
 property
Date: Wed, 21 Jun 2017 11:52:55 +0100
Message-ID: <20170621105255.fon65wco27qh36jj@sirena.org.uk>
References: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
 <1498039313-24220-2-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cw4hnrl6643bbfl7"
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org,
        dmitry.torokhov@gmail.com, dianders@chromium.org,
        linux-spi@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498039313-24220-2-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--cw4hnrl6643bbfl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2017 at 06:01:48PM +0800, Jeffy Chen wrote:
> Use generic wakeup-source property to enable spi device wakeup.

If this is a generic property shouldn't it be in the driver core rather
than individual subsystems?

--cw4hnrl6643bbfl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllKUAYACgkQJNaLcl1U
h9BOBgf9Fc+VRbAFJDQTHW0D7yT7h0ugbn30mdZZen4I/r2595XNExC6PMllzDFZ
LIN+YZfOR0aE+8F75WmpeYmxMRkvO1kTJcNMM5muQECV5VmREV1gpHLloQXLmoRo
rw1+eV48hRXKG9pUMTZzIR0d6CXLraYHdnmMQVWxVbd1q4Aw/fM6QxVVCV3QYqOi
0cywCrY9ZBQYJs9xD6QqZlfUhXZlpjpnjaEbSlRHEo3cXzRZKVckVjhHlQXB44eA
Cmr2Xqz9IlqOg9+ee8O4bhYX86xMmC9cPI07fPoI4GWJnmeU9HtGvlMspJ7CySI2
e8jeYXOEUM1pGnYzTBL/fUQDnJBDJA==
=7te/
-----END PGP SIGNATURE-----

--cw4hnrl6643bbfl7--
