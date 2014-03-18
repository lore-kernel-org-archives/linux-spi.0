From: Harini Katakam <harini.katakam@xilinx.com>
Subject: RE: [PATCH] SPI: Add driver for Cadence SPI controller
Date: Tue, 18 Mar 2014 05:16:26 +0000
Message-ID: <255edf4f-05a8-4d9a-b32d-1a4a8ddaffb5@CH1EHSMHS004.ehs.local>
References: <1395057936-8643-1-git-send-email-harinik@xilinx.com>
 <20140317173017.GW11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"rob@landley.net" <rob@landley.net>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Michal Simek <michals@xilinx.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140317173017.GW11706@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, March 17, 2014 11:00 PM
> To: Harini Katakam
> Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; rob@landley.net;
> grant.likely@linaro.org; devicetree@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org; Michal Simek
> Subject: Re: [PATCH] SPI: Add driver for Cadence SPI controller
> 
> On Mon, Mar 17, 2014 at 05:35:36PM +0530, Harini Katakam wrote:
> 
> > +	bits_per_word = transfer ?
> > +			transfer->bits_per_word : spi->bits_per_word;
> 
> This would be a lot more legible without the ternery operator.
> 
> > +	if (bits_per_word != 8) {
> > +		dev_err(&spi->dev, "%s, unsupported bits per word %x\n",
> > +			__func__, spi->bits_per_word);
> > +		return -EINVAL;
> > +	}
> 
> The core will check this for you.

I dint find that the core does this.

> 
> > +static int cdns_spi_setup(struct spi_device *spi) {
> > +	if (!spi->max_speed_hz)
> > +		return -EINVAL;
> > +
> > +	if (!spi->bits_per_word)
> > +		spi->bits_per_word = 8;
> 
> The core does this for you.

I understand that the core does this.

> 
> > +	return cdns_spi_setup_transfer(spi, NULL); }
> 
> It's not clear to me why this has been split into a separate function and the
> function will write to the hardware which you're not allowed to do in
> setup() if it might affect an ongoing transfer.

Are you saying  that there's a chance cdns_spi_setup() will be called when there's an ongoing transfer?
In that case I have to remove the cdns_setup_transfer() call from here but then there's nothing left to do in setup.

The function was split into two because cdns_spi_setup_transfer() is called internally 
by transfer_one_message() everytime.
Is it always possible that the spi_transfer paramters will remain the same;
In that case this call is probably not necessary in transfer_one_message.

> 
> > +	intr_status = cdns_spi_read(xspi->regs + CDNS_SPI_ISR_OFFSET);
> > +	cdns_spi_write(xspi->regs + CDNS_SPI_ISR_OFFSET, intr_status);
> > +
> > +	if (intr_status & CDNS_SPI_IXR_MODF_MASK) {
> > +		/* Indicate that transfer is completed, the SPI subsystem will
> > +		 * identify the error as the remaining bytes to be
> > +		 * transferred is non-zero
> > +		 */
> > +		cdns_spi_write(xspi->regs + CDNS_SPI_IDR_OFFSET,
> > +			       CDNS_SPI_IXR_DEFAULT_MASK);
> > +		complete(&xspi->done);
> > +	} else if (intr_status & CDNS_SPI_IXR_TXOW_MASK) {
> 
> What happens if both interrupts are flagged at the same time?

The MODF is an error interrupt and so if TXOW is raised along with it,
TXOW will be ignored (it will be cleared but no data is read).
Completion is indicated and since the remaining bytes is non-zero,
The transfer function will understand that it is an error.

> 
> > +		if (xspi->remaining_bytes) {
> > +			/* There is more data to send */
> > +			cdns_spi_fill_tx_fifo(xspi);
> > +		} else {
> > +			/* Transfer is completed */
> > +			cdns_spi_write(xspi->regs + CDNS_SPI_IDR_OFFSET,
> > +				       CDNS_SPI_IXR_DEFAULT_MASK);
> > +			complete(&xspi->done);
> > +		}
> > +	}
> 
> I see from further up the file that there are error interrupt states which
> might be flagged but these are just being ignored.

