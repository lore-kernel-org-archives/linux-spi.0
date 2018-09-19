From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] spi: mediatek: Don't modify spi_transfer when
 transfer.
Date: Wed, 19 Sep 2018 10:31:57 -0700
Message-ID: <20180919173157.GD2471@sirena.org.uk>
References: <20180918161504.GM2471@sirena.org.uk>
 <20180919062928.238917-1-pihsun@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U1t7w//IUm8YcF8e"
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
To: Peter Shih <pihsun@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180919062928.238917-1-pihsun@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--U1t7w//IUm8YcF8e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 19, 2018 at 02:29:27PM +0800, Peter Shih wrote:
> Mediatek SPI driver modifies some fields (tx_buf, rx_buf, len, tx_dma,
> rx_dma) of the spi_transfer* passed in when doing transfer_one and in
> interrupt handler. This is somewhat unexpected, and there are some

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--U1t7w//IUm8YcF8e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluiiA0ACgkQJNaLcl1U
h9AEEgf/c9FGN+vhT4tkkoUG3IEtBQICO2atvwYxL9kWS06z6CkM3JjI7Ny4239O
vaxiEkEkXLgk+C0zZWpm05bu3hv3JL9tePjySlb1JxXKOn7h0waTiuSlBuDZs4hS
Yb7TwghHPZMbSG+NOS/GzZI/bYrY1FgSb4gUUa6fLSoyI7jnpqHZFzV3UwJOeHCd
BGGjIjUU8tLjhDMK7UckS9jwjEb0SusWfIEA36tko3xYI8TSN7zkck15KhiQLdsr
5ZxEtIAjUxh38y6MC9Csitah8PSV0/8ams5WduKybMlzDRCfZLMN2JeEsNDt0N1M
Ykgidr5LMY02nvK27GgojA3+CDl3tA==
=R8r6
-----END PGP SIGNATURE-----

--U1t7w//IUm8YcF8e--
