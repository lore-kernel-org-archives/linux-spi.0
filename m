From: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [V3, 2/4] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Tue, 14 Jun 2016 11:43:56 -0400
Message-ID: <CAKekbesr2i3N+yw0VV1aYqJONbBraKTNpibzm7NO_+sBbwENyw@mail.gmail.com>
References: <1465589171-25575-1-git-send-email-kdasu.kdev@gmail.com>
 <1465589171-25575-2-git-send-email-kdasu.kdev@gmail.com> <20160613101352.GF2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160613101352.GF2282-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark,

My comments are inline.

On Mon, Jun 13, 2016 at 6:13 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jun 10, 2016 at 04:06:09PM -0400, Kamal Dasu wrote:
>
>> +/* Read qspi controller register*/
>> +static inline u32 bcm_qspi_read(struct bcm_qspi *qspi, enum base_type type,
>> +                                unsigned int offset)
>> +{
>> +     if (!qspi->base[type])
>> +             return 0;
>> +
>> +     /*
>> +      * MIPS endianness is configured by boot strap, which also reverses all
>> +      * bus endianness (i.e., big-endian CPU + big endian bus ==> native
>> +      * endian I/O).
>> +      *
>> +      * Other architectures (e.g., ARM) either do not support big endian, or
>> +      * else leave I/O in little endian mode.
>> +      */
>> +     if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>> +             return __raw_readl(qspi->base[type] + offset);
>
> You shouldn't use raw accessors outside of arch code.  Use ioread32be()
> to read big endian values, and similarly for the writes.
>

Will fix this.
,
>> +     if (!qspi->base[INTR])
>> +             return;
>
> All these bits where we just silently ignore operations if some value
> isn't initialized are a bit worrying - why is this safe and robust?  I'd
> expect chip feature selection to be done at a higher level.
>

The driver can work if  interrupt controller driver is used, in that
case the interrupt and status registers are handled by the controller
driver. I can change to have this check at a higher level.

>> +
>> +     if (qspi->hif_spi_mode)
>> +             bcm_qspi_write(qspi, INTR, HIF_SPI_INTR2_CPU_MASK_CLEAR, mask);
>> +     else {
>
> Coding style { } on both sides of the if if they're on one.
>

Will fix this.

>> +static void bcm_qspi_bspi_lr_data_read(struct bcm_qspi *qspi)
>> +{
>> +     u32 *buf = (u32 *)qspi->bspi_xfer->rx_buf;
>> +     u32 data = 0;
>> +
>> +     DBG("xfer %p rx %p rxlen %d\n",
>> +         qspi->bspi_xfer, qspi->bspi_xfer->rx_buf, qspi->bspi_xfer_len);
>
> Use the standard kernel trace infrastructure, don't invent your own.

Ok will do.

>> +static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi, int width,
>> +                                    int addrlen, int hp)
>> +{
>> +     int bpc = 0, bpp = 0;
>> +     u8 command = SPINOR_OP_READ_FAST;
>> +     int flex_mode = 1, rv = 0;
>> +     bool spans_4byte = false;
>> +
>> +     DBG("set flex mode w %x addrlen %x hp %d\n", width, addrlen, hp);
>> +
>> +     if (addrlen == BSPI_ADDRLEN_4BYTES) {
>> +             bpp = BSPI_BPP_ADDR_SELECT_MASK;
>> +             spans_4byte = true;
>> +     }
>> +
>> +     bpp |= 8; /* dummy cycles */
>
> Dummy cycles?

We have a BSPI block that does address write and read in one shot stil
uses the SPI. For reads we need to to setup the SoC controller
BSPI_BITS_PER_PHASE register with the dummy clock cycles during reads.

>> +     default:
>> +             rv = -1;
>
> Real error codes please.
>

Will return -EINVAL

>> +     if (!error) {
>> +             qspi->xfer_mode.width = width;
>> +             qspi->xfer_mode.addrlen = addrlen;
>> +             qspi->xfer_mode.hp = hp;
>> +             dev_info(&qspi->pdev->dev,
>> +                     "%d-lane output, %d-byte address%s\n",
>> +                     qspi->xfer_mode.width,
>> +                     qspi->xfer_mode.addrlen,
>> +                     qspi->xfer_mode.hp ? ", high-performance mode" : "");
>
> This is far too noisy, it's going to spam the logs on every transfer.

The caller only calls this on mode change as in as in 3/4 byte
addressing or  single, dual, quad io mode. Ideally for a given flash
should only happen once during probe.

>
>> +     } else
>> +             dev_warn(&qspi->pdev->dev,
>> +                     "INVALID COMBINATION: width=%d addrlen=%d hp=%d\n",
>> +                     width, addrlen, hp);
>
> Why isn't this returning an error?

This should not occur, we operate in default 3 addr byte and single
lane io mode. However I can return error in this case and handle it
accordingly.

>> +static int bcm_qspi_update_parms(struct bcm_qspi *qspi,
>> +                              struct spi_device *spidev,
>> +                              struct spi_transfer *trans, int override)
>> +{
>> +     struct bcm_qspi_parms xp;
>> +
>> +     xp.speed_hz = min(trans->speed_hz ? trans->speed_hz :
>> +                     (spidev->max_speed_hz ? spidev->max_speed_hz :
>> +                     qspi->max_speed_hz), qspi->max_speed_hz);
>
> This is marginally legible, and you should just be able to trust what's
> in the transfer anyway as the core should be doing this - there's
> nothing device specific.
>

Will change this to use what is passed.

>> +     if ((override == PARMS_OVERRIDE) ||
>> +             ((xp.speed_hz == qspi->last_parms.speed_hz) &&
>> +              (xp.chip_select == qspi->last_parms.chip_select) &&
>> +              (xp.mode == qspi->last_parms.mode) &&
>> +              (xp.bits_per_word == qspi->last_parms.bits_per_word))) {
>> +             bcm_qspi_hw_set_parms(qspi, &xp);
>> +             return 0;
>> +     }
>> +     /* no override, and parms do not match */
>> +     return 1;
>
> What is an override
>

This code is not needed if I make the previous change as proposed.

>> +static int find_next_byte(struct bcm_qspi *qspi, struct position *p,
>> +                       int flags)
>> +{
>> +     int ret = FNB_BREAK_NONE;
>
> What is this supposed to be doing?
>

This one is advancing the data pointer (used for both MSPI  rx and
tx). Used for both RX and TX.

>> +     /* deassert CS on the final byte */
>> +     if (fnb & FNB_BREAK_DESELECT) {
>> +             mspi_cdram = read_cdram_slot(qspi, slot - 1) &
>> +                     ~MSPI_CDRAM_CONT_BIT;
>> +             write_cdram_slot(qspi, slot - 1, mspi_cdram);
>> +     }
>
> Let the core handle asserting and deasserting chip select.
>

Its actually a peripheral CS (PCS) bit in the MSPI block. Peripheral
chip selects are used to select an external device for serial data
transfer. PCS[i] corresponds to pin SS[i].

>> +/* BSPI helpers */
>> +static int bcm_qspi_emulate_flash_read(struct bcm_qspi *qspi,
>> +                            struct spi_device *spi, struct spi_transfer *t)
>> +{
>> +     u32 addr, len, len_words;
>> +     u8 *buf;
>
> What is this doing?  This seems very worrying...
>

Broadcom SoCs  accelerates transfers by pairing both the address
writes tx buf and the rx buf, sets up the transfer parameters and
interrupts the driver till all the rx data bytes  are received. For
all other commands the data passes as is via the MSPI registers.

>> +     if (trans && trans->len && trans->tx_buf) {
>> +             u8 command = ((u8 *)trans->tx_buf)[0];
>> +
>> +             if (trans->rx_nbits)
>> +                     nbits = trans->rx_nbits;
>> +
>> +             switch (command) {
>> +             case SPINOR_OP_READ4_FAST:
>> +                     if (!bcm_qspi_is_4_byte_mode(qspi))
>
> No, this is not a good idea. You should not be attempting to parse
> the data stream.  If your controller has flash support it should
> implement the flash interfaces, otherwise it should just pass the data
> streams through.
>

This is only for read command we need to setup both tx and rx at the
same time for improved performance.

>> +static int bcm_qspi_transfer_one_message(struct spi_master *master,
>> +              struct spi_message *msg)
>
> Implement transfer_one(), not transfer_one_message().
>

I need both the tx and rx transfers for read commands hence  I
implemented the transfer_one_message().
It is my understanding that transfer_one() gives me one transaction at
a time. So for a read command I will get the tx buffer first and then
rx buffer to fill. However I am trying to do a tx/rx in one shot with
the Broadcom BSPI  hw.

>> +static int bcm_qspi_simple_transaction(struct bcm_qspi *qspi,
>> +     const void *tx_buf, int tx_len, void *rx_buf, int rx_len)
>> +{
>> +
>> +     struct bcm_qspi_parms *xp = &qspi->last_parms;
>> +     struct spi_message m;
>> +     struct spi_transfer t_tx, t_rx;
>> +     struct spi_device spi;
>> +     int ret;
>> +
>> +     memset(&spi, 0, sizeof(spi));
>> +     spi.max_speed_hz = xp->speed_hz;
>> +     spi.chip_select = xp->chip_select;
>> +     spi.mode = xp->mode;
>> +     spi.bits_per_word = xp->bits_per_word;
>> +     spi.master = qspi->master;
>> +
>> +     spi_message_init(&m);
>> +     m.spi = &spi;
>
> I don't know why your driver is creating and trying to do SPI transfers
> but that is completely inappropriate for a SPI controller.  Whatever
> functionality this is implementing should be in a separate SPI device
> driver.
>

Currently not used. But I did not see a good way to be able to send
commands, like finding the ID, setting 3/4 byte addressing mode , quad
mode, on a PM resume(). Are you suggesting I make a driver similar to
m25p80  ?.

>> +static const struct of_device_id bcm_qspi_of_match[] = {
>> +     { .compatible = "brcm,spi-bcm-qspi" },
>> +     { .compatible = "brcm,qspi-brcmstb" },
>> +     { .compatible = "brcm,spi-brcmstb-mspi"},
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, bcm_qspi_of_match);
>
> This is adding new DT bindings but there is no documentation,
> documentation is required for all DT bindings.
>

This was part of Patch 1/4 as pointed to by Florian

>> +static struct platform_driver bcm_qspi_driver = {
>> +     .driver = {
>> +             .name = DRIVER_NAME,
>> +             .bus = &platform_bus_type,
>> +             .owner = THIS_MODULE,
>
> You don't need to initalize bus or owner.
>
>> +MODULE_AUTHOR("Broadcom");
>
> This should be a person if it's going to be included.


I will fix the above.

---
Kamal Dasu
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
