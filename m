From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] spi: Add MXIC controller driver
Date: Mon, 1 Oct 2018 16:35:01 +0100
Message-ID: <20181001153501.GD19099@sirena.org.uk>
References: <1538120112-15530-1-git-send-email-masonccyang@mxic.com.tw>
 <1538120112-15530-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Cc: tpiepho@impinj.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538120112-15530-2-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 28, 2018 at 03:35:11PM +0800, masonccyang@mxic.com.tw wrote:

This looks mostly good, a couple of fairly small things:

> +static int mxic_spi_clk_enable(struct mxic_spi *mxic)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(mxic->send_clk);
> +	if (ret)
> +		goto err_send_clk;
> +
> +	ret = clk_prepare_enable(mxic->send_dly_clk);
> +	if (ret)
> +		goto err_send_dly_clk;
> +
> +	return ret;
> +
> +err_send_dly_clk:
> +	clk_disable_unprepare(mxic->send_dly_clk);
> +err_send_clk:
> +	clk_disable_unprepare(mxic->send_clk);

You should only undo operations that succeeded in the error path, if
something failed you don't need to revert it.

> +static int mxic_spi_setup(struct spi_device *spi)
> +{
> +	struct mxic_spi *mxic = spi_master_get_devdata(spi->master);
> +	unsigned long freq = spi->max_speed_hz;
> +	int ret;
> +
> +	ret = clk_set_rate(mxic->send_clk, freq);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_set_rate(mxic->send_dly_clk, freq);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * A constant delay range from 0x0 ~ 0x1F for input delay,
> +	 * the unit is 78 ps, the max input delay is 2.418 ns.
> +	 */
> +	mxic_spi_set_input_delay_dqs(mxic, 0xf);

This is changing the hardware state for all slaves, not just the device
being configured - setup() isn't supposed to do that (yes, it's a
confusing API but unfortunately a legacy one that'll be a pain to clean
up).  prepare_transfer_hardware() is usually a better place to do this.

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluyPqQACgkQJNaLcl1U
h9D+OAf+OsIceza4zPHL128gdHi4SlAfaeWnDUGRfFSOdl18iGjgRQC+7WpCexxK
qMYJ5/rdWJYZp5PunuGP2c9shVpCwLjfvfWRnAGPkvIhTrF1YlLH3weDDemaHg9p
YsyCdRzj9lrQes2LixuTk1YmET3BncPCEMQ+1dV9cNP9TlY6UrTfiBloMOfgWtrJ
eYL8i3dXnpuyXhT47xdeuX5s0gbhumZK8R4cQvFnVg34ctQiekn9RRLs0RtmDwIZ
PyJ7FFjn+llo2X72XrmUl3sGUadsF5UEDrW0F1aCmH4n4VaaAnk5XhoaT3EiLHVr
gHjBC7zA5IIrmJVnYcPNwa99s2N7Iw==
=AGZk
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
