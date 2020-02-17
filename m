From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v9 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Mon, 17 Feb 2020 17:18:10 +0800
Message-ID: <3530edcd-eb67-8ea5-0fce-89c83400441c@linux.intel.com>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214114618.29704-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214130952.GI4827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        vigneshr-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200214130952.GI4827-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

    Thank you for the review comments,  response in inline.

On 14/2/2020 9:09 PM, Mark Brown wrote:
> On Fri, Feb 14, 2020 at 07:46:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>
>> +static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
>> +{
>> +	struct cqspi_st *cqspi = dev;
>> +	unsigned int irq_status;
>> +
>> +	/* Read interrupt status */
>> +	irq_status = readl(cqspi->iobase + CQSPI_REG_IRQSTATUS);
>> +
>> +	/* Clear interrupt */
>> +	writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
>> +
>> +	irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
>> +
>> +	if (irq_status)
>> +		complete(&cqspi->transfer_complete);
>> +
>> +	return IRQ_HANDLED;
>> +}
> This will unconditionally handle the interrupt regardless of if the
> hardware was actually flagging an interrupt which will break shared
> interrupts and the fault handling code in genirq.
Yes, you're correct, it doesn't check unconditionally, will update the
INT flag in the INT_STATUS register after successful completion of 
read/write operation.
but in this case it is dedicated to qspi-interrupt,not shared with any 
other HW/SW interrupts.
>> +	tmpbufsize = op->addr.nbytes + op->dummy.nbytes;
>> +	tmpbuf = kzalloc(tmpbufsize, GFP_KERNEL | GFP_DMA);
>> +	if (!tmpbuf)
>> +		return -ENOMEM;
> I'm not clear where tmpbuf gets freed or passed out of this function?
Agreed!, will fix it.
>> +
>> +	if (op->addr.nbytes) {
>> +		for (i = 0; i < op->addr.nbytes; i++)
>> +			tmpbuf[i] = op->addr.val >> (8 * (op->addr.nbytes - i - 1));
>> +
>> +		addr_buf = tmpbuf;
> We assign tmpbuf to addr_buf here but addr_buf just gets read from so
> it's not via that AFAICT.
Agreed, will fix it.
>> +	}
>> +	/* Invalid address return zero. */
> Missing blank line.
Noted.
>> +static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
>> +{
>> +	struct cqspi_st *cqspi = f_pdata->cqspi;
>> +	void __iomem *reg_base = cqspi->iobase;
>> +	unsigned int chip_select = f_pdata->cs;
>> +	unsigned int reg;
>> +
>> +	reg = readl(reg_base + CQSPI_REG_CONFIG);
>> +	reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
>> +
>> +	/* Convert CS if without decoder.
>> +	 * CS0 to 4b'1110
>> +	 * CS1 to 4b'1101
>> +	 * CS2 to 4b'1011
>> +	 * CS3 to 4b'0111
>> +	 */
>> +	chip_select = 0xF & ~(1 << chip_select);
> This says "if without decoder" but there's no conditionals here, what if
> we do have a decoder?
Good catch, will add the check in the next patch, the below check to be 
added.
if (cqspi->is_decoded_cs) {
           reg |= CQSPI_REG_CONFIG_DECODE_MASK;
} else {
           reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
>> +	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>> +	ddata  = of_device_get_match_data(dev);
>> +	if (ddata) {
>> +		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
>> +			cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
>> +						cqspi->master_ref_clk_hz);
>> +		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
>> +			master->mode_bits |= SPI_RX_OCTAL;
>> +		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
>> +			cqspi->use_dac_mode = true;
>> +		if (ddata->quirks & CQSPI_NEEDS_ADDR_SWAP) {
>> +			master->bus_num = 0;
>> +			master->num_chipselect = 2;
>> +		}
>> +	}
> Given that the driver appears to unconditionally dereference match data
> in other places I'd expect this to return an error if there's none,
> otherwise we'll oops in those other code paths later on.
Noted, will double check is there any impact if there is no data provided.
also will add the error check if return an error.
>> +	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
>> +			       pdev->name, cqspi);
>> +	if (ret) {
>> +		dev_err(dev, "Cannot request IRQ.\n");
>> +		goto probe_reset_failed;
>> +	}
> Are you sure that it's safe to use devm_request_irq()
Yes, I'm sure that it's safe to use devm_request_irq().
>   - what happens if
> the interrupt fires in the process of removing the device?
    This is not external interrupt which is coming from the device, its 
inbuilt to QSPI controller which has 2 Registers 1) INT_STATUS_REG 2) 
INT_MASK_REG.
    It fires an interrupt and updating INT flag bit in the interrupt 
status register once reached read/write completion state then 
irq_handler is called,
    there we are clearing the INT_FLAG bit by masking of RD/WR flag in 
INT_MASK register.

Regards
Vadivel
