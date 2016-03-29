From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: spi-pic32: Add PIC32 SPI master driver
Date: Tue, 29 Mar 2016 17:32:41 +0530
Message-ID: <56FA6EE1.3000405@microchip.com>
References: <1458740576-9168-1-git-send-email-purna.mandal@microchip.com>
 <1458740576-9168-2-git-send-email-purna.mandal@microchip.com>
 <20160328192629.GG2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
	Joshua Henderson <digitalpeer-icZdIMMiY0PM6KjX8ROVJw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160328192629.GG2350-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/29/2016 12:56 AM, Mark Brown wrote:

> On Wed, Mar 23, 2016 at 07:12:56PM +0530, Purna Chandra Mandal wrote:
>
>> +	switch (bits_per_word) {
>> +	default:
>> +	case 8:
> Are you sure that all bits per word settings other than those explicitly
> supported should be handled in exactly the same fashion as 8 bits per
> word?  That doesn't seem entirely expected.  I'd expect the default to
> be to return an error.

ack. Will treat default case as error.

>> +static int pic32_spi_prepare_message(struct spi_master *master,
>> +				     struct spi_message *msg)
>> +{
>> +	struct spi_device *spi = msg->spi;
>> +	struct spi_transfer *xfer;
>> +	struct pic32_spi *pic32s;
>> +
>> +	pic32s = spi_master_get_devdata(master);
>> +
>> +	pic32s->mesg = msg;
>> +	pic32_spi_disable_chip(pic32s);
>> +
>> +	if (!pic32_spi_debug)
>> +		return 0;
> This appears to be some half implemented debugging code which is never
> enabled, please remove it.

ack. Will remove the debug logic.

>> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>> +		dev_dbg(&spi->dev, "  xfer %p: len %u tx %p rx %p\n",
>> +			xfer, xfer->len, xfer->tx_buf, xfer->rx_buf);
>> +		print_hex_dump(KERN_DEBUG, "tx_buf ",
>> +			       DUMP_PREFIX_ADDRESS,
>> +			       16, 1, xfer->tx_buf,
>> +			       min_t(u32, xfer->len, 16), 1);
>> +	}
> Similarly here, the core already has extensive trace stuff in it which
> you can use.

Will remove.

>> +	/* transact by DMA mode */
>> +	if (transfer->rx_sg.nents && transfer->tx_sg.nents) {
>> +		ret = pic32_spi_dma_transfer(pic32s, transfer);
>> +		if (ret) {
>> +			dev_err(&spi->dev, "dma submit error\n");
>> +			return ret;
>> +		}
>> +
>> +		/* DMA issued, wait for completion */
>> +		set_bit(PIC32F_DMA_ISSUED, &pic32s->flags);
>> +		goto out_wait_for_xfer;
>> +	}
> ...
>
>> +
>> +out_wait_for_xfer:
> Please write normal code with an if/else rather than using gotos, it's a
> lot easier to follow.

Make sense. Will use if-else.

>> +	pic32s = spi_master_get_devdata(master);
>> +
>> +	pic32_spi_disable_chip(pic32s);
> Do we really need tod isable the hardware after every single message?
> It's normally more efficient to just leave the hardware powered until it
> goes idle and unprepare_transfer_hardware() is called.
>
Ack. There is no particular need to disable h/w per message.
Will instead implement prepare/unprepare_transfer_hardware() and add there.

>> +	/* SPI master supports only one spi-device at a time.
>> +	 * So multiple spi_setup() to different devices is not allowed.
>> +	 */
>> +	if (unlikely(pic32s->spi_dev && (pic32s->spi_dev != spi))) {
> unlikely() is for fast paths, outside of them it's just noise.

ack.

>> +	/* But spi_setup() can be called multiple times by same device.
>> +	 * In that case stop current on-going transaction and release
>> +	 * resource(s).
>> +	 */
>> +	if (pic32s->spi_dev == spi)
>> +		pic32_spi_cleanup(spi);
> This is broken, it will break in progress transfers.  setup() shouldn't
> be doing anything that disrupts them, anything that can't be run when
> other transfers are in progress needs to be deferred till we actually do
> the transfers (or done earlier in probe).

Normally setup() and cleanup() are called in-pair by spi-client driver.
In these cases the above condition won't met and will not be a problem.

It is required for MMC-over-SPI support. Linux MMC_SPI driver sometimes
(depending on some logic) want chip-select to be kept enabled (using
transfer.cs_change) even at the end of SPI message so that following
message(s) can also be made part of the running MMC transaction.
In this case if there is any error (and in some other cases as well)
MMC_SPI will have to terminate on-going MMC transactions and it is
done by calling setup(). It is assumed that setup() will always leave
the chip-select deactivated.

Reference from drivers/mmc/host/mmc_spi.c:
-------------------
/*
 * MMC-over-SPI protocol glue, used by the MMC stack interface
 */

static inline int mmc_cs_off(struct mmc_spi_host *host)
{
        /* chipselect will always be inactive after setup() */
        return spi_setup(host->spi);
}
----------------

Best thing I can add is wait for unprepare_message() before calling
cleanup().

If you could suggest better alternative that will be great.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
