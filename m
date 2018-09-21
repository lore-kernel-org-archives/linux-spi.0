From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: Introduce new driver for Qualcomm QuadSPI
 controller
Date: Fri, 21 Sep 2018 09:31:34 -0700
Message-ID: <20180921163134.GD20825@sirena.org.uk>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <20180920224055.164856-2-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180920224055.164856-2-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 20, 2018 at 03:40:55PM -0700, Ryan Case wrote:

> +static int qcom_qspi_setup(struct spi_device *spi)
> +{

> +	/*
> +	 * Ensure that the configuration goes through by reading back
> +	 * a register from the IO space.
> +	 */
> +	mstr_cfg = readl(ctrl->base + MSTR_CONFIG);

Your setup() function shouldn't be affecting the status of the hardware
for any other SPI devices using the controller, otherwise it might
disturb an active transfer.  prepare_message() is typically the best
place to do this stuff.

Otherwise this looks good.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlulHOUACgkQJNaLcl1U
h9AQAgf/Zh+oen4pzwNai7h7WkEDetUqq8QAgw3/J0FeM13RQmJLz0TTqfn7mKGD
5BbkdhnehODoAedL7aZEImHgmp5rx/IcUlqixyeDDkZaAPpXRqNEQuAJKNGlZWWG
MpedK4gy41VbTEfDTPEYIvFzA6MoPrF/yA96qC6g6RgGWR4QpO+8DbXsFeyoxH9u
h48XP4ttP2Cwz1mn+KpdblKH8MZnXZM2JuDEHfoQsxNtmLInWhISVFvh5/qx2JbG
GPhXkkaBoD0S5vzvf09Fcc4g/L2Va4c/MqZ7dzmYtXD6br8UYRZ8cawEcpj+Atdu
eajQ1OiCkL6TEjJz0yJ9iGzeGUJbzw==
=l2cj
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
