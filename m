From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] spi: uniphier: Add SPI_LOOP to the capabilities
Date: Wed, 25 Dec 2019 18:01:42 +0000
Message-ID: <20191225180142.GD27497@sirena.org.uk>
References: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1577149107-30670-5-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1577149107-30670-5-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 24, 2019 at 09:58:26AM +0900, Kunihiko Hayashi wrote:
> Add SPI_LOOP to the capabilities to support loopback mode.

>  	master->min_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MAX_CLK_DIVIDER);
> -	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
> +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
> +			    SPI_LOOP;

I'd expect to see a matching change that configures the hardware
in loopback mode when the driver is in SPI_MODE?  There's nothing
in the existing driver.

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4DpAUACgkQJNaLcl1U
h9DGCwf8CErpoN6/aSizdxhROvbaxbMpt+6Wh6FxMDWHCl0b/S5wOEioBxEI6mnD
8xn4n0sNUZ9qnymFxuGoDrNN/qNl3UnJ9QyjxRCNg6fC6PI10I+SfzIZwe9BFDs5
RrDvozuG4OGgJbuE5BWHtaBTVP2afnzeFla+yszRxI7/j7Urg1Qlm7wUZjueXRd3
ifEjUTZNjmH3nx8+CV8WiiP0KFlzgQM/r0Gcjoj8NwW8UZj7Kepxg+XUs6vrOvwv
0i2iZwE/zFSKnDav0Whjjstv9HDwO17W1swi6bQbZanUkjzghYSLqdGOQm7vqB2r
aVLi2EgBy54qeK1Zg5zKZ56TK8PexQ==
=XK8L
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
