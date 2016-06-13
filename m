From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [V3, 2/4] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Mon, 13 Jun 2016 11:13:52 +0100
Message-ID: <20160613101352.GF2282@sirena.org.uk>
References: <1465589171-25575-1-git-send-email-kdasu.kdev@gmail.com>
 <1465589171-25575-2-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b/1LfoxmgmdMg2Yp"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1465589171-25575-2-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--b/1LfoxmgmdMg2Yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 10, 2016 at 04:06:09PM -0400, Kamal Dasu wrote:

> +/* Read qspi controller register*/
> +static inline u32 bcm_qspi_read(struct bcm_qspi *qspi, enum base_type type,
> +				   unsigned int offset)
> +{
> +	if (!qspi->base[type])
> +		return 0;
> +
> +	/*
> +	 * MIPS endianness is configured by boot strap, which also reverses all
> +	 * bus endianness (i.e., big-endian CPU + big endian bus ==> native
> +	 * endian I/O).
> +	 *
> +	 * Other architectures (e.g., ARM) either do not support big endian, or
> +	 * else leave I/O in little endian mode.
> +	 */
> +	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +		return __raw_readl(qspi->base[type] + offset);

You shouldn't use raw accessors outside of arch code.  Use ioread32be()
to read big endian values, and similarly for the writes.

> +	if (!qspi->base[INTR])
> +		return;

All these bits where we just silently ignore operations if some value
isn't initialized are a bit worrying - why is this safe and robust?  I'd
expect chip feature selection to be done at a higher level.

> +
> +	if (qspi->hif_spi_mode)
> +		bcm_qspi_write(qspi, INTR, HIF_SPI_INTR2_CPU_MASK_CLEAR, mask);
> +	else {

Coding style { } on both sides of the if if they're on one.

> +static void bcm_qspi_bspi_lr_data_read(struct bcm_qspi *qspi)
> +{
> +	u32 *buf = (u32 *)qspi->bspi_xfer->rx_buf;
> +	u32 data = 0;
> +
> +	DBG("xfer %p rx %p rxlen %d\n",
> +	    qspi->bspi_xfer, qspi->bspi_xfer->rx_buf, qspi->bspi_xfer_len);

Use the standard kernel trace infrastructure, don't invent your own.

> +static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi, int width,
> +				       int addrlen, int hp)
> +{
> +	int bpc = 0, bpp = 0;
> +	u8 command = SPINOR_OP_READ_FAST;
> +	int flex_mode = 1, rv = 0;
> +	bool spans_4byte = false;
> +
> +	DBG("set flex mode w %x addrlen %x hp %d\n", width, addrlen, hp);
> +
> +	if (addrlen == BSPI_ADDRLEN_4BYTES) {
> +		bpp = BSPI_BPP_ADDR_SELECT_MASK;
> +		spans_4byte = true;
> +	}
> +
> +	bpp |= 8; /* dummy cycles */

Dummy cycles?

> +	default:
> +		rv = -1;

Real error codes please.

> +	if (!error) {
> +		qspi->xfer_mode.width = width;
> +		qspi->xfer_mode.addrlen = addrlen;
> +		qspi->xfer_mode.hp = hp;
> +		dev_info(&qspi->pdev->dev,
> +			"%d-lane output, %d-byte address%s\n",
> +			qspi->xfer_mode.width,
> +			qspi->xfer_mode.addrlen,
> +			qspi->xfer_mode.hp ? ", high-performance mode" : "");

This is far too noisy, it's going to spam the logs on every transfer.

> +	} else
> +		dev_warn(&qspi->pdev->dev,
> +			"INVALID COMBINATION: width=%d addrlen=%d hp=%d\n",
> +			width, addrlen, hp);

Why isn't this returning an error?

> +static int bcm_qspi_update_parms(struct bcm_qspi *qspi,
> +				 struct spi_device *spidev,
> +				 struct spi_transfer *trans, int override)
> +{
> +	struct bcm_qspi_parms xp;
> +
> +	xp.speed_hz = min(trans->speed_hz ? trans->speed_hz :
> +			(spidev->max_speed_hz ? spidev->max_speed_hz :
> +			qspi->max_speed_hz), qspi->max_speed_hz);

This is marginally legible, and you should just be able to trust what's
in the transfer anyway as the core should be doing this - there's
nothing device specific.

> +	if ((override == PARMS_OVERRIDE) ||
> +		((xp.speed_hz == qspi->last_parms.speed_hz) &&
> +		 (xp.chip_select == qspi->last_parms.chip_select) &&
> +		 (xp.mode == qspi->last_parms.mode) &&
> +		 (xp.bits_per_word == qspi->last_parms.bits_per_word))) {
> +		bcm_qspi_hw_set_parms(qspi, &xp);
> +		return 0;
> +	}
> +	/* no override, and parms do not match */
> +	return 1;

What is an override

> +static int find_next_byte(struct bcm_qspi *qspi, struct position *p,
> +			  int flags)
> +{
> +	int ret = FNB_BREAK_NONE;

What is this supposed to be doing?

> +	/* deassert CS on the final byte */
> +	if (fnb & FNB_BREAK_DESELECT) {
> +		mspi_cdram = read_cdram_slot(qspi, slot - 1) &
> +			~MSPI_CDRAM_CONT_BIT;
> +		write_cdram_slot(qspi, slot - 1, mspi_cdram);
> +	}

Let the core handle asserting and deasserting chip select.

> +/* BSPI helpers */
> +static int bcm_qspi_emulate_flash_read(struct bcm_qspi *qspi,
> +			       struct spi_device *spi, struct spi_transfer *t)
> +{
> +	u32 addr, len, len_words;
> +	u8 *buf;

What is this doing?  This seems very worrying...

> +	if (trans && trans->len && trans->tx_buf) {
> +		u8 command = ((u8 *)trans->tx_buf)[0];
> +
> +		if (trans->rx_nbits)
> +			nbits = trans->rx_nbits;
> +
> +		switch (command) {
> +		case SPINOR_OP_READ4_FAST:
> +			if (!bcm_qspi_is_4_byte_mode(qspi))

No, this is not a good idea. You should not be attempting to parse
the data stream.  If your controller has flash support it should
implement the flash interfaces, otherwise it should just pass the data
streams through.

> +static int bcm_qspi_transfer_one_message(struct spi_master *master,
> +		 struct spi_message *msg)

Implement transfer_one(), not transfer_one_message().

> +static int bcm_qspi_simple_transaction(struct bcm_qspi *qspi,
> +	const void *tx_buf, int tx_len, void *rx_buf, int rx_len)
> +{
> +
> +	struct bcm_qspi_parms *xp = &qspi->last_parms;
> +	struct spi_message m;
> +	struct spi_transfer t_tx, t_rx;
> +	struct spi_device spi;
> +	int ret;
> +
> +	memset(&spi, 0, sizeof(spi));
> +	spi.max_speed_hz = xp->speed_hz;
> +	spi.chip_select = xp->chip_select;
> +	spi.mode = xp->mode;
> +	spi.bits_per_word = xp->bits_per_word;
> +	spi.master = qspi->master;
> +
> +	spi_message_init(&m);
> +	m.spi = &spi;

I don't know why your driver is creating and trying to do SPI transfers
but that is completely inappropriate for a SPI controller.  Whatever
functionality this is implementing should be in a separate SPI device
driver.

> +static const struct of_device_id bcm_qspi_of_match[] = {
> +	{ .compatible = "brcm,spi-bcm-qspi" },
> +	{ .compatible = "brcm,qspi-brcmstb" },
> +	{ .compatible = "brcm,spi-brcmstb-mspi"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bcm_qspi_of_match);

This is adding new DT bindings but there is no documentation,
documentation is required for all DT bindings.

> +static struct platform_driver bcm_qspi_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.bus = &platform_bus_type,
> +		.owner = THIS_MODULE,

You don't need to initalize bus or owner.

> +MODULE_AUTHOR("Broadcom");

This should be a person if it's going to be included.

--b/1LfoxmgmdMg2Yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXXodfAAoJECTWi3JdVIfQVPgH/jnOOhXnUBjAeRte72qycEop
y/n+UqFBnIGzk/SZyHhTNqpVMEVPapXcqW38VvHAdZVB9nWVAx5ShtzJm8G1GUZG
p45TaZ4exjEJ0Y1e7ywkodIiqpaJH/mkJLTKQe0GdhSDOG1/HO1C2+4+da2/yYEs
nTM20PMyss90XSYDnYzPl/hPRIIyEka7UF0n19KvEYUCMrypJt+svLXmywG8+l6Z
K5kH+V4vUPpUo6z3B57FVBS+8nlcLM3wcgM8YDjjACoXBwaGPsSJCyFRQKd7EGMW
LugcWa0bSklKE3j8epfqLcBrVeLxxlM7SSuTMXNwv51qaXu58uRK3paWFWVrjMY=
=1Jg5
-----END PGP SIGNATURE-----

--b/1LfoxmgmdMg2Yp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
