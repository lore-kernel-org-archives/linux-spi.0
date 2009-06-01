From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [spi-devel-general] [PATCH] ARM PL022 SSP/SPI driver v1
Date: Mon, 1 Jun 2009 07:31:01 +0300
Message-ID: <20090601041711.GE14148@tarshish>
References: <63386a3d0905271519x1afc6c4bo8d40315e2e387b63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.arm.linux.org.uk,
	David Brownell <dbrownell@users.sourceforge.net>,
	Linus Walleij <linus.walleij@stericsson.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alessandro Rubini <rubini-list@gnudd.com>, sachin.verma@st.com,
	andrea.gallo@stericsson.com, STEricsson_nomadik_linux@list.st.com
To: Linus Walleij <linus.ml.walleij@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <63386a3d0905271519x1afc6c4bo8d40315e2e387b63@mail.gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

Hi Linus,

This drivers looks like a nice piece of code.

Below are some small comments, FWIW.

On Thu, May 28, 2009 at 12:19:15AM +0200, Linus Walleij wrote:
> This adds a driver for the ARM PL022 PrimeCell SSP/SPI
> driver found in the U300 platforms as well as in some
> ARM reference hardware, and in a modified version on the
> Nomadik board.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  drivers/spi/Kconfig        |    9 +
>  drivers/spi/Makefile       |    1 +
>  drivers/spi/amba-pl022.c   | 1887 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/amba/pl022.h |  264 ++++++

Why include/linux/amba/? There's nothing AMBA specific in this header. IMO 
include/linux/spi is a better place for this header.

>  4 files changed, 2161 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/amba-pl022.c
>  create mode 100644 include/linux/amba/pl022.h
> 
> ...
>
> +/**
> + * struct chip_data - To maintain runtime state of SSP for each client chip
> + * @cr0: Value of control register CR0 of SSP
> + * @cr1: Value of control register CR1 of SSP
> + * @dmacr: Value of DMA control Register of SSP
> + * @cpsr: Value of Clock prescale register
> + * @n_bytes: how many bytes(power of 2) reqd for a given data width of client
> + * @enable_dma: Whether to enable DMA or not
> + * @write: function ptr to be used to write when doing xfer for this chip
> + * @read: function ptr to be used to read when doing xfer for this chip
> + * @cs_control: chip select callback provided by chip
> + * @xfer_type: polling/interrupt/DMA
> + *
> + * Runtime state of the SSP controller, maintained per chip,
> + * This would be set according to the current message that would be served
> + */
> +struct chip_data {
> +	u16 cr0;
> +	u16 cr1;
> +	u16 dmacr;
> +	u16 cpsr;
> +	u8 n_bytes;
> +	u8 enable_dma:1;
> +	enum ssp_reading read;
> +	enum ssp_writing write;
> +	void (*cs_control) (u32 command);

Isn't there a way for the PL022 block itself to control the chip select? In 
case there isn't one, IMHO you should provide simple way to use the generic 
GPIO API for chip select. See for example drivers/spi/atmel_spi.c, and my 
DesignWare driver that you reviewed.

> ...
> 
> +/**
> + * pl022_interrupt_handler - Interrupt handler for SSP controller
> + *
> + * This function handles interrupts generated for an interrupt based transfer.
> + * If a receive overrun (ROR) interrupt is there then we disable SSP, flag the
> + * current message's state as ERROR_STATE and schedule the tasklet
> + * pump_transfers which will do the postprocessing of the current message by
> + * calling giveback(). Otherwise it reads data from Rx FIFO till there is no
> + * more data, and writes data in Tx FIFO till it is not full. If we complete
                                                       ^^^
Typo?

> + * the transfer we move to the next transfer and schedule the tasklet.
> + */
>
> ...
>
> +static int pl022_setup(struct spi_device *spi)
> +{
> +	struct pl022_config_chip *chip_info;
> +	struct chip_data *chip;
> +	int status = 0;
> +	struct pl022 *pl022 = spi_master_get_devdata(spi->master);
>
> ...
>
> +	/* Save controller_state */
> +	spi_set_ctldata(spi, chip);
> +	return status;
> + err_config_params:
> + err_first_setup:
> +	kfree(chip);

You should probably also spi_set_ctldata(spi, NULL), so that next time 
pl022_setup() won't attempt to access freed memory on the same SPI device.

> +	return status;
> +}
>
> ...

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
