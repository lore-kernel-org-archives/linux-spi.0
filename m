From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 07/11] spi: Deal with slaves that return from
 transfer_one() unfinished
Date: Sun, 4 Nov 2018 13:09:57 +0100
Message-ID: <20181104120957.GS23864@amd>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-8-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8N5nZmKALFZnI1Hj"
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
In-Reply-To: <20181010170936.316862-8-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--8N5nZmKALFZnI1Hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:09:32, Lubomir Rintel wrote:
> Some drivers, such as spi-pxa2xx return from the transfer_one callback
> immediately, idicating that the transfer will be finished asynchronously.
>=20
> Normally, spi_transfer_one_message() synchronously waits for the
> transfer to finish with wait_for_completion_timeout(). For slaves, we
> don't want the transaction to time out as it can complete in a long time
> in future. Use wait_for_completion_interruptible() instead.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -993,6 +993,44 @@ static int spi_map_msg(struct spi_controller *ctlr, =
struct spi_message *msg)
>  	return __spi_map_msg(ctlr, msg);
>  }
> =20
> +static int spi_transfer_wait(struct spi_controller *ctlr,
> +			     struct spi_message *msg,
> +			     struct spi_transfer *xfer)
> +{
> +	struct spi_statistics *statm =3D &ctlr->statistics;
> +	struct spi_statistics *stats =3D &msg->spi->statistics;
> +	unsigned long long ms =3D 1;
> +
> +	if (spi_controller_is_slave(ctlr)) {
> +		if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
> +			dev_dbg(&msg->spi->dev, "SPI transfer interrupted\n");
> +			return -EINTR;
> +		}

Do "return 0" here, and you can get rid of the else branch.

> +	} else {
> +		ms =3D 8LL * 1000LL * xfer->len;
> +		do_div(ms, xfer->speed_hz);
> +		ms +=3D ms + 200; /* some tolerance */
> +
> +		if (ms > UINT_MAX)
> +			ms =3D UINT_MAX;
> +
> +		ms =3D wait_for_completion_timeout(&ctlr->xfer_completion,
> +						 msecs_to_jiffies(ms));
> +
> +		if (ms =3D=3D 0) {
> +			SPI_STATISTICS_INCREMENT_FIELD(statm,
> +						       timedout);
> +			SPI_STATISTICS_INCREMENT_FIELD(stats,
> +						       timedout);
> +			dev_err(&msg->spi->dev,
> +				"SPI transfer timed out\n");
> +			msg->status =3D -ETIMEDOUT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * spi_transfer_one_message - Default implementation of transfer_one_mes=
sage()
>   *

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8N5nZmKALFZnI1Hj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve4ZUACgkQMOfwapXb+vJezACfdWPmxIHik7NiQxIG5EgeGSmt
jn0AoMPqn1NFosIeoCv7HnAUgT8maF5w
=mj88
-----END PGP SIGNATURE-----

--8N5nZmKALFZnI1Hj--
