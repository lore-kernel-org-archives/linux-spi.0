From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3] mfd: cros ec: Lock the SPI bus while holding
 chipselect
Date: Wed, 25 Nov 2015 08:12:19 +0000
Message-ID: <20151125081219.GL12874@x1>
References: <1448430667-4213-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Olof Johansson <olof@lixom.net>, dianders@chromium.org,
	rspangler@chromium.org, gwendal@chromium.org,
	linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Nicolas Boichat <drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448430667-4213-1-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 25 Nov 2015, Nicolas Boichat wrote:

> cros_ec_cmd_xfer_spi and cros_ec_pkt_xfer_spi generally work like
> this:
>  - Pull CS down (active), wait a bit, then send a command
>  - Wait for response (multiple requests)
>  - Wait a while, pull CS up (inactive)
>=20
> These operations, individually, lock the SPI bus, but there is
> nothing preventing the SPI framework from interleaving messages
> intended for other devices as the bus is unlocked in between.
>=20
> This is a problem as the EC expects CS to be held low for the
> whole duration.
>=20
> Solution: Lock the SPI bus during the whole transaction, to make
> sure that no other messages can be interleaved.
>=20
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>=20
> v2: Move bus_unlock earlier in the functions.
> v3: Remove comments.
>=20
> Applies on top on linux-next/master (20151124)
>=20
>  drivers/mfd/cros_ec_spi.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
> index 6a0f6ec..d6af52d 100644
> --- a/drivers/mfd/cros_ec_spi.c
> +++ b/drivers/mfd/cros_ec_spi.c
> @@ -113,7 +113,7 @@ static int terminate_request(struct cros_ec_devic=
e *ec_dev)
>  	trans.delay_usecs =3D ec_spi->end_of_msg_delay;
>  	spi_message_add_tail(&trans, &msg);
> =20
> -	ret =3D spi_sync(ec_spi->spi, &msg);
> +	ret =3D spi_sync_locked(ec_spi->spi, &msg);
> =20
>  	/* Reset end-of-response timer */
>  	ec_spi->last_transfer_ns =3D ktime_get_ns();
> @@ -147,7 +147,7 @@ static int receive_n_bytes(struct cros_ec_device =
*ec_dev, u8 *buf, int n)
> =20
>  	spi_message_init(&msg);
>  	spi_message_add_tail(&trans, &msg);
> -	ret =3D spi_sync(ec_spi->spi, &msg);
> +	ret =3D spi_sync_locked(ec_spi->spi, &msg);
>  	if (ret < 0)
>  		dev_err(ec_dev->dev, "spi transfer failed: %d\n", ret);
> =20
> @@ -391,10 +391,10 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_=
device *ec_dev,
>  	}
> =20
>  	rx_buf =3D kzalloc(len, GFP_KERNEL);
> -	if (!rx_buf) {
> -		ret =3D -ENOMEM;
> -		goto exit;
> -	}
> +	if (!rx_buf)
> +		return -ENOMEM;
> +
> +	spi_bus_lock(ec_spi->spi->master);
> =20
>  	/*
>  	 * Leave a gap between CS assertion and clocking of data to allow t=
he
> @@ -414,7 +414,7 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_de=
vice *ec_dev,
>  	trans.len =3D len;
>  	trans.cs_change =3D 1;
>  	spi_message_add_tail(&trans, &msg);
> -	ret =3D spi_sync(ec_spi->spi, &msg);
> +	ret =3D spi_sync_locked(ec_spi->spi, &msg);
> =20
>  	/* Get the response */
>  	if (!ret) {
> @@ -440,6 +440,9 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_de=
vice *ec_dev,
>  	}
> =20
>  	final_ret =3D terminate_request(ec_dev);
> +
> +	spi_bus_unlock(ec_spi->spi->master);
> +
>  	if (!ret)
>  		ret =3D final_ret;
>  	if (ret < 0)
> @@ -520,10 +523,10 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_=
device *ec_dev,
>  	}
> =20
>  	rx_buf =3D kzalloc(len, GFP_KERNEL);
> -	if (!rx_buf) {
> -		ret =3D -ENOMEM;
> -		goto exit;
> -	}
> +	if (!rx_buf)
> +		return -ENOMEM;
> +
> +	spi_bus_lock(ec_spi->spi->master);
> =20
>  	/* Transmit phase - send our message */
>  	debug_packet(ec_dev->dev, "out", ec_dev->dout, len);
> @@ -534,7 +537,7 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_de=
vice *ec_dev,
>  	trans.cs_change =3D 1;
>  	spi_message_init(&msg);
>  	spi_message_add_tail(&trans, &msg);
> -	ret =3D spi_sync(ec_spi->spi, &msg);
> +	ret =3D spi_sync_locked(ec_spi->spi, &msg);
> =20
>  	/* Get the response */
>  	if (!ret) {
> @@ -560,6 +563,9 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_de=
vice *ec_dev,
>  	}
> =20
>  	final_ret =3D terminate_request(ec_dev);
> +
> +	spi_bus_unlock(ec_spi->spi->master);
> +
>  	if (!ret)
>  		ret =3D final_ret;
>  	if (ret < 0)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
