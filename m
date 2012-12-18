From: chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Tue, 18 Dec 2012 13:47:40 +0800
Message-ID: <1355809660.11831.284.camel@bichao>
References: <1353464203.20353.6.camel@bichao>
	<CACRpkdad3fHxWRpRqD-eP8-sKKexN+s-JZCT6XLggv92Q=5kMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdad3fHxWRpRqD-eP8-sKKexN+s-JZCT6XLggv92Q=5kMA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Linus,
Thanks for your kind comments. Seems you were viewing the 1st version, I've
submitted 2nd version and to deliver the 3rd version soon, will include you
for review.

Please see my comments inline below.

On Mon, 2012-12-17 at 12:23 +0100, Linus Walleij wrote:
> On Wed, Nov 21, 2012 at 3:16 AM, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > +#ifdef DUMP_RX
> 
> So since this #define DUMP_RX is not part of this patch and not of the
> kernel at large it's basically an #if 0 and all the code within such
> defines should be deleted.
> 
> But I guess you have this undocumented feature that the developer
> is supposed to hack the file and insert #define DUMP_RX to use it.

yes, so I'm to deleted it in this patch, and the "DUMP" feature is to
submitted as another patch, which is referred to your method.

> > +static inline u32 is_tx_fifo_empty(struct ssp_driver_context *drv_context)
> 
> Change return type to bool if you're just returning 0 or 1.
> 
> > +{
> > +       u32 sssr;
> > +       sssr = read_SSSR(drv_context->ioaddr);
> > +       if ((sssr & SSSR_TFL_MASK) || (sssr & SSSR_TNF) == 0)
> > +               return 0;
> > +       else
> > +               return 1;
> > +}
> 
> return false/true.
> 
> > +static inline u32 is_rx_fifo_empty(struct ssp_driver_context *drv_context)
> > +{
> > +       return ((read_SSSR(drv_context->ioaddr) & SSSR_RNE) == 0);
> > +}
> 
> Dito. Here it is even more obvious.
> 

It's already done in 2nd version.

