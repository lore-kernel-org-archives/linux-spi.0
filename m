From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH] spi: add spi controller master
 driver for Blackfin 6xx processor
Date: Mon, 3 Jun 2013 15:28:09 +0100
Message-ID: <20130603142809.GJ31367@sirena.org.uk>
References: <1370295814-28723-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8729516517509095576=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1370295814-28723-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============8729516517509095576==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2013 at 05:43:34PM -0400, Scott Jiang wrote:

> +#define START_STATE	((void *)0)
> +#define RUNNING_STATE	((void *)1)
> +#define DONE_STATE	((void *)2)
> +#define ERROR_STATE	((void *)-1)

This looks icky due to the casts.  Why not just store the state in the
driver data for the device, it's not possible to have multiple messages
active at once anyway?

> +static unsigned long sclk;
> +/* Caculate the SPI_CLOCK register value based on input HZ */
> +static u32 hz_to_spi_clock(u32 speed_hz)
> +{
> +	u32 spi_clock = sclk / speed_hz;
> +
> +	if (spi_clock)
> +		spi_clock--;
> +	return spi_clock;
> +}

Just from a style poin of view the global variable here isn't great,
even if it's always global for the system currently it'd be better to
have it in the data structure.

> +static void bfin_spi_pump_transfers(unsigned long data)
> +{

Looking at this I can't help but think there must be more common code we
can factor out but that's a separate thing to adding a new driver.

> +
> +	drv_data->transfer_len = transfer->len;
> +	drv_data->cs_change = transfer->cs_change;
> +
> +	/* Bits per word setup */
> +	bits_per_word = transfer->bits_per_word ? :
> +		message->spi->bits_per_word ? : 8;

This isn't a triumph of legibility and really ought to be factored out
into the core as the same will be true for all SPI transfers.

> +	if (chip->enable_dma) {

> +		return;
> +	}

The pump function is a pretty big function and this if in the middle of
it makes the flow a bit odd.  It would probably be better to split out
DMA and PIO transfer functions and then make this just call whichever is
appropriate.

> +	} else {
> +		/* Update total byte transferred */
> +		message->actual_length += drv_data->transfer_len;
> +		/* Move to next transfer of this msg */
> +		message->state = bfin_spi_next_transfer(drv_data);
> +		if (drv_data->cs_change && message->state != DONE_STATE) {
> +			bfin_spi_flush(drv_data);
> +			bfin_spi_cs_deactive(drv_data, chip);
> +		}
> +	}

It seems like we'd want to deassert /CS even on error but we didn't do
that...

> +	if (spi->bits_per_word != 8
> +		&& spi->bits_per_word != 16
> +		&& spi->bits_per_word != 32) {
> +		dev_err(&spi->dev, "%d bits_per_word is not supported\n",
> +				spi->bits_per_word);
> +		return -EINVAL;
> +	}

Write this as a switch statement.

> +			if (chip_info->control & ~bfin_ctl_reg) {
> +				dev_err(&spi->dev, "do not set bits "
> +					"that the SPI framework manages\n");
> +				goto error;

Don't split error messages over lines.

> +		if (chip->cs < MAX_CTRL_CS) {
> +			chip->ssel = (1 << chip->cs) << 8;
> +			ret = peripheral_request(ssel[spi->master->bus_num]
> +					[chip->cs-1], dev_name(&spi->dev));
> +			if (ret) {
> +				dev_err(&spi->dev, "peripheral_request() error\n");
> +				goto error;
> +			}
> +		} else {
> +			chip->cs_gpio = chip->cs - MAX_CTRL_CS;
> +			ret = gpio_request_one(chip->cs_gpio, GPIOF_OUT_INIT_HIGH,
> +						dev_name(&spi->dev));
> +			if (ret) {
> +				dev_err(&spi->dev, "gpio_request_one() error\n");
> +				goto error;
> +			}
> +		}
> +		spi_set_ctldata(spi, chip);

Why is all this resource allocation not being done in the probe()
function?

> +static irqreturn_t bfin_spi_tx_dma_isr(int irq, void *dev_id)
> +{
> +	struct bfin_spi_master *drv_data = dev_id;
> +	u32 dma_stat = get_dma_curr_irqstat(drv_data->tx_dma);
> +
> +	clear_dma_irqstat(drv_data->tx_dma);
> +	if (dma_stat & DMA_DONE)
> +		drv_data->tx_num++;
> +	if (dma_stat & DMA_ERR)
> +		dev_err(&drv_data->master->dev,
> +				"spi tx dma error: %d\n", dma_stat);
> +	bfin_write_and(&drv_data->regs->tx_control, ~SPI_TXCTL_TDR_NF);
> +	return IRQ_HANDLED;
> +}

This doesn't check that it got a sane state from the hardware - what
happens if neither DMA_DONE nor DMA_ERR is true?  I'd also expect us to
fail the transfer if we get an error state.

> +
> +	dev_info(dev, "bfin-spi probe success\n");

Remove this, it's just noisy.

> +#ifdef CONFIG_PM
> +static int bfin_spi_suspend(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct bfin_spi_master *drv_data = spi_master_get_devdata(master);
> +
> +	spi_master_suspend(master);
> +
> +	drv_data->control = bfin_read(&drv_data->regs->control);
> +	drv_data->ssel = bfin_read(&drv_data->regs->ssel);
> +
> +	bfin_write(&drv_data->regs->control, SPI_CTL_MSTR | SPI_CTL_CPHA);
> +	bfin_write(&drv_data->regs->ssel, 0x0000FE00);
> +	free_dma(drv_data->rx_dma);
> +	free_dma(drv_data->tx_dma);

Why free and reallocate the DMA over suspend?

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrKf2AAoJELSic+t+oim9G8cP/A5bxuje0p5OcsLF8w5gqcGb
yP6TW9ukYyCn/GUAvlsAPQQBzNi2CI2F5ycC7nqTdXxTtiG8AzfyyKKBoVNErwGk
xzvpPDdIlZ+I9t4xgpYEbyrG8DAkBdvuomjKCsaL50uD9G1+S8SdJy4S+SPlulEi
FlCSa/CZ7ZWaR52fUfGuY/CORAPMLl/IljAUp20OfKpWOdg69Z0tlE6tkguU7CS0
MzH/Z/L4NjP59Cunt+F9hPbU5+py7X0jyyIo/igsPnH503HM4YssJ76RiCe2J0Fe
cHH29bv9BoeCqNFraeL/53bRIRo4USKs5J8avOQmtG4Mg40eJ/6OAR79kW8snMq5
w4riFo5XA1YuH5YizvgDKntXA/3cTbQHJSv2hG4f1GHr1qBEQpXsxNOemO97ZWk+
YUpSH9UbMadNBQ6R64+DvoWJG2MHw1/hcYQDjIUb539DxPY/oQZ/n4KY6vFo/Ckn
7qIXup8Vog7wBUM3n8QA9wSZFH3UknJkTLcBLUv460cJGO4BmyUIWJsXWjkOox7w
rILD9cdjK126R+bXLaiYcNOOll+uay0qnxa9dExu13n7+A/6ER7sxM8+fubEYlWf
8oCBENO/+KMthO6SWY75y0y8oDQVEp9iJi+qcYvPFJdNYX9TsF7WCdG1+hIQSveR
dyIJhXcBGJ72ALjMhQID
=yVZG
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--

--===============8729516517509095576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============8729516517509095576==--
