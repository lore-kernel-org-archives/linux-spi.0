From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm-mspi: Add support for Broadcom MSPI driver.
Date: Wed, 13 May 2015 16:49:46 -0700
Message-ID: <5553E31A.8060309@broadcom.com>
References: <1431452293-16697-1-git-send-email-jonathar@broadcom.com> <1431452293-16697-3-git-send-email-jonathar@broadcom.com> <20150512191718.GW3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"Ian Campbell" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512191718.GW3066-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 15-05-12 12:17 PM, Mark Brown wrote:
> On Tue, May 12, 2015 at 10:38:13AM -0700, Jonathan Richardson wrote:
> 
>> +	/* Wait for interrupt indicating transfer is complete. */
>> +	if (!wait_for_completion_timeout(&mspi->xfer_done,
>> +		msecs_to_jiffies(10))) {
> 
> What if we have a large transfer on a slow bus?

I guess it depends on the reference clock frequency (as well as spbr)
which we may not know because I made it optional. I could possibly
calculate it. I'll look into this. I used the slowest possible spbr
based on our ref clock frequency and tested large transfers which never
timed out.

> 
>> +	while (bytes_processed < transfer->len) {
> 
>> +		/* Start transfer and wait until complete. */
>> +		err = bcm_mspi_start_transfer(mspi, !last_slot, slot);
>> +		if (err)
>> +			return err;
> 
> This isn't really start_transfer() is it?  It's doing the entire
> operation.

Yes, the entire operation.

> 
>> +		/* Delay requested amount before next transfer. */
>> +		udelay(transfer->delay_usecs);
>> +	}
> 
> This is buggy, it's applying the per-transfer delay every timme we fill
> the FIFO.

Thanks, I'll fix.
> 
>> +	/* The rx data will go into RXRAM0/1 + last tx length. */
>> +	if (slot + 1 >= NUM_SLOTS)
>> +		mspi->rx_slot = 0;
>> +	else
>> +		mspi->rx_slot = slot + 1;
> 
> How is this going to work for full duplex transfers if we had to fill
> the FIFO more than once?

See below, it's not.

> 
>> +static int bcm_mspi_transfer_one(struct spi_master *master,
>> +	struct spi_device *spidev, struct spi_transfer *transfer)
>> +{
>> +	int err;
>> +
>> +	/* 8 bit transfers only are currently supported. */
>> +	if (transfer->bits_per_word > 8)
>> +		return -ENOTSUPP;
> 
> Tell the core what the device supports and it will check for you.
> 
>> +
>> +	err = bcm_mspi_tx_data(master, spidev, transfer);
>> +	if (err)
>> +		return err;
>> +
>> +	err = bcm_mspi_rx_data(master, spidev, transfer);
>> +	if (err)
>> +		return err;
>> +
>> +	return 0;
>> +}
> 
> I would expect the recieve and transmit operations to be running in
> parallel, not executed one after another, given the need to keep
> manually filling and draining the FIFOs.

The driver was only written with NOR flash in mind as the slave. Since
this is really just half duplex, it works, though it won't with a real
full duplex slave. m25p80 never calls transfer_one with both tx and rx
buffers. The rx bytes that we don't care about from a tx request are
dropped.

We don't have any full duplex slaves so it's a hard to test. I could
possibly re-write this so that tx/rx is interleaved and that should be
good for full duplex or close enough that it won't have to be completely
overhauled should we ever connect a full duplex slave to it. Maybe I
should do that. This came from a pre-existing driver that had the same
limitation.

> 
>> +	struct spi_master *master;
>> +	struct device *dev = &pdev->dev;
>> +	int err;
>> +	struct resource *res;
>> +	unsigned int irq;
>> +
>> +	dev_info(dev, "Initializing BCM MSPI\n");
> 
> Don't spam the logs like this, there's no content in this message.
> 
>> +	master = spi_alloc_master(dev, sizeof(*data));
>> +	if (!master) {
> 
> devm_spi_alloc_master().

This doesn't exist but devm_spi_register_master() does which I used.

> 
>> +	/* Map base memory address. */
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	data->base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(data->base)) {
>> +		dev_err(&pdev->dev, "unable to map base address\n");
> 
> devm_ioremap_resource() will complain for you.
> 

Thanks,
Jon
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
