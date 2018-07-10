From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: Introduce new driver for Qualcomm QuadSPI
 controller
Date: Tue, 10 Jul 2018 19:10:24 +0100
Message-ID: <20180710181024.GF8104@sirena.org.uk>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
 <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, sdharia@codeaurora.org,
        kramasub@codeaurora.org, boris.brezillon@bootlin.com
To: Girish Mahadevan <girishm@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2018 at 03:46:42PM -0600, Girish Mahadevan wrote:

Overall this looks pretty good, but there were a few small issues
(mostly cosmetic):

> +	/*
> +	 * Ensure that the configuration goes through by reading back
> +	 * a register from the IO space.
> +	 */
> +	mb();
> +	mstr_cfg = readl_relaxed((ctrl->base + MSTR_CONFIG));
> +	pm_runtime_put_sync(ctrl->dev);
> +	return ret;

There's no need to use _put_sync() unless you *really* need the put to
go through immediately, if you don't need it then it'll just slow things
down.

> +	wr_cnts = (rd_fifo_status & WR_CNTS_MSK) >> WR_CNTS_SHFT;
> +	fifo_rdy = (rd_fifo_status & FIFO_RDY) ? true : false;
> +
> +	if (!fifo_rdy) {
> +		dev_dbg(ctrl->dev, "%s: Spurious IRQ 0x%x",
> +			__func__, rd_fifo_status);
> +		return IRQ_NONE;
> +	}

Please just use a normal if statement, it's easier to read.

> +	wr_fifo_bytes =
> +	readl_relaxed(ctrl->base + PIO_XFER_STATUS) >> WR_FIFO_BYTES_SHFT;

Just use something like

+	wr_fifo_bytes = readl_relaxed(ctrl->base + PIO_XFER_STATUS)
+				>> WR_FIFO_BYTES_SHFT;

Again, more legible.

> +static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
> +{
> +	u32 int_status;
> +	struct qcom_qspi *ctrl = dev_id;
> +	irqreturn_t ret = IRQ_HANDLED;
> +
> +	int_status = readl_relaxed(ctrl->base + MSTR_INT_STATUS);
> +	writel_relaxed(int_status, ctrl->base + MSTR_INT_STATUS);
> +
> +	if (int_status & WR_FIFO_EMPTY)
> +		ret = pio_write(ctrl);
> +
> +	if (int_status & RESP_FIFO_RDY)
> +		ret = pio_read(ctrl);

What if both bits are set and return different statuses?

> +static bool qcom_qspi_supports_op(struct spi_mem *mem,
> +				const struct spi_mem_op *op)
> +{
> +	return true;
> +}

So we definitely support all possible ops?

> +static int qcom_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	return 0;
> +}

If this can be empty it's prboably better to fix the callers so that
they don't need to provide it (looking at the code it seems that this is
already the case so you can just remove it).

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltE9o8ACgkQJNaLcl1U
h9Af6AgAhCnYFi9h43XiBkYpYNKmd7XeTJGQ21ygOwJlATmULtetPdNv88OcqPdF
aNde7s8cGb9A218XkK2MtcavF98V2OnBTFWcogmURmkHos4uDKBkCW3UfIgMLL98
KwhE2Tcpv15XCOet9Cfoc/PNG7BurxRBbJnkT9+BhddlFfg9lP3I8y6OMkKqeX/O
Vl3ntT0oChMcR9oLI+KOsKVAmnJs1rF5mM1GGAuyhOZ4l9SgBBJGJHBYJ6Y+0fa+
LOCvPYAcPpybHi5rIoGp1scxIOb7oBR2nQc8SVwGc+1LP+6LITBwt04GbjqDeTQH
U/Yxwzy/SfjpoxU7krZWm/tmihN5LQ==
=IKH9
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
