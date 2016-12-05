From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/5] spi: Add basic support for Armada 3700 SPI
 Controller
Date: Mon, 5 Dec 2016 12:05:40 +0000
Message-ID: <20161205120540.mvihgafelszitzhq@sirena.org.uk>
References: <20161201102719.4291-1-romain.perier@free-electrons.com>
 <20161201102719.4291-2-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2122375953554878701=="
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>,
 devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 linux-spi@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>,
 Gregory Clement <gregory.clement@free-electrons.com>, xigu@marvell.com,
 dingwei@marvell.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Romain Perier <romain.perier@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161201102719.4291-2-romain.perier@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============2122375953554878701==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j5bleiip5j6gh5xe"
Content-Disposition: inline


--j5bleiip5j6gh5xe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 01, 2016 at 11:27:15AM +0100, Romain Perier wrote:

> +config SPI_ARMADA_3700
> +	tristate "Marvell Armada 3700 SPI Controller"
> +	depends on ARCH_MVEBU && OF

Why does this not have a COMPILE_TEST dependency?

> +	/* Reset SPI unit */
> +	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
> +	val |= A3700_SPI_SRST;
> +	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
> +
> +	for (i = 0; i < A3700_SPI_TIMEOUT; i++)
> +		udelay(1);

Why not just do a single udelay()?

> +static irqreturn_t a3700_spi_interrupt(int irq, void *dev_id)
> +{
> +	struct spi_master *master = dev_id;
> +	struct a3700_spi *a3700_spi;
> +	u32 cause;
> +
> +	a3700_spi = spi_master_get_devdata(master);
> +
> +	/* Get interrupt causes */
> +	cause = spireg_read(a3700_spi, A3700_SPI_INT_STAT_REG);
> +
> +	/* mask and acknowledge the SPI interrupts */
> +	spireg_write(a3700_spi, A3700_SPI_INT_MASK_REG, 0);
> +	spireg_write(a3700_spi, A3700_SPI_INT_STAT_REG, cause);
> +
> +	/* Wake up the transfer */
> +	if (a3700_spi->wait_mask & cause)
> +		complete(&a3700_spi->done);
> +
> +	return IRQ_HANDLED;
> +}

This reports that we handled an interrupt even if we did not in fact
handle an interrupt.  It's also a bit dodgy that it doesn't check what
the interrupt was but that's less serious.

> +	master->bus_num = (pdev->id != -1) ? pdev->id : 0;

At most this should be just setting the bus number to pdev->id like
other drivers do.

> +	ret = clk_prepare_enable(spi->clk);
> +	if (ret) {
> +		dev_err(dev, "could not prepare clk: %d\n", ret);
> +		goto error;
> +	}

I'd expect the hardware prepare/unprepare to be managing the enable and
disable of the clock in order to save a little power.

> +	dev_info(dev, "Marvell Armada 3700 SPI Controller at 0x%08lx, irq %d\n",
> +		 (unsigned long)res->start, spi->irq);

This is just adding noise to the boot, remove it.  It's not telling us
anything we read from the hardware or anything.

--j5bleiip5j6gh5xe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhFWBMACgkQJNaLcl1U
h9AUHgf/Qy+NSqFcO8jSBzNf1kG5hAHuZZ8VFLjes4BVTw6giMSbLmAQXvIwVjXN
3lgV9PPNyTL06L9Zi09aMp0IPcGhv7G0C3r2e9pSsCg5ZoU1mpKKzrr9E2wCrO/p
NjpYuFLKbBDXVQQcc+kQSF+ravjPObMpqqLvRw4CRfSoBJexs602lBhx5Bp6L40o
ztY9bJICZyhwPPqE9DlO2vqOS8VkfCQDi3hLqgldvodTAudkdKfofUYW3LPmq0W9
8OfV1uX+mnLOxhHcFaTwI3gPxiRYzVB0TQdtQKpDCLbpAnrh1nIBgBXIcpC1XO+7
Q4rU2Ku5/5zTUeNvoJfvdGQOv7iwyA==
=2hjl
-----END PGP SIGNATURE-----

--j5bleiip5j6gh5xe--


--===============2122375953554878701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2122375953554878701==--
