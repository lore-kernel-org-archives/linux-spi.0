From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/8] spi: bcm-qspi: Add BSPI spi-nor flash controller
 driver
Date: Tue, 16 Aug 2016 19:31:48 +0100
Message-ID: <20160816183148.GZ9347@sirena.org.uk>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-4-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DHs1QIiRxKbdokJu"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vigneshr-l0cyMroinI0@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469830393-13295-4-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DHs1QIiRxKbdokJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 29, 2016 at 06:13:08PM -0400, Kamal Dasu wrote:

> +	bcm_qspi_bspi_lr_start(qspi);
> +	/* Must flush previous writes before starting BSPI operation */
> +	mb();
> +	if (!wait_for_completion_timeout(&qspi->bspi_done, timeo)) {

The comment suggests that the memory barrier is misplaced or that
there's something missing?

> +		if (retry--)
> +			goto retry;

Please write loops using normal C looping constructs rather than goto
statements, it makes life a lot easier.  I'm not convinced that the loop
is safe as is with the completion reinitializaiton and so on, we should
at least be turning off the hardware before we reinitialize the
completion to avoid races with slow hardware.

> +	io_width =3D msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;

Normal if statements please.

> +static irqreturn_t bcm_qspi_bspi_lr_err_l2_isr(int irq, void *dev_id)
> +{
> +	struct bcm_qspi_dev_id *qspi_dev_id =3D dev_id;
> +	struct bcm_qspi *qspi =3D qspi_dev_id->dev;
> +
> +	dev_dbg(&qspi->pdev->dev, "BSPI INT error status %x\n",
> +		qspi_dev_id->irqp->mask);

I'd expect this to be dev_err() or something, but then the message
claims this an error status and it doesn't seem to actually read that
=66rom the hardware.

> +#ifdef  QSPI_INT_DEBUG
> +	/* this interrupt is for debug purposes only, dont request irq */
> +	{
> +		.irq_name =3D "spi_lr_overread",
> +		.irq_handler =3D bcm_qspi_bspi_lr_err_l2_isr,
> +		.mask =3D INTR_BSPI_LR_OVERREAD_MASK,
> +	},
> +#endif

Why not?

--DHs1QIiRxKbdokJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXs1wTAAoJECTWi3JdVIfQ3tEH+gP9lEDqm9XEpD9qI7bAvp0o
is104GEg/78Q1Y7yGtLzAxg0G+jc3ola6z2st5xGzCQvaa16HX+eyM8LWfRz69w5
LNceCHkWD0ynkg4qlDkSRbhb1PLQxFRPLNVURmDsVDSgpCyQybjoUfSMdCMVLlfR
sahuj+pNRwZVau8ZrJop3rrSuGr6rlwNhfb97W+JTdfRoAzhDQ+FROCbNBrG7MQb
iWsp81B90UChvK1Ov/vtWNPpruTgeplbQabr9j2HTfLj0eFbNiUQDm1B+8pCgazO
QdDDh+rCG2jI+3mKYyu+u1yZ7h8BekejUwMc2R0QdN/P1qju6V5MHKPXGnmNOkA=
=qbUO
-----END PGP SIGNATURE-----

--DHs1QIiRxKbdokJu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