> > +static void flush(struct ssp_driver_context *drv_context)
> > +{
> > +       void *reg = drv_context->ioaddr;
> > +       u32 i = 0;
> > +
> > +       /* If the transmit fifo is not empty, reset the interface. */
> > +       if (!is_tx_fifo_empty(drv_context)) {
> > +               dev_err(&drv_context->pdev->dev,
> > +                               "TX FIFO not empty. Reset of SPI IF");
> > +               disable_interface(drv_context);
> > +               return;
> > +       }
> > +
> > +       dev_dbg(&drv_context->pdev->dev, " SSSR=%x\r\n", read_SSSR(reg));
> > +       while (!is_rx_fifo_empty(drv_context) && (i < SPI_FIFO_SIZE + 1)) {
> > +               read_SSDR(reg);
> > +               i++;
> > +       }
> > +       WARN(i > 0, "%d words flush occured\n", i);
> 
> WARN really? Why not dev_warn()?

It's suppose that SPI FIFO is empty after each transfer, so call flush()
before each time of transfer, if any remain data in SPI FIFO,
It shows some kinds of Error must be happened in last transfer and
deserves a WARN() to record it.

> > +static int null_writer(struct ssp_driver_context *drv_context)
> > +static int null_reader(struct ssp_driver_context *drv_context)
> > +static int u8_writer(struct ssp_driver_context *drv_context)
> > +static int u8_reader(struct ssp_driver_context *drv_context)
> > +static int u16_writer(struct ssp_driver_context *drv_context)
> > +static int u16_reader(struct ssp_driver_context *drv_context)
> > +static int u32_writer(struct ssp_driver_context *drv_context)
> > +static int u32_reader(struct ssp_driver_context *drv_context)
> 
> These seem to all be designed to return 0 or 1 and should then be
> bool. It seems strange actually, you would expect that such a
> function returns the number of bytes or words read/written.
> 

these functions are only used by PIO transfer, its name shows how many
bytes to be written/read, and to return whether write/read is success.
If returns bytes of read/written seems make no sense for PIO transfer,
so I think return type of boot is enough, what do you think?

> > +/**
> > + * sram_to_ddr_cpy() - Copy data from Langwell SDRAM to DDR
> > + * @drv_context:       Pointer to the private driver context
> > + */
> > +static void sram_to_ddr_cpy(struct ssp_driver_context *drv_context)
> > +{
> > +       u32 length = drv_context->len;
> > +
> > +       if ((drv_context->quirks & QUIRKS_DMA_USE_NO_TRAIL)
> > +               && (drv_context->len > drv_context->rx_fifo_threshold *
> > +               drv_context->n_bytes))
> > +               length = TRUNCATE(drv_context->len,
> > +                       drv_context->rx_fifo_threshold * drv_context->n_bytes);
> 
> TRUNCATE is a too generic name but I'll leave that comment for
> the header file where it's defined.
> 
In version 2, most contents have been moved to c file to avoid name
conflicts.

> It looks very strange.
> 
> Isn't this simply an arithmetic soup construction to say:
> 
> length = drv_context->len / (drv_context->rx_fifo_threshold *
> drv_context->n_bytes);

I think TRUNCATE() is different:
#define TRUNCATE(x, a) ((x) & ~((a)-1))

> > +static void int_transfer_complete(struct ssp_driver_context *drv_context)
> > +{
> > +       void *reg = drv_context->ioaddr;
> > +       struct spi_message *msg;
> > +       struct device *dev = &drv_context->pdev->dev;
> > +
> > +       if (unlikely(drv_context->quirks & QUIRKS_USE_PM_QOS))
> > +               pm_qos_update_request(&drv_context->pm_qos_req,
> > +                                       PM_QOS_DEFAULT_VALUE);
> 
> It's weird that using PM QoS is treated as an unlikely oddity.
> Should it not be the other way around?
> 
> > +
> > +       if (unlikely(drv_context->quirks & QUIRKS_SRAM_ADDITIONAL_CPY))
> > +               sram_to_ddr_cpy(drv_context);
> > +
> > +       if (likely(drv_context->quirks & QUIRKS_DMA_USE_NO_TRAIL))
> > +               drain_trail(drv_context);
> 
> Uusally likely() / unlikely() micro-optimization is discouraged,
> do you have specific performance numbers for using it so
> much here?
> 

I haven't done any sort of performance test for likely/unlikely, but per
our test on Medfield Platform, it meets our performance request. By the
way, would you please illustrate why likely/unlikely is discouraged. If
it impacts on performance, maybe we could consider to propose another
enhancement patch to optimize performance, but this should based on
test.

> > +       else
> > +               /* Stop getting Time Outs */
> > +               write_SSTO(0, reg);
> > +
> > +       drv_context->cur_msg->status = 0;
> > +       drv_context->cur_msg->actual_length = drv_context->len;
> > +
> > +#ifdef DUMP_RX
> > +       dump_trailer(dev, drv_context->rx, drv_context->len, 16);
> > +#endif
> 
> Atleast avoid doing these inlined #ifdefs please.
> 
> Define a stub up-there where it's defined instead:
> 
> #if DUMP_RX
> void dump_trailer()
> {
> ...
> }
> #else
> void static inline dump_trailer() {}
> #endif
> 
> The kernel already relies on the compiler to remove such
> code completely, so should be done here as well.
> 
> > +       dev_dbg(dev, "End of transfer. SSSR:%08X\n", read_SSSR(reg));
> > +       msg = drv_context->cur_msg;
> > +       if (likely(msg->complete))
> > +               msg->complete(msg->context);
> > +}
> 
> So this is duplicating the code in the bulk SPI code.
> 
> Please try to use the generic transfer queue, it's really nice.
> 
> > +static void int_transfer_complete_work(struct work_struct *work)
> > +{
> > +       struct ssp_driver_context *drv_context = container_of(work,
> > +                               struct ssp_driver_context, complete_work);
> > +
> > +       int_transfer_complete(drv_context);
> > +}
> 
> What does "int_" mean in the above function signature?
> 
> Repeatedly in the file says interrupt mode is not supported so it can't
> be "interrupt". "internal"?
> 
> Actaully it seems this is dead code. The only reference in the
> driver appears to be when an unused WQ us pointed at this
> function.
> 
> I think you have some clean-up to do if you don't support interrupt
> mode.
> 

It's changed in new patch, new patch will adapt new SPI core workqueue
management, please refer to 3rd version patch which I'll send out later
today.

> 
> > +/**
> > + * ssp_int() - Interrupt handler
> > + * @irq
> > + * @dev_id
> > + *
> > + * The SSP interrupt is not used for transfer which are handled by
> > + * DMA or polling: only under/over run are catched to detect
> > + * broken transfers.
> > + */
> > +static irqreturn_t ssp_int(int irq, void *dev_id)
> > +{
> > +       struct ssp_driver_context *drv_context = dev_id;
> > +       void *reg = drv_context->ioaddr;
> > +       struct device *dev = &drv_context->pdev->dev;
> > +       u32 status = read_SSSR(reg);
> > +
> > +       /* It should never be our interrupt since SSP will */
> > +       /* only trigs interrupt for under/over run.        */
> 
> /*
>  * Squash to some nice multiline comment will you?
>  */

Sure.

> 
> > +       if (likely(!(status & drv_context->mask_sr)))
> > +               return IRQ_NONE;
> > +
> > +       if (status & SSSR_ROR || status & SSSR_TUR) {
> > +               dev_err(dev, "--- SPI ROR or TUR occurred : SSSR=%x\n", status);
> > +               WARN_ON(1);
> > +               if (status & SSSR_ROR)
> > +                       dev_err(dev, "we have Overrun\n");
> > +               if (status & SSSR_TUR)
> > +                       dev_err(dev, "we have Underrun\n");
> > +       }
> > +
> > +       /* We can fall here when not using DMA mode */
> 
> fall? fail?
> 
I think it's "fall"

> > +       if (!drv_context->cur_msg) {
> > +               disable_interface(drv_context);
> > +               disable_triggers(drv_context);
> > +       }
> 
> So you only do something if you *don't* have any messages?
> 
> > +       /* clear status register */
> > +       write_SSSR(drv_context->clear_sr, reg);
> > +       return IRQ_HANDLED;
> > +}
> 
> I can't see how this error interrupt handler actually handles
> errors. Has this been tested? It only seems you print an error
> message and go on as usual.
> 
> You should tear down the ongoing transfer, set the msg->status
> to some error code and/or retransmit or something should you not?
> 
> Atleast put in a TODO so that maintainers of this driver
> know that there's something unhandled here.

when ROR/TOR happened, transfer will not continue because it will never
receive DMA complete interrupts, therefore transfer loop is stopped. But
Error recovery mechanism is TODO and will be validated and updated in
other patches, recovery handler is not to be done in this interrupt
handler.

> 
> (...)
> > +/**
> > + * start_bitbanging() - Clock synchronization by bit banging
> > + * @drv_context:       Pointer to private driver context
> > + *
> > + * This clock synchronization will be removed as soon as it is
> > + * handled by the SCU.
> > + */
> > +static void start_bitbanging(struct ssp_driver_context *drv_context)
> > +{
> > +       u32 sssr;
> > +       u32 count = 0;
> > +       u32 cr0;
> > +       void *i2c_reg = drv_context->I2C_ioaddr;
> > +       struct device *dev = &drv_context->pdev->dev;
> > +       void *reg = drv_context->ioaddr;
> > +       struct chip_data *chip = spi_get_ctldata(drv_context->cur_msg->spi);
> > +       cr0 = chip->cr0;
> > +
> > +       dev_warn(dev, "In %s : Starting bit banging\n",\
> > +               __func__);
> > +       if (read_SSSR(reg) & SSP_NOT_SYNC)
> > +               dev_warn(dev, "SSP clock desynchronized.\n");
> > +       if (!(read_SSCR0(reg) & SSCR0_SSE))
> > +               dev_warn(dev, "in SSCR0, SSP disabled.\n");
> > +
> > +       dev_dbg(dev, "SSP not ready, start CLK sync\n");
> > +
> > +       write_SSCR0(cr0 & ~SSCR0_SSE, reg);
> > +       write_SSPSP(0x02010007, reg);
> 
> Aha 0x0201007.
> 
> Usually we define the bitfields, and actually you have:
> <snip from header file>
> +#define SSPSP_FSRT       (1 << 25)   /* Frame Sync Relative Timing */
> +#define SSPSP_DMYSTOP(x) ((x) << 23) /* Dummy Stop */
> +#define SSPSP_SFRMWDTH(x)((x) << 16) /* Serial Frame Width */
> +#define SSPSP_SFRMDLY(x) ((x) << 9)  /* Serial Frame Delay */
> +#define SSPSP_DMYSTRT(x) ((x) << 7)  /* Dummy Start */
> +#define SSPSP_STRTDLY(x) ((x) << 4)  /* Start Delay */
> +#define SSPSP_ETDS       (1 << 3)    /* End of Transfer data State */
> +#define SSPSP_SFRMP      (1 << 2)    /* Serial Frame Polarity */
> +#define SSPSP_SCMODE(x)  ((x) << 0)  /* Serial Bit Rate Clock Mode */
> <end>
> 
> Please use these bit specifiers to conjure the magic number instead.
> 
> (...)
> > +       write_I2CDATA(0x3, i2c_reg);
> > +       udelay(I2C_ACCESS_USDELAY);
> > +       write_I2CCTRL(0x01070034, i2c_reg);
> > +       udelay(I2C_ACCESS_USDELAY);
> > +       write_I2CDATA(0x00000099, i2c_reg);
> > +       udelay(I2C_ACCESS_USDELAY);
> > +       write_I2CCTRL(0x01070038, i2c_reg);
> > +       udelay(I2C_ACCESS_USDELAY);
> 
> Dito.
> 
> > +       /* Bit bang the clock until CSS clears */
> > +       while ((sssr & 0x400000) && (count < MAX_BITBANGING_LOOP)) {
> > +               write_I2CDATA(0x2, i2c_reg);
> > +               udelay(I2C_ACCESS_USDELAY);
> > +               write_I2CCTRL(0x01070034, i2c_reg);
> > +               udelay(I2C_ACCESS_USDELAY);
> > +               write_I2CDATA(0x3, i2c_reg);
> > +               udelay(I2C_ACCESS_USDELAY);
> > +               write_I2CCTRL(0x01070034, i2c_reg);
> > +               udelay(I2C_ACCESS_USDELAY);
> 
> 
> Dito.
> 
> > +       if (count >= MAX_BITBANGING_LOOP)
> > +               dev_err(dev,
> > +                       "ERROR in %s : infinite loop on bit banging. Aborting\n",
> > +                       __func__);
> > +
> > +       dev_dbg(dev, "---Bit bang count=%d\n", count);
> > +
> > +       write_I2CDATA(0x0, i2c_reg);
> > +       udelay(I2C_ACCESS_USDELAY);
> > +       write_I2CCTRL(0x01070038, i2c_reg);
> 
> Dito.

> > +static unsigned int ssp_get_clk_div(int speed)
> > +{
> > +       return max(100000000 / speed, 4) - 1;
> > +}
> 
> This was nice to see, good use of the max() operator!
> 
> (...)
> > +static int transfer(struct spi_device *spi, struct spi_message *msg)
> 
> This is duplicating the core message transfer queue.
> 
> Refactor this code to use the new infrastructure.
> 
> (...)

It's updated.

> > +static int intel_mid_ssp_spi_probe(struct pci_dev *pdev,
> > +       const struct pci_device_id *ent)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct spi_master *master;
> > +       struct ssp_driver_context *drv_context = 0;
> > +       int status;
> > +       u32 iolen = 0;
> > +       u8 ssp_cfg;
> > +       int pos;
> > +       void __iomem *syscfg_ioaddr;
> > +       unsigned long syscfg;
> > +
> > +       /* Check if the SSP we are probed for has been allocated */
> > +       /* to operate as SPI. This information is retreived from */
> > +       /* the field adid of the Vendor-Specific PCI capability  */
> > +       /* which is used as a configuration register.            */
> 
> /*
>  * Convert to multiline comment
>  */

Yes..

> 
> > +       if (drv_context->quirks & QUIRKS_BIT_BANGING) {
> > +               /* Bit banging on the clock is done through */
> > +               /* DFT which is available through I2C.      */
> > +               /* get base address of I2C_Serbus registers */
> > +               drv_context->I2C_paddr = 0xff12b000;
> 
> What on earth is this?
> 
> Note the comment says "get base address", you're not getting it at
> all, you're hardcoding it. Resources like this should be passed in from
> the outside.
> 

Ok, the address is fixed for current platform, I'll define the address
at beginning and here just refer to the macro, if other platform, this
address should be defined as other value.

> What will happen in the next platform when some ASIC engineer
> decide to move this some pages ahead?
> 
> Don't you have some platform data/device tree/ACPI table or
> whatever where this is supposed to be stored?
> 
> Looks like a criss-cross dependency to some I2C block, and
> as such it deserves a big fat comment about the weirdness
> going on here.
> 
> > +               drv_context->I2C_ioaddr =
> > +                       ioremap_nocache(drv_context->I2C_paddr, 0x10);
> 
> Like the size of that ioregion.
> 
> And use devm_ioremap_nocache() to utilize managed resources.
> 
> > +               if (!drv_context->I2C_ioaddr) {
> > +                       status = -ENOMEM;
> > +                       goto err_free_3;
> > +               }
> > +       }
> > +
> > +       /* Attach to IRQ */
> > +       drv_context->irq = pdev->irq;
> > +       status = request_irq(drv_context->irq, ssp_int, IRQF_SHARED,
> > +               "intel_mid_ssp_spi", drv_context);
> 
> Use managed resources throughout:
> devm_request_irq() in this case.


> 
> > +       if (status < 0) {
> > +               dev_err(&pdev->dev, "can not get IRQ\n");
> > +               goto err_free_4;
> > +       }
> > +
> > +       if (drv_context->quirks & QUIRKS_PLATFORM_MDFL) {
> > +               /* get base address of DMA selector. */
> > +               syscfg = drv_context->paddr - SYSCFG;
> > +               syscfg_ioaddr = ioremap_nocache(syscfg, 0x10);
> 
> devm_ioremap_nocache()
> 
> > +               if (!syscfg_ioaddr) {
> > +                       status = -ENOMEM;
> > +                       goto err_free_5;
> > +               }
> > +               iowrite32(ioread32(syscfg_ioaddr) | 2, syscfg_ioaddr);
> > +       }
> > +
> > +       tasklet_init(&drv_context->poll_transfer, poll_transfer,
> > +               (unsigned long)drv_context);
> 
> I think this tasklet can be removed and you can have the SPI core
> message queue drive the transfers. But prove me wrong.
> 

Agree with you, please view the 3rd patch..

> > +       /* Register with the SPI framework */
> > +       dev_info(dev, "register with SPI framework (bus spi%d)\n",
> > +               master->bus_num);
> > +
> > +       status = spi_register_master(master);
> > +
> > +       if (status != 0) {
> > +               dev_err(dev, "problem registering spi\n");
> > +               goto err_free_5;
> > +       }
> > +
> > +       pci_set_drvdata(pdev, drv_context);
> > +
> > +       /* Create the PM_QOS request */
> > +       if (drv_context->quirks & QUIRKS_USE_PM_QOS)
> > +               pm_qos_add_request(&drv_context->pm_qos_req,
> > +               PM_QOS_CPU_DMA_LATENCY,
> > +               PM_QOS_DEFAULT_VALUE);
> > +
> > +       return status;
> > +
> > +err_free_5:
> > +       free_irq(drv_context->irq, drv_context);
> > +err_free_4:
> > +       iounmap(drv_context->I2C_ioaddr);
> > +err_free_3:
> > +       iounmap(drv_context->ioaddr);
> 
> These three go away with managed devm_* resources.
> 
> > +err_free_2:
> > +       pci_release_region(pdev, 0);
> > +err_free_1:
> > +       spi_master_put(master);
> > +err_free_0:
> > +       pci_disable_device(pdev);
> > +
> > +       return status;
> > +err_abort_probe:
> > +       dev_info(dev, "Abort probe for SSP %04xh:%04xh\n",
> > +               pdev->vendor, pdev->device);
> > +       return -ENODEV;
> > +}
> 
> (...)
> > +static void __devexit intel_mid_ssp_spi_remove(struct pci_dev *pdev)
> > +{
> > +       struct ssp_driver_context *drv_context = pci_get_drvdata(pdev);
> > +
> > +       if (!drv_context)
> > +               return;
> > +
> > +       /* Release IRQ */
> > +       free_irq(drv_context->irq, drv_context);
> > +
> > +       iounmap(drv_context->ioaddr);
> > +       if (drv_context->quirks & QUIRKS_BIT_BANGING)
> > +               iounmap(drv_context->I2C_ioaddr);
> 
> These also go away with devm_*

OK..

> 
> > +
> > +       /* disconnect from the SPI framework */
> > +       spi_unregister_master(drv_context->master);
> > +
> > +       pci_set_drvdata(pdev, NULL);
> > +       pci_release_region(pdev, 0);
> > +       pci_disable_device(pdev);
> > +
> > +       return;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +/**
> > + * intel_mid_ssp_spi_suspend() - Driver suspend procedure
> > + * @pdev:      Pointer to the pci_dev struct
> > + * @state:     pm_message_t
> > + */
> > +static int intel_mid_ssp_spi_suspend(struct pci_dev *pdev, pm_message_t state)
> > +{
> > +       struct ssp_driver_context *drv_context = pci_get_drvdata(pdev);
> > +       dev_dbg(&pdev->dev, "suspend\n");
> > +
> > +       tasklet_disable(&drv_context->poll_transfer);
> > +
> > +       return 0;
> > +}
> 
> When using the central message queue you probably just call
> spi_master_suspend()
> spi_master_resume()
> 
> here and the framework takes care of the message queue.

PM related process is not implemented in this patch, it's TODO following
this patch, let's handle it together in that patch.

> 
> (...)
> > +++ b/include/linux/spi/spi-intel-mid-ssp.h
> > @@ -0,0 +1,326 @@
> > +/*
> > + *  Copyright (C) Intel 2009
> > + *  Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > + *  Sylvain Centelles <sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > + *
> > + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cut these nice wallpapers... OK no big deal maybe.
> 
> (...)
> 
> For the following review comments, begin with adding:
> 
> #include <linux/bitops.h>
> 
> So you get the BIT() macro and some more.
> 
> > +#define SSP_NOT_SYNC 0x400000
> 
> Then you can write:
> 
> #define SSP_NOT_SYNC BIT(22)
> 
> Which tell us what this is actually about. A flag in bit 22.

That's nice, thank you.

> 
> > +#define MAX_SPI_TRANSFER_SIZE 8192
> > +#define MAX_BITBANGING_LOOP   10000
> > +#define SPI_FIFO_SIZE 16
> > +
> > +/* PM QoS define */
> > +#define MIN_EXIT_LATENCY 20
> 
> State unit. milliseconds I think?

usec..

> 
> > +/* SSP assignement configuration from PCI config */
> > +#define SSP_CFG_GET_MODE(ssp_cfg)      ((ssp_cfg) & 0x07)
> > +#define SSP_CFG_GET_SPI_BUS_NB(ssp_cfg)        (((ssp_cfg) >> 3) & 0x07)
> > +#define SSP_CFG_IS_SPI_SLAVE(ssp_cfg)  ((ssp_cfg) & 0x40)
> 
> & BIT(6)
> 
> > +#define SSP_CFG_SPI_MODE_ID            1
> > +/* adid field offset is 6 inside the vendor specific capability */
> > +#define VNDR_CAPABILITY_ADID_OFFSET    6
> > +
> > +/* Driver's quirk flags */
> > +/* This workarround bufferizes data in the audio fabric SDRAM from  */
> > +/* where the DMA transfers will operate. Should be enabled only for */
> > +/* SPI slave mode.                                                  */
> > +#define QUIRKS_SRAM_ADDITIONAL_CPY     1
> 
> BIT(0)
> 
> > +/* If set the trailing bytes won't be handled by the DMA.           */
> > +/* Trailing byte feature not fully available.                       */
> > +#define QUIRKS_DMA_USE_NO_TRAIL                2
> 
> BIT(1)
> 
> > +/* If set, the driver will use PM_QOS to reduce the latency         */
> > +/* introduced by the deeper C-states which may produce over/under   */
> > +/* run issues. Must be used in slave mode. In master mode, the      */
> > +/* latency is not critical, but setting this workarround  may       */
> > +/* improve the SPI throughput.                                      */
> > +#define QUIRKS_USE_PM_QOS              4
> 
> BIT(2)
> 
> > +/* This quirks is set on Moorestown                                 */
> > +#define QUIRKS_PLATFORM_MRST           8
> 
> BIT(3)
> 
> > +/* This quirks is set on Medfield                                   */
> > +#define QUIRKS_PLATFORM_MDFL           16
> 
> BIT(4)
> 
> > +/* If set, the driver will apply the bitbanging workarround needed  */
> > +/* to enable defective Langwell stepping A SSP. The defective SSP   */
> > +/* can be enabled only once, and should never be disabled.          */
> > +#define QUIRKS_BIT_BANGING             32
> 
> BIT(5)
> 
> > +/* If set, SPI is in slave clock mode                               */
> > +#define QUIRKS_SPI_SLAVE_CLOCK_MODE    64
> 
> BIT(6)
> 
> > +/* Uncomment to get RX and TX short dumps after each transfer */
> > +/* #define DUMP_RX 1 */
> 
> As mentioned in the main file, convert to a Kconfig verbose config option.
> 
> > +#define MAX_TRAILING_BYTE_RETRY 16
> > +#define MAX_TRAILING_BYTE_LOOP 100
> 
> Max iterations?
> 
> > +#define DELAY_TO_GET_A_WORD 3
> > +#define DFLT_TIMEOUT_VAL 500
> 
> milliseconds?
> 

It depends on peripheral clock frequency.

> > +#define DEFINE_SSP_REG(reg, off) \
> > +static inline u32 read_##reg(void *p) { return __raw_readl(p + (off)); } \
> > +static inline void write_##reg(u32 v, void *p) { __raw_writel(v, p + (off)); }
> 
> But the other code is using io-accessors, so what about you use
> ioread32()/iowrite32() instead?
> 
> In any way readl_relaxed() and writel_relaxed() would be preferable
> to this I think?
> 
> > +#define RX_DIRECTION 0
> > +#define TX_DIRECTION 1
> > +
> > +#define I2C_ACCESS_USDELAY 10
> > +
> > +#define DFLT_BITS_PER_WORD 16
> > +#define MIN_BITS_PER_WORD     4
> > +#define MAX_BITS_PER_WORD     32
> > +#define DFLT_FIFO_BURST_SIZE   IMSS_FIFO_BURST_8
> > +
> > +#define TRUNCATE(x, a) ((x) & ~((a)-1))
> 
> Too generic name. And what it does is actually mask the (a) upper
> bits so it's misleading too.
> 
> I'm confused over this macro, as per comments in the code, and
> suspect it should be removed in favor of integer division.
> 
> If you have to keep this then atleast rewrite it using a
> static inline.
> 
> > +DEFINE_SSP_REG(SSCR0, 0x00)
> > +DEFINE_SSP_REG(SSCR1, 0x04)
> > +DEFINE_SSP_REG(SSSR, 0x08)
> > +DEFINE_SSP_REG(SSITR, 0x0c)
> > +DEFINE_SSP_REG(SSDR, 0x10)
> > +DEFINE_SSP_REG(SSTO, 0x28)
> > +DEFINE_SSP_REG(SSPSP, 0x2c)
> > +
> > +DEFINE_SSP_REG(I2CCTRL, 0x00);
> > +DEFINE_SSP_REG(I2CDATA, 0x04);
> > +
> > +DEFINE_SSP_REG(GPLR1, 0x04);
> > +DEFINE_SSP_REG(GPDR1, 0x0c);
> > +DEFINE_SSP_REG(GPSR1, 0x14);
> > +DEFINE_SSP_REG(GPCR1, 0x1C);
> > +DEFINE_SSP_REG(GAFR1_U, 0x44);
> > +
> > +#define SYSCFG  0x20bc0
> 
> Which means?
> 
> > +#define SRAM_BASE_ADDR 0xfffdc000
> 
> Should be passed as resource, se above reasoning for the
> "I2C" base address. What happens on next ASIC spin when
> the engineer move this base offset etc, don't you have any
> system discovery?
This is fix value for Moorestown & Medfield platforms as what is
declared in the file header. If any hardware change, the address should
be changed accordantly.
> 
> > +#define SRAM_RX_ADDR   SRAM_BASE_ADDR
> > +#define SRAM_TX_ADDR  (SRAM_BASE_ADDR + MAX_SPI_TRANSFER_SIZE)
> > +
> > +#define SSCR0_DSS   (0x0000000f)     /* Data Size Select (mask) */
> > +#define SSCR0_DataSize(x)  ((x) - 1)    /* Data Size Select [4..16] */
> 
> No lowercase in macros at all please.

Yes.

> 
> SSCR0_DATASIZE() is fine.
> 
> > +#define SSCR0_FRF   (0x00000030)     /* FRame Format (mask) */
> > +#define SSCR0_Motorola        (0x0 << 4)         /* Motorola's SPI mode */
> 
> Dito.
> 
> And this is a very funny way to define the integer "0".
> 
> I understand the intent but...

Nod..

> 
> > +#define SSCR0_ECS   (1 << 6) /* External clock select */
> 
> BIT(6)
> 
> > +#define SSCR0_SSE   (1 << 7) /* Synchronous Serial Port Enable */
> 
> BIT(7)
> 
> > +
> > +#define SSCR0_SCR   (0x000fff00)      /* Serial Clock Rate (mask) */
> > +#define SSCR0_SerClkDiv(x) (((x) - 1) << 8) /* Divisor [1..4096] */
> 
> Uppercase.
> 
> > +#define SSCR0_EDSS  (1 << 20)           /* Extended data size select */
> > +#define SSCR0_NCS   (1 << 21)           /* Network clock select */
> > +#define SSCR0_RIM    (1 << 22)           /* Receive FIFO overrrun int mask */
> > +#define SSCR0_TUM   (1 << 23)           /* Transmit FIFO underrun int mask */
> 
> BIT(20), BIT(21) ...
> 
> > +#define SSCR0_FRDC (0x07000000)     /* Frame rate divider control (mask) */
> > +#define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24) /* Time slots per frame */
> 
> Uppercase.
> 
> > +#define SSCR0_ADC   (1 << 30)           /* Audio clock select */
> > +#define SSCR0_MOD  (1 << 31)           /* Mode (normal or network) */
> 
> BIT(30), BIT(31)
> 
> > +#define SSCR1_RIE    (1 << 0) /* Receive FIFO Interrupt Enable */
> > +#define SSCR1_TIE     (1 << 1) /* Transmit FIFO Interrupt Enable */
> > +#define SSCR1_LBM   (1 << 2) /* Loop-Back Mode */
> > +#define SSCR1_SPO   (1 << 3) /* SSPSCLK polarity setting */
> > +#define SSCR1_SPH   (1 << 4) /* Motorola SPI SSPSCLK phase setting */
> > +#define SSCR1_MWDS           (1 << 5) /* Microwire Transmit Data Size */
> > +#define SSCR1_TFT    (0x000003c0)     /* Transmit FIFO Threshold (mask) */
> > +#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
> > +#define SSCR1_RFT    (0x00003c00)     /* Receive FIFO Threshold (mask) */
> > +#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
> 
> BIT(0), BIT(1)...
> 
> > +#define SSSR_TNF               (1 << 2)        /* Tx FIFO Not Full */
> > +#define SSSR_RNE               (1 << 3)        /* Rx FIFO Not Empty */
> > +#define SSSR_BSY               (1 << 4)        /* SSP Busy */
> > +#define SSSR_TFS               (1 << 5)        /* Tx FIFO Service Request */
> > +#define SSSR_RFS               (1 << 6)        /* Rx FIFO Service Request */
> > +#define SSSR_ROR               (1 << 7)        /* Rx FIFO Overrun */
> 
> You know the drill.
> 
> > +#define SSSR_TFL_MASK           (0x0F << 8)     /* Tx FIFO level field mask */
> > +
> > +#define SSCR0_TIM    (1 << 23)          /* Transmit FIFO Under Run Int Mask */
> > +#define SSCR0_RIM    (1 << 22)          /* Receive FIFO Over Run int Mask */
> > +#define SSCR0_NCS    (1 << 21)          /* Network Clock Select */
> > +#define SSCR0_EDSS   (1 << 20)          /* Extended Data Size Select */
> > +
> > +#define SSCR0_TISSP      (1 << 4)  /* TI Sync Serial Protocol */
> > +#define SSCR0_PSP        (3 << 4)  /* PSP - Programmable Serial Protocol */
> > +#define SSCR1_TTELP      (1 << 31) /* TXD Tristate Enable Last Phase */
> > +#define SSCR1_TTE        (1 << 30) /* TXD Tristate Enable */
> > +#define SSCR1_EBCEI      (1 << 29) /* Enable Bit Count Error interrupt */
> > +#define SSCR1_SCFR       (1 << 28) /* Slave Clock free Running */
> > +#define SSCR1_ECRA       (1 << 27) /* Enable Clock Request A */
> > +#define SSCR1_ECRB       (1 << 26) /* Enable Clock request B */
> > +#define SSCR1_SCLKDIR    (1 << 25) /* Serial Bit Rate Clock Direction */
> > +#define SSCR1_SFRMDIR    (1 << 24) /* Frame Direction */
> > +#define SSCR1_RWOT       (1 << 23) /* Receive Without Transmit */
> > +#define SSCR1_TRAIL      (1 << 22) /* Trailing Byte */
> > +#define SSCR1_TSRE       (1 << 21) /* Transmit Service Request Enable */
> > +#define SSCR1_RSRE       (1 << 20) /* Receive Service Request Enable */
> > +#define SSCR1_TINTE      (1 << 19) /* Receiver Time-out Interrupt enable */
> > +#define SSCR1_PINTE      (1 << 18) /* Trailing Byte Interupt Enable */
> > +#define SSCR1_STRF       (1 << 15) /* Select FIFO or EFWR */
> > +#define SSCR1_EFWR       (1 << 14) /* Enable FIFO Write/Read */
> > +#define SSCR1_IFS        (1 << 16) /* Invert Frame Signal */
> > +
> > +#define SSSR_BCE         (1 << 23) /* Bit Count Error */
> > +#define SSSR_CSS         (1 << 22) /* Clock Synchronisation Status */
> > +#define SSSR_TUR         (1 << 21) /* Transmit FIFO Under Run */
> > +#define SSSR_EOC         (1 << 20) /* End Of Chain */
> > +#define SSSR_TINT        (1 << 19) /* Receiver Time-out Interrupt */
> > +#define SSSR_PINT        (1 << 18) /* Peripheral Trailing Byte Interrupt */
> 
> Use BIT() macro throughout.
> 
> > +#define SSPSP_FSRT       (1 << 25)   /* Frame Sync Relative Timing */
> > +#define SSPSP_DMYSTOP(x) ((x) << 23) /* Dummy Stop */
> > +#define SSPSP_SFRMWDTH(x)((x) << 16) /* Serial Frame Width */
> > +#define SSPSP_SFRMDLY(x) ((x) << 9)  /* Serial Frame Delay */
> > +#define SSPSP_DMYSTRT(x) ((x) << 7)  /* Dummy Start */
> > +#define SSPSP_STRTDLY(x) ((x) << 4)  /* Start Delay */
> > +#define SSPSP_ETDS       (1 << 3)    /* End of Transfer data State */
> > +#define SSPSP_SFRMP      (1 << 2)    /* Serial Frame Polarity */
> > +#define SSPSP_SCMODE(x)  ((x) << 0)  /* Serial Bit Rate Clock Mode */
> 
> (...)
> 
> > +/*
> > + * For testing SSCR1 changes that require SSP restart, basically
> > + * everything except the service and interrupt enables
> > + */
> > +
> > +#define SSCR1_CHANGE_MASK (SSCR1_TTELP | SSCR1_TTE | SSCR1_SCFR \
> > +                               | SSCR1_ECRA | SSCR1_ECRB | SSCR1_SCLKDIR \
> > +                               | SSCR1_SFRMDIR | SSCR1_RWOT | SSCR1_TRAIL \
> > +                               | SSCR1_IFS | SSCR1_STRF | SSCR1_EFWR \
> > +                               | SSCR1_RFT | SSCR1_TFT | SSCR1_MWDS \
> > +                               | SSCR1_SPH | SSCR1_SPO | SSCR1_LBM)
> > +
> > +struct callback_param {
> > +       void *drv_context;
> > +       u32 direction;
> > +};
> > +
> 
> Convert the inline documentation below to use kerneldoc.
> 
> > +struct ssp_driver_context {
> > +       /* Driver model hookup */
> > +       struct pci_dev *pdev;
> > +
> > +       /* SPI framework hookup */
> > +       struct spi_master *master;
> > +
> > +       /* SSP register addresses */
> > +       unsigned long paddr;
> > +       void *ioaddr;
> > +       int irq;
> > +
> > +       /* I2C registers */
> > +       dma_addr_t I2C_paddr;
> > +       void *I2C_ioaddr;
> 
> Skip the caps.
> 
> i2c_paddr, i2c_ioaddr is fine.
> 
> But I think "paddr" is a bad name because it probably spells
> out "physical address", "daddr" is more to the point, because
> dma address is not necessarily == physical address.
> 
Yes..

> > +       /* SSP masks*/
> > +       u32 cr1_sig;
> > +       u32 cr1;
> > +       u32 clear_sr;
> > +       u32 mask_sr;
> > +
> > +       /* PM_QOS request */
> > +       struct pm_qos_request pm_qos_req;
> > +
> > +       struct tasklet_struct poll_transfer;
> > +
> > +       spinlock_t lock;
> > +
> > +       /* Current message transfer state info */
> > +       struct spi_message *cur_msg;
> > +       size_t len;
> > +       size_t len_dma_rx;
> > +       size_t len_dma_tx;
> > +       void *tx;
> > +       void *tx_end;
> > +       void *rx;
> > +       void *rx_end;
> > +       bool dma_initialized;
> > +       int dma_mapped;
> > +       dma_addr_t rx_dma;
> > +       dma_addr_t tx_dma;
> > +       u8 n_bytes;
> > +       int (*write)(struct ssp_driver_context *drv_context);
> > +       int (*read)(struct ssp_driver_context *drv_context);
> > +
> > +       struct intel_mid_dma_slave    dmas_tx;
> > +       struct intel_mid_dma_slave    dmas_rx;
> > +       struct dma_chan    *txchan;
> > +       struct dma_chan    *rxchan;
> > +       struct workqueue_struct *dma_wq;
> > +       struct work_struct complete_work;
> > +
> > +       u8 __iomem *virt_addr_sram_tx;
> > +       u8 __iomem *virt_addr_sram_rx;
> > +
> > +       int txdma_done;
> > +       int rxdma_done;
> > +       struct callback_param tx_param;
> > +       struct callback_param rx_param;
> 
> With kerneldoc it's easier to tell what the usecase is for these
> callbacks.
> 
> > +       struct pci_dev *dmac1;
> 
> It seems that something like a pci_dev * should be used
> to refer to the I2C and SRAM as well?
> 
> > +
> > +       unsigned long quirks;
> > +       u32 rx_fifo_threshold;
> > +};
> > +
> > +struct chip_data {
> > +       u32 cr0;
> > +       u32 cr1;
> > +       u32 timeout;
> > +       u8 n_bytes;
> > +       u8 dma_enabled;
> 
> bool?
> 
Yes.
> > +       u8 bits_per_word;
> > +       u32 speed_hz;
> 
> Should that be u32? unsigned int seems more apropriate for a frequency.
> 
> > +       int (*write)(struct ssp_driver_context *drv_context);
> > +       int (*read)(struct ssp_driver_context *drv_context);
> > +};
> 
> kerneldoc me.
> 
> > +enum intel_mid_ssp_spi_fifo_burst {
> > +       IMSS_FIFO_BURST_1,
> > +       IMSS_FIFO_BURST_4,
> > +       IMSS_FIFO_BURST_8
> > +};
> > +
> > +/* spi_board_info.controller_data for SPI slave devices,
> > + * copied to spi_device.platform_data ... mostly for dma tuning
> > + */
> > +struct intel_mid_ssp_spi_chip {
> > +       enum intel_mid_ssp_spi_fifo_burst burst_size;
> > +       u32 timeout;
> > +       u8 enable_loopback;
> > +       u8 dma_enabled;
> 
> The last two entries looks like they should be bool.
> 
Yes.
> > +};
> 
> kerneldoc.
> 
> > +#define SPI_DIB_NAME_LEN  16
> > +#define SPI_DIB_SPEC_INFO_LEN      10
> > +
> > +struct spi_dib_header {
> > +       u32       signature;
> > +       u32       length;
> > +       u8         rev;
> > +       u8         checksum;
> > +       u8         dib[0];
> > +} __packed;
> 
> Why is this packed?
> 
It's unused, so delete it in later version.
> Yours,
> Linus Walleij



------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
