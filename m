From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] spi: add driver for BCM2835
Date: Wed, 6 Mar 2013 12:05:22 +0800
Message-ID: <20130306040520.GA4896@opensource.wolfsonmicro.com>
References: <1362538142-19246-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2275379084888962359=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1362538142-19246-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============2275379084888962359==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2013 at 07:49:02PM -0700, Stephen Warren wrote:

> +Optional properties:
> +- brcm,realtime: Boolean. Indicates the driver should operate with realtime
> +  priority to minimise the transfer latency on the bus.

This isn't obviously something that ought to be in DT, it'll depend on
the OS, kernel version and so on.  Indeed I don't think this is used any
more as the generic pump code Linus did handles it already in a runtime
tunable way?

> +static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
> +{

> +	if (cs & BCM2835_SPI_CS_DONE) {

> +		}
> +	} else if (cs & BCM2835_SPI_CS_RXR) {
> +		/* read 12 bytes of data */

I'd feel happier if these were independent statements in case both are
asserted simultaneously.

> +	return IRQ_HANDLED;


What if neither of the statuses asserted?

> +	switch (bpw) {
> +	case 8:
> +		break;
> +	default:
> +		dev_err(&spi->dev, "unsupported bits_per_word=%d\n", bpw);
> +		return -EINVAL;
> +	}

> +	if (!(spi->mode & SPI_NO_CS) &&
> +			(spi->chip_select > spi->master->num_chipselect)) {
> +		dev_err(&spi->dev,
> +				"invalid chipselect %u\n",
> +				spi->chip_select);
> +		return -EINVAL;
>` +	}

This seems like stuff the core should be able to do for you.

> +	list_for_each_entry(tfr, &mesg->transfers, transfer_list) {
> +		err = bcm2835_spi_check_transfer(spi, tfr);
> +		if (err)
> +			goto out;
> +
> +		err = bcm2835_spi_start_transfer(spi, tfr);
> +		if (err)
> +			goto out;
> +
> +		timeout = wait_for_completion_timeout(&bs->done,
> +				msecs_to_jiffies(BCM2835_SPI_TIMEOUT_MS));
> +		if (!timeout) {
> +			err = -ETIMEDOUT;
> +			goto out;
> +		}

But I wanted to transfer 10G in a single message at 1kHz!  :P

> +	/* initialise the hardware */
> +	clk_prepare_enable(bs->clk);
> +	bcm2835_wr(bs, BCM2835_SPI_CS,
> +		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);

It'd be nice to only enable the clock during transfers.

> +static int bcm2835_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct bcm2835_spi *bs = spi_master_get_devdata(master);
> +
> +	spi_unregister_master(master);
> +	free_irq(bs->irq, master);

Should these be the other way around?

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNsBlAAoJELSic+t+oim9kAIQAIw3cAZSzL3iBWDhPcM815Ln
Umn0dwS2fBzEsXjsbNTlKDa3QlixFGF0wu04S4gmbnOEKFMwRq+Kosi7a0UR1Yxo
MrGVi1wwph63GRkbOd3jYnmusq5ld+w+kk7+v8lsK3Sy1ZL+dfJdjASv6SeJSUcr
dhQ3fTEbjHvhnl4ADHztDiG+zRI3syYunHiiS5YVYbZAiVPmB3QvCnH6tyz4DUSn
rwctHPpH209zplY1z0M0SKWTJcUOl95c+4WJAYxGpSPHlrpqv1P8urpnx1T+PUpt
kDndMSQVZbs2l8XZOn6yd2lTjaoB+aIhj8SSLb8RZdTbirEfqkzDrYjY77xqz21e
iWMf+H7r1AzVDdYfKW2qJ5pjE6D3z38IhkZjtOlYcaYrCT9NE0Z14H+LQs8NpqOy
tYKFQ72NrJaEk7TIbDBG8Ah9kv3zUWg5300EnU+qSdTf+vnT8eAhJWP/krxSPvFu
u+s1pTr/99Yii2TA0WmKS6/CJ0zSvrokoN8ylYoEs1h7XsNo+BYbR8NTCZIFh0Ju
ntLhbgM+ZjKb/nGaZnrWemJTGSU8Buqx8+0uWEBBiL8ADVF0LgZ4EvcxYTtpGgLy
nPlANFD00QkyUE+5dco0xjMCbnTuVpPC9VtekW2uSW0uaBKUYV7JCIRv9GBYrBsA
4DthO7bmnMRxuZ82C8u8
=ZVgG
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--


--===============2275379084888962359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============2275379084888962359==--