I'm not sure I understand what you are referring to -
The only interrupts enabled (See CNDS_IXR_DEFAULT_MASK) are TXOW and MODF.

> 
> > +
> > +	return IRQ_HANDLED;
> 
> This should only be returned if an interrupt was actually handled - if the line
> is shared in some system this will break.

In this case both possible interrupt conditions are handled.

> 
> > +	cdns_spi_write(xspi->regs + CDNS_SPI_IER_OFFSET,
> > +		       CDNS_SPI_IXR_DEFAULT_MASK);
> > +
> > +	ret = wait_for_completion_interruptible_timeout(&xspi->done,
> > +							CDNS_SPI_TIMEOUT);
> > +	if (ret < 1) {
> 
> If you return a positive value from transfer_one() the core will wait for you.
> 

I don't understand. Here, if the ret from wait_for_completion_interruptible_timeout is
positive, then this function (spi_start_transfer) will return (transfer->len) - (xspi->remaining_bytes)
to cdns_transfer_one_message(the calling funtion). Which will just use this return as
information on how many bytes were transferred (see variable length). 
cdns_transfer_one_messag() only returns 0 or error value (-ve) (see variable status). 
It doesn't return positive value to core.

> > +static int cdns_prepare_transfer_hardware(struct spi_master *master)
> > +{
> > +	struct cdns_spi *xspi = spi_master_get_devdata(master);
> > +
> > +	if (xspi->driver_state != CDNS_SPI_DRIVER_STATE_READY)
> > +		return -EINVAL;
> > +
> > +	cdns_spi_write(xspi->regs + CDNS_SPI_ER_OFFSET,
> > +		       CDNS_SPI_ER_ENABLE_MASK);
> > +
> > +	return 0;
> > +}
> 
> You probably want to enable the clocks here (and disable them when
> unpreparing too).

OK

> 
> > +static int cdns_transfer_one_message(struct spi_master *master,
> > +				     struct spi_message *msg)
> > +{
> 
> Just implement transfer_one() and provide a set_cs() operation and most of
> this code will go away.

I dint realise there was a hook for set_cs(). Yeah I will simplify this.

> 
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		ret = -ENXIO;
> > +		dev_err(&pdev->dev, "irq number is negative\n");
> > +		goto remove_master;
> > +	}
> > +
> > +	ret = devm_request_irq(&pdev->dev, irq, cdns_spi_irq,
> > +			       0, pdev->name, xspi);
> > +	if (ret != 0) {
> > +		ret = -ENXIO;
> > +		dev_err(&pdev->dev, "request_irq failed\n");
> > +		goto remove_master;
> > +	}
> 
> I'd expect to see something that initialises the hardware prior to requesting
> the interrupt, you don't know what state the hardware is in when the driver
> takes control.
> 
> > +	init_completion(&xspi->done);
> 
> This needs to be done prior to the interrupt as well.

I will move the devm_request_irq here.

> 
> > +	ret = of_property_read_u16(pdev->dev.of_node, "num-chip-select",
> > +				   &master->num_chipselect);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "couldn't determine num-chip-
> select\n");
> > +		goto clk_dis_all;
> > +	}
> 
> Is there no reasonable default?

Are you saying if I cant read num-chipselect from dts, 
I should set it to a default (that will be 4) and proceed?

> 
> > +	/* Set to default valid value */
> > +	xspi->speed_hz = clk_get_rate(xspi->ref_clk) / 4;
> 
> The driver should set max_speed_hz as well.

This is the max_speed_hz - 4 is the lowest divisor possible. 2 is invalid.
It is set in init_hw (see config register default mask).

> 
> > +	clk_disable(xspi->ref_clk);
> > +	clk_disable(xspi->pclk);
> 
> Why not unprepare?

I can do that.

Regards,
Harini
