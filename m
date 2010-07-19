From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v4 1/1] davinci: spi: replace
	existing driver
Date: Sun, 18 Jul 2010 23:09:34 -0600
Message-ID: <20100719050934.GA5949@angua.secretlab.ca>
References: <1278628745-18502-1-git-send-email-bniebuhr@efjohnson.com>
	<1278628745-18502-2-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1278628745-18502-2-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 08, 2010 at 05:39:05PM -0500, Brian Niebuhr wrote:
> INTRODUCTION
> 
> I have been working on a custom OMAP-L138 board that has multiple spi
> devices (seven) on one controller.  These devices have a wide range of
> transfer parameters (speed, phase, polarity, internal and gpio chip
> selects).  During my testing I found multiple errors in the davinci spi
> driver as a result of this complex setup.  The primary issues were:
> 
> 1. There is a race condition due to the SPIBUF read busy-waits for slow
>         devices
> 2. I found some DMA transfer length errors under some conditions
> 3. The chip select code caused extra byte transfers (with no chip
>         select active) due to writes to SPIDAT1
> 4. Several issues prevented using multiple SPI devices, especially
>         the DMA code, as disucussed previously on the davinci list.
> 
> The fixes to these problems were not simple.  I ended up making fairly
> large changes to the driver, and those changes are contained in these
> patches.  The full list of changes follows.
> 
> CHANGE LIST
> 
> 1. davinci_spi_chipelect() now performs both activation and deactivation
>         of chip selects.  This lets spi_bitbang fully control chip
>         select activation, as intended by the SPI API.
> 2. Chip select activation does not cause extra writes to the SPI bus
> 3. Chip select activation does not use SPIDEF for control.  This change
>         will also allow for implementation of inverted (active high)
>         chip selects in the future.
> 4. Added back gpio chip select capability from the old driver
> 5. Fixed prescale calculation for non-integer fractions of spi clock
> 6. Allow specification of SPI transfer parameters on a per-device
>         (instead of per-controller) basis
> 7. Allow specification of polled, interrupt-based, or DMA operation on
>         a per-device basis
> 8. Allow DMA with when more than one device is connected
> 9. Combined pio and dma txrx_bufs functions into one since they share
>         large parts of their functionality, and to simplify item (8).
> 10. Use only SPIFMT0 to allow more than 4 devices
> 
> TESTING
> 
> I have tested the driver using a custom SPI stress test on my
> OMAP-L138-based board with three devices connected.  I have tested
> configurations with all three devices polled, all three interrupt-based,
> all three DMA, and a mixture.
> 
> I have compiled with the davinci_all_defconfig, but I don't have EVMs
> for the other davinci platforms to test with.
> 
> Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

Hi Brian,

A couple of minor comments below, but overall the patch looks pretty sane, and I can probably pick it up after one more respin, and assuming I receive Acks for this version from the davinci folks.

*However* the way this patch has been approached does make it very hard to know whether or not it is a good patch.  Yes, I understand that a lot of the behaviour of the driver was rewritten, and yes I understand that it is easier to just do one big diff from the old and new (and don't get me wrong, this is still better than two patches; one to remove the old and one to add the new).  That doesn't change the fact that there are still logical steps/changes to get from the old to the new.

For instance, I can immediately see the following discrete changes that really belong in there own patches: a) the changes to spi_driver->driver, b) the __devinit/__devexit annotation changes, c) the prescale calculation fixes, d) the conditional usage of tx and rx buffers in davinci_spi_*_buf_*().  Probably the data structure changes could be handled separately too.

By not keeping the discrete changes separate you are making it harder to get your code merged.  Plus, when you keep things separate, I can merge the patches that look good while asking for rework on the others.

The only reason I'm even considering picking it up is because it is for a driver with limited impact, and the primary users have been saying that it is a good thing.  If this patch touched core or SPI infrastructure code, then I'd nack it out of hand because I cannot understand it.

> ---
>  arch/arm/mach-davinci/board-dm355-evm.c     |   10 +
>  arch/arm/mach-davinci/board-dm355-leopard.c |   10 +
>  arch/arm/mach-davinci/board-dm365-evm.c     |   10 +
>  arch/arm/mach-davinci/dm355.c               |    8 +-
>  arch/arm/mach-davinci/dm365.c               |    6 -
>  arch/arm/mach-davinci/include/mach/spi.h    |   35 +-
>  drivers/spi/davinci_spi.c                   | 1112 ++++++++++++---------------
>  7 files changed, 528 insertions(+), 663 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
> index a319101..ad8779b 100644
> --- a/arch/arm/mach-davinci/board-dm355-evm.c
> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
> @@ -32,6 +32,7 @@
>  #include <mach/nand.h>
>  #include <mach/mmc.h>
>  #include <mach/usb.h>
> +#include <mach/spi.h>
>  
>  /* NOTE:  this is geared for the standard config, with a socketed
>   * 2 GByte Micron NAND (MT29F16G08FAA) using 128KB sectors.  If you
> @@ -300,10 +301,19 @@ static struct spi_eeprom at25640a = {
>  	.flags		= EE_ADDR2,
>  };
>  
> +static struct davinci_spi_config at25640a_spi_cfg = {
> +	.parity_enable	= false,
> +	.intr_level	= 0,
> +	.io_type	= SPI_IO_TYPE_DMA,
> +	.wdelay		= 0,
> +	.timer_disable	= true,
> +};
> +
>  static struct spi_board_info dm355_evm_spi_info[] __initconst = {
>  	{
>  		.modalias	= "at25",
>  		.platform_data	= &at25640a,
> +		.controller_data = &at25640a_spi_cfg,
>  		.max_speed_hz	= 10 * 1000 * 1000,	/* at 3v3 */
>  		.bus_num	= 0,
>  		.chip_select	= 0,
> diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
> index f1d8132..b2d8d48 100644
> --- a/arch/arm/mach-davinci/board-dm355-leopard.c
> +++ b/arch/arm/mach-davinci/board-dm355-leopard.c
> @@ -29,6 +29,7 @@
>  #include <mach/nand.h>
>  #include <mach/mmc.h>
>  #include <mach/usb.h>
> +#include <mach/spi.h>
>  
>  /* NOTE:  this is geared for the standard config, with a socketed
>   * 2 GByte Micron NAND (MT29F16G08FAA) using 128KB sectors.  If you
> @@ -222,10 +223,19 @@ static struct spi_eeprom at25640a = {
>  	.flags		= EE_ADDR2,
>  };
>  
> +static struct davinci_spi_config at25640a_spi_cfg = {
> +	.parity_enable	= false,
> +	.intr_level	= 0,
> +	.io_type	= SPI_IO_TYPE_DMA,
> +	.wdelay		= 0,
> +	.timer_disable  = true,
> +};
> +
>  static struct spi_board_info dm355_leopard_spi_info[] __initconst = {
>  	{
>  		.modalias	= "at25",
>  		.platform_data	= &at25640a,
> +		.controller_data = &at25640a_spi_cfg,
>  		.max_speed_hz	= 10 * 1000 * 1000,	/* at 3v3 */
>  		.bus_num	= 0,
>  		.chip_select	= 0,
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> index 5bb86b2..db85372 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -39,6 +39,7 @@
>  #include <mach/mmc.h>
>  #include <mach/nand.h>
>  #include <mach/keyscan.h>
> +#include <mach/spi.h>
>  
>  #include <media/tvp514x.h>
>  
> @@ -579,10 +580,19 @@ static struct spi_eeprom at25640 = {
>  	.flags		= EE_ADDR2,
>  };
>  
> +static struct davinci_spi_config at25640_spi_cfg = {
> +	.parity_enable	= false,
> +	.intr_level	= 0,
> +	.io_type	= SPI_IO_TYPE_DMA,
> +	.wdelay		= 0,
> +	.timer_disable	= true,
> +};
> +
>  static struct spi_board_info dm365_evm_spi_info[] __initconst = {
>  	{
>  		.modalias	= "at25",
>  		.platform_data	= &at25640,
> +		.controller_data = &at25640_spi_cfg,
>  		.max_speed_hz	= 10 * 1000 * 1000,
>  		.bus_num	= 0,
>  		.chip_select	= 0,
> diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
> index 3834781..f747c05 100644
> --- a/arch/arm/mach-davinci/dm355.c
> +++ b/arch/arm/mach-davinci/dm355.c
> @@ -410,14 +410,8 @@ static struct resource dm355_spi0_resources[] = {
>  };
>  
>  static struct davinci_spi_platform_data dm355_spi0_pdata = {
> -	.version 	= SPI_VERSION_1,
> +	.version 	= SPI_VERSION_0,
>  	.num_chipselect = 2,
> -	.clk_internal	= 1,
> -	.cs_hold	= 1,
> -	.intr_level	= 0,
> -	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
> -	.c2tdelay	= 0,
> -	.t2cdelay	= 0,
>  };
>  static struct platform_device dm355_spi0_device = {
>  	.name = "spi_davinci",
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index 652f4b6..4aea346 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -625,12 +625,6 @@ static u64 dm365_spi0_dma_mask = DMA_BIT_MASK(32);
>  static struct davinci_spi_platform_data dm365_spi0_pdata = {
>  	.version 	= SPI_VERSION_1,
>  	.num_chipselect = 2,
> -	.clk_internal	= 1,
> -	.cs_hold	= 1,
> -	.intr_level	= 0,
> -	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
> -	.c2tdelay	= 0,
> -	.t2cdelay	= 0,
>  };
>  
>  static struct resource dm365_spi0_resources[] = {
> diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
> index 910efbf..3f77dab 100644
> --- a/arch/arm/mach-davinci/include/mach/spi.h
> +++ b/arch/arm/mach-davinci/include/mach/spi.h
> @@ -19,26 +19,35 @@
>  #ifndef __ARCH_ARM_DAVINCI_SPI_H
>  #define __ARCH_ARM_DAVINCI_SPI_H
>  
> +#define SPI_INTERN_CS	0xFF
> +
>  enum {
> -	SPI_VERSION_1, /* For DM355/DM365/DM6467 */
> +	SPI_VERSION_0, /* For DM355 (reduced features, no Tx interrupt) */
> +	SPI_VERSION_1, /* For DM365/DM6467 (reduced features) */
>  	SPI_VERSION_2, /* For DA8xx */
>  };
>  
>  struct davinci_spi_platform_data {
>  	u8	version;
> -	u8	num_chipselect;
> -	u8	wdelay;
> -	u8	odd_parity;
> -	u8	parity_enable;
> -	u8	wait_enable;
> -	u8	timer_disable;
> -	u8	clk_internal;
> -	u8	cs_hold;
> +	u16	num_chipselect;
> +	u8	*chip_sel;
> +};
> +
> +struct davinci_spi_config {
> +	bool	odd_parity;
> +	bool	parity_enable;
>  	u8	intr_level;
> -	u8	poll_mode;
> -	u8	use_dma;
> -	u8	c2tdelay;
> -	u8	t2cdelay;
> +	u8	io_type;
> +#define SPI_IO_TYPE_INTR    0
> +#define SPI_IO_TYPE_POLL    1
> +#define SPI_IO_TYPE_DMA     2
> +	u8	bytes_per_word;
> +	u8	wdelay;
> +	bool	timer_disable;
> +	u8	c2t_delay;
> +	u8	t2c_delay;
> +	u8	t2e_delay;
> +	u8	c2e_delay;
>  };
>  
>  #endif	/* __ARCH_ARM_DAVINCI_SPI_H */
> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
> index b85090c..931130a 100644
> --- a/drivers/spi/davinci_spi.c
> +++ b/drivers/spi/davinci_spi.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (C) 2009 Texas Instruments.
> + * Copyright (C) 2010 EF Johnson Technologies
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -27,21 +28,19 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi_bitbang.h>
> -#include <linux/slab.h>
>  
>  #include <mach/spi.h>
>  #include <mach/edma.h>
>  
>  #define SPI_NO_RESOURCE		((resource_size_t)-1)
>  
> -#define SPI_MAX_CHIPSELECT	2
> -
>  #define CS_DEFAULT	0xFF
>  
>  #define SPI_BUFSIZ	(SMP_CACHE_BYTES + 1)
> -#define DAVINCI_DMA_DATA_TYPE_S8	0x01
> -#define DAVINCI_DMA_DATA_TYPE_S16	0x02
> -#define DAVINCI_DMA_DATA_TYPE_S32	0x04
> +
> +#define RX_DMA_INDEX		0
> +#define TX_DMA_INDEX		1
> +#define EVENTQ_DMA_INDEX	2
>  
>  #define SPIFMT_PHASE_MASK	BIT(16)
>  #define SPIFMT_POLARITY_MASK	BIT(17)
> @@ -53,9 +52,11 @@
>  #define SPIFMT_WDELAY_MASK	0x3f000000u
>  #define SPIFMT_WDELAY_SHIFT	24
>  #define SPIFMT_CHARLEN_MASK	0x0000001Fu
> +#define SPIFMT_PRESCALE_SHIFT	8
>  
>  /* SPIGCR1 */
> -#define SPIGCR1_SPIENA_MASK	0x01000000u
> +#define SPIGCR1_SPIENA_MASK	BIT(24)
> +#define SPIGCR1_POWERDOWN_MASK	BIT(8)
>  
>  /* SPIPC0 */
>  #define SPIPC0_DIFUN_MASK	BIT(11)		/* MISO */
> @@ -66,20 +67,38 @@
>  #define SPIPC0_EN0FUN_MASK	BIT(0)
>  
>  #define SPIINT_MASKALL		0x0101035F
> +#define SPIINT_MASKINT		0x0000035F
>  #define SPI_INTLVL_1		0x000001FFu
>  #define SPI_INTLVL_0		0x00000000u
>  
>  /* SPIDAT1 */
> +#define SPIDAT1_CSHOLD_MASK	BIT(28)
>  #define SPIDAT1_CSHOLD_SHIFT	28
> +#define SPIDAT1_WDEL_MASK	BIT(26)
> +#define SPIDAT1_CSNR_MASK	0x00FF0000u
>  #define SPIDAT1_CSNR_SHIFT	16
> +#define SPIDAT1_DFSEL_MASK	(BIT(24 | BIT(25))
>  #define SPIGCR1_CLKMOD_MASK	BIT(1)
> -#define SPIGCR1_MASTER_MASK     BIT(0)
> +#define SPIGCR1_MASTER_MASK	BIT(0)
>  #define SPIGCR1_LOOPBACK_MASK	BIT(16)
>  
>  /* SPIBUF */
>  #define SPIBUF_TXFULL_MASK	BIT(29)
>  #define SPIBUF_RXEMPTY_MASK	BIT(31)
>  
> +/* SPIDELAY */
> +#define SPIDELAY_C2TDELAY_MASK  0xFF000000u
> +#define SPIDELAY_C2TDELAY_SHIFT 24
> +#define SPIDELAY_T2CDELAY_MASK  0x00FF0000u
> +#define SPIDELAY_T2CDELAY_SHIFT 16
> +#define SPIDELAY_T2EDELAY_MASK  0x0000FF00u
> +#define SPIDELAY_T2EDELAY_SHIFT 8
> +#define SPIDELAY_C2EDELAY_MASK  0x000000FFu
> +#define SPIDELAY_C2EDELAY_SHIFT 0
> +
> +/* SPIDEF */
> +#define SPIDEF_CSDEF_MASK       0x000000FFu
> +
>  /* Error Masks */
>  #define SPIFLG_DLEN_ERR_MASK		BIT(0)
>  #define SPIFLG_TIMEOUT_MASK		BIT(1)
> @@ -90,11 +109,12 @@
>  #define SPIFLG_RX_INTR_MASK		BIT(8)
>  #define SPIFLG_TX_INTR_MASK		BIT(9)
>  #define SPIFLG_BUF_INIT_ACTIVE_MASK	BIT(24)
> -#define SPIFLG_MASK			(SPIFLG_DLEN_ERR_MASK \
> +#define SPIFLG_ERROR_MASK		(SPIFLG_DLEN_ERR_MASK \
>  				| SPIFLG_TIMEOUT_MASK | SPIFLG_PARERR_MASK \
>  				| SPIFLG_DESYNC_MASK | SPIFLG_BITERR_MASK \
> -				| SPIFLG_OVRRUN_MASK | SPIFLG_RX_INTR_MASK \
> -				| SPIFLG_TX_INTR_MASK \
> +				| SPIFLG_OVRRUN_MASK)
> +#define SPIFLG_MASK			(SPIFLG_ERROR_MASK \
> +				| SPIFLG_RX_INTR_MASK | SPIFLG_TX_INTR_MASK \
>  				| SPIFLG_BUF_INIT_ACTIVE_MASK)
>  
>  #define SPIINT_DLEN_ERR_INTR	BIT(0)
> @@ -139,11 +159,10 @@
>  #define TGINTVEC0	0x60
>  #define TGINTVEC1	0x64
>  
> -struct davinci_spi_slave {
> -	u32	cmd_to_write;
> -	u32	clk_ctrl_to_write;
> -	u32	bytes_per_word;
> -	u8	active_cs;
> +const char * const io_type_names[] = {
> +	[SPI_IO_TYPE_INTR] = "Interrupt",
> +	[SPI_IO_TYPE_POLL] = "Polled",
> +	[SPI_IO_TYPE_DMA] = "DMA",
>  };
>  
>  /* We have 2 DMA channels per CS, one for RX and one for TX */
> @@ -152,10 +171,8 @@ struct davinci_spi_dma {
>  	int			dma_rx_channel;
>  	int			dma_tx_sync_dev;
>  	int			dma_rx_sync_dev;
> +	int			dummy_param_slot;
>  	enum dma_event_q	eventq;
> -
> -	struct completion	dma_tx_completion;
> -	struct completion	dma_rx_completion;
>  };
>  
>  /* SPI Controller driver's private data. */
> @@ -173,51 +190,53 @@ struct davinci_spi {
>  	const void		*tx;
>  	void			*rx;
>  	u8			*tmp_buf;
> -	int			count;
> -	struct davinci_spi_dma	*dma_channels;
> -	struct			davinci_spi_platform_data *pdata;
> +	int			rcount;
> +	int			wcount;
> +	u32			errors;
> +	struct davinci_spi_dma	dma_channels;
> +	struct davinci_spi_platform_data *pdata;
>  
>  	void			(*get_rx)(u32 rx_data, struct davinci_spi *);
>  	u32			(*get_tx)(struct davinci_spi *);
> -
> -	struct davinci_spi_slave slave[SPI_MAX_CHIPSELECT];
>  };
>  
> -static unsigned use_dma;
> -
>  static void davinci_spi_rx_buf_u8(u32 data, struct davinci_spi *davinci_spi)
>  {
> -	u8 *rx = davinci_spi->rx;
> -
> -	*rx++ = (u8)data;
> -	davinci_spi->rx = rx;
> +	if (davinci_spi->rx) {
> +		u8 *rx = davinci_spi->rx;
> +		*rx++ = (u8)data;
> +		davinci_spi->rx = rx;
> +	}
>  }
>  
>  static void davinci_spi_rx_buf_u16(u32 data, struct davinci_spi *davinci_spi)
>  {
> -	u16 *rx = davinci_spi->rx;
> -
> -	*rx++ = (u16)data;
> -	davinci_spi->rx = rx;
> +	if (davinci_spi->rx) {
> +		u16 *rx = davinci_spi->rx;
> +		*rx++ = (u16)data;
> +		davinci_spi->rx = rx;
> +	}
>  }
>  
>  static u32 davinci_spi_tx_buf_u8(struct davinci_spi *davinci_spi)
>  {
> -	u32 data;
> -	const u8 *tx = davinci_spi->tx;
> -
> -	data = *tx++;
> -	davinci_spi->tx = tx;
> +	u32 data = 0;
> +	if (davinci_spi->tx) {
> +		const u8 *tx = davinci_spi->tx;
> +		data = *tx++;
> +		davinci_spi->tx = tx;
> +	}
>  	return data;
>  }
>  
>  static u32 davinci_spi_tx_buf_u16(struct davinci_spi *davinci_spi)
>  {
> -	u32 data;
> -	const u16 *tx = davinci_spi->tx;
> -
> -	data = *tx++;
> -	davinci_spi->tx = tx;
> +	u32 data = 0;
> +	if (davinci_spi->tx) {
> +		const u16 *tx = davinci_spi->tx;
> +		data = *tx++;
> +		davinci_spi->tx = tx;
> +	}
>  	return data;
>  }
>  
> @@ -237,26 +256,6 @@ static inline void clear_io_bits(void __iomem *addr, u32 bits)
>  	iowrite32(v, addr);
>  }
>  
> -static inline void set_fmt_bits(void __iomem *addr, u32 bits, int cs_num)
> -{
> -	set_io_bits(addr + SPIFMT0 + (0x4 * cs_num), bits);
> -}
> -
> -static inline void clear_fmt_bits(void __iomem *addr, u32 bits, int cs_num)
> -{
> -	clear_io_bits(addr + SPIFMT0 + (0x4 * cs_num), bits);
> -}
> -
> -static void davinci_spi_set_dma_req(const struct spi_device *spi, int enable)
> -{
> -	struct davinci_spi *davinci_spi = spi_master_get_devdata(spi->master);
> -
> -	if (enable)
> -		set_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
> -	else
> -		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
> -}
> -
>  /*
>   * Interface to control the chip select signal
>   */
> @@ -264,28 +263,57 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
>  {
>  	struct davinci_spi *davinci_spi;
>  	struct davinci_spi_platform_data *pdata;
> -	u32 data1_reg_val = 0;
> +	u8 i, chip_sel = spi->chip_select;
> +	u32 spidat1;
> +	u16 spidat1_cfg;
>  
>  	davinci_spi = spi_master_get_devdata(spi->master);
>  	pdata = davinci_spi->pdata;
>  
> -	/*
> -	 * Board specific chip select logic decides the polarity and cs
> -	 * line for the controller
> -	 */
> -	if (value == BITBANG_CS_INACTIVE) {
> -		set_io_bits(davinci_spi->base + SPIDEF, CS_DEFAULT);
> -
> -		data1_reg_val |= CS_DEFAULT << SPIDAT1_CSNR_SHIFT;
> -		iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
> +	spidat1 = SPIDAT1_CSNR_MASK;
> +	if (value == BITBANG_CS_ACTIVE)
> +		spidat1 |= SPIDAT1_CSHOLD_MASK;
> +	else
> +		spidat1 |= SPIDAT1_WDEL_MASK;
>  
> -		while ((ioread32(davinci_spi->base + SPIBUF)
> -					& SPIBUF_RXEMPTY_MASK) == 0)
> -			cpu_relax();
> +	if (pdata->chip_sel == NULL) {
> +		if (value == BITBANG_CS_ACTIVE)
> +			spidat1 &= ~((0x1 << chip_sel) << SPIDAT1_CSNR_SHIFT);
> +	} else {
> +		for (i = 0; i < pdata->num_chipselect; i++) {
> +			if (pdata->chip_sel[i] == SPI_INTERN_CS) {
> +				if ((i == chip_sel) &&
> +				    (value == BITBANG_CS_ACTIVE)) {
> +					spidat1 &= ~((0x1 << chip_sel)
> +						<< SPIDAT1_CSNR_SHIFT);
> +				}
> +			} else {
> +				if (value == BITBANG_CS_INACTIVE)
> +					gpio_set_value(pdata->chip_sel[i], 1);
> +				else if (i == chip_sel)
> +					gpio_set_value(pdata->chip_sel[i], 0);
> +			}
> +		}
>  	}
> +
> +	spidat1_cfg = spidat1 >> SPIDAT1_CSNR_SHIFT;
> +	iowrite16(spidat1_cfg, davinci_spi->base + SPIDAT1 + 2);
>  }
>  
> -/**
> +/*
> + * davinci_spi_get_prescale - Calculates the correct prescale value
> + * @max_speed_hz: the maximum rate the SPI clock can run at
> + *
> + * This function calculates the prescale value that generates a clock rate
> + * less than or equal to the specified maximum
> + */
> +static inline u32 davinci_spi_get_prescale(struct davinci_spi *davinci_spi,
> +						u32 max_speed_hz)
> +{
> +	return ((clk_get_rate(davinci_spi->clk) - 1) / max_speed_hz) & 0xff;
> +}
> +
> +/*
>   * davinci_spi_setup_transfer - This functions will determine transfer method
>   * @spi: spi device on which data transfer to be done
>   * @t: spi transfer in which transfer info is filled
> @@ -297,14 +325,15 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
>  static int davinci_spi_setup_transfer(struct spi_device *spi,
>  		struct spi_transfer *t)
>  {
> -
>  	struct davinci_spi *davinci_spi;
>  	struct davinci_spi_platform_data *pdata;
> +	struct davinci_spi_config *spi_cfg;
>  	u8 bits_per_word = 0;
> -	u32 hz = 0, prescale = 0, clkspeed;
> +	u32 hz = 0, spifmt = 0, prescale, delay = 0;
>  
>  	davinci_spi = spi_master_get_devdata(spi->master);
>  	pdata = davinci_spi->pdata;
> +	spi_cfg = spi->controller_data;
>  
>  	if (t) {
>  		bits_per_word = t->bits_per_word;
> @@ -322,76 +351,112 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
>  	if (bits_per_word <= 8 && bits_per_word >= 2) {
>  		davinci_spi->get_rx = davinci_spi_rx_buf_u8;
>  		davinci_spi->get_tx = davinci_spi_tx_buf_u8;
> -		davinci_spi->slave[spi->chip_select].bytes_per_word = 1;
> +		spi_cfg->bytes_per_word = 1;
>  	} else if (bits_per_word <= 16 && bits_per_word >= 2) {
>  		davinci_spi->get_rx = davinci_spi_rx_buf_u16;
>  		davinci_spi->get_tx = davinci_spi_tx_buf_u16;
> -		davinci_spi->slave[spi->chip_select].bytes_per_word = 2;
> +		spi_cfg->bytes_per_word = 2;
>  	} else
>  		return -EINVAL;
>  
>  	if (!hz)
>  		hz = spi->max_speed_hz;
>  
> -	clear_fmt_bits(davinci_spi->base, SPIFMT_CHARLEN_MASK,
> -			spi->chip_select);
> -	set_fmt_bits(davinci_spi->base, bits_per_word & 0x1f,
> -			spi->chip_select);
> +	prescale = davinci_spi_get_prescale(davinci_spi, hz);
> +	spifmt |= (prescale << SPIFMT_PRESCALE_SHIFT);
>  
> -	clkspeed = clk_get_rate(davinci_spi->clk);
> -	if (hz > clkspeed / 2)
> -		prescale = 1 << 8;
> -	if (hz < clkspeed / 256)
> -		prescale = 255 << 8;
> -	if (!prescale)
> -		prescale = ((clkspeed / hz - 1) << 8) & 0x0000ff00;
> +	spifmt |= (bits_per_word & 0x1f);
> +
> +	if (spi->mode & SPI_LSB_FIRST)
> +		spifmt |= SPIFMT_SHIFTDIR_MASK;
> +
> +	if (spi->mode & SPI_CPOL)
> +		spifmt |= SPIFMT_POLARITY_MASK;
>  
> -	clear_fmt_bits(davinci_spi->base, 0x0000ff00, spi->chip_select);
> -	set_fmt_bits(davinci_spi->base, prescale, spi->chip_select);
> +	if (!(spi->mode & SPI_CPHA))
> +		spifmt |= SPIFMT_PHASE_MASK;
> +
> +	if (davinci_spi->version == SPI_VERSION_2) {
> +		spifmt |= ((spi_cfg->wdelay << SPIFMT_WDELAY_SHIFT)
> +				& SPIFMT_WDELAY_MASK);
> +
> +		if (spi_cfg->odd_parity)
> +			spifmt |= SPIFMT_ODD_PARITY_MASK;
> +
> +		if (spi_cfg->parity_enable)
> +			spifmt |= SPIFMT_PARITYENA_MASK;
> +
> +		if (spi->mode & SPI_READY) {
> +			spifmt |= SPIFMT_WAITENA_MASK;
> +			delay |= (spi_cfg->t2e_delay
> +					<< SPIDELAY_T2EDELAY_SHIFT)
> +						& SPIDELAY_T2EDELAY_MASK;
> +			delay |= (spi_cfg->c2e_delay
> +					<< SPIDELAY_C2EDELAY_SHIFT)
> +						& SPIDELAY_C2EDELAY_MASK;
> +		}
> +
> +		if (spi_cfg->timer_disable) {
> +			spifmt |= SPIFMT_DISTIMER_MASK;
> +		} else {
> +			delay |= (spi_cfg->c2t_delay
> +					<< SPIDELAY_C2TDELAY_SHIFT)
> +						& SPIDELAY_C2TDELAY_MASK;
> +			delay |= (spi_cfg->t2c_delay
> +					<< SPIDELAY_T2CDELAY_SHIFT)
> +						& SPIDELAY_T2CDELAY_MASK;
> +		}
> +
> +		iowrite32(delay, davinci_spi->base + SPIDELAY);
> +	}
> +
> +	iowrite32(spifmt, davinci_spi->base + SPIFMT0);
> +
> +	if (spi_cfg->intr_level)
> +		iowrite32(SPI_INTLVL_1, davinci_spi->base + SPILVL);
> +	else
> +		iowrite32(SPI_INTLVL_0, davinci_spi->base + SPILVL);
> +
> +	if (spi->mode & SPI_LOOP)
> +		set_io_bits(davinci_spi->base + SPIGCR1,
> +				SPIGCR1_LOOPBACK_MASK);
> +	else
> +		clear_io_bits(davinci_spi->base + SPIGCR1,
> +				SPIGCR1_LOOPBACK_MASK);
>  
>  	return 0;
>  }
>  
>  static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, void *data)
>  {
> -	struct spi_device *spi = (struct spi_device *)data;
> -	struct davinci_spi *davinci_spi;
> +	struct davinci_spi *davinci_spi = (struct davinci_spi *)data;

data is a void*, you don't need the cast.

>  	struct davinci_spi_dma *davinci_spi_dma;
>  	struct davinci_spi_platform_data *pdata;
>  
> -	davinci_spi = spi_master_get_devdata(spi->master);
> -	davinci_spi_dma = &(davinci_spi->dma_channels[spi->chip_select]);
> +	davinci_spi_dma = &(davinci_spi->dma_channels);
>  	pdata = davinci_spi->pdata;
>  
> +	edma_stop(davinci_spi_dma->dma_rx_channel);
> +
>  	if (ch_status == DMA_COMPLETE)
> -		edma_stop(davinci_spi_dma->dma_rx_channel);
> -	else
> -		edma_clean_channel(davinci_spi_dma->dma_rx_channel);
> +		davinci_spi->rcount = 0;
>  
> -	complete(&davinci_spi_dma->dma_rx_completion);
> -	/* We must disable the DMA RX request */
> -	davinci_spi_set_dma_req(spi, 0);
> +	complete(&davinci_spi->done);
>  }
>  
>  static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, void *data)
>  {
> -	struct spi_device *spi = (struct spi_device *)data;
> -	struct davinci_spi *davinci_spi;
> +	struct davinci_spi *davinci_spi = (struct davinci_spi *)data;

ditto

>  	struct davinci_spi_dma *davinci_spi_dma;
>  	struct davinci_spi_platform_data *pdata;
>  
> -	davinci_spi = spi_master_get_devdata(spi->master);
> -	davinci_spi_dma = &(davinci_spi->dma_channels[spi->chip_select]);
> +	davinci_spi_dma = &(davinci_spi->dma_channels);
>  	pdata = davinci_spi->pdata;
>  
> -	if (ch_status == DMA_COMPLETE)
> -		edma_stop(davinci_spi_dma->dma_tx_channel);
> -	else
> -		edma_clean_channel(davinci_spi_dma->dma_tx_channel);
> +	edma_stop(davinci_spi_dma->dma_tx_channel);
>  
> -	complete(&davinci_spi_dma->dma_tx_completion);
> -	/* We must disable the DMA TX request */
> -	davinci_spi_set_dma_req(spi, 0);
> +	if (ch_status == DMA_COMPLETE)
> +		davinci_spi->wcount = 0;
>  }
>  
>  static int davinci_spi_request_dma(struct spi_device *spi)
> @@ -403,33 +468,54 @@ static int davinci_spi_request_dma(struct spi_device *spi)
>  	int r;
>  
>  	davinci_spi = spi_master_get_devdata(spi->master);
> -	davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
> +	davinci_spi_dma = &davinci_spi->dma_channels;
>  	pdata = davinci_spi->pdata;
>  	sdev = davinci_spi->bitbang.master->dev.parent;
>  
>  	r = edma_alloc_channel(davinci_spi_dma->dma_rx_sync_dev,
> -				davinci_spi_dma_rx_callback, spi,
> +				davinci_spi_dma_rx_callback, davinci_spi,
>  				davinci_spi_dma->eventq);
>  	if (r < 0) {
> -		dev_dbg(sdev, "Unable to request DMA channel for SPI RX\n");
> -		return -EAGAIN;
> +		dev_dbg(sdev, "Unable to request DMA channel for MibSPI RX\n");
> +		r =  -EAGAIN;
> +		goto rx_dma_failed;
>  	}
>  	davinci_spi_dma->dma_rx_channel = r;
> +
>  	r = edma_alloc_channel(davinci_spi_dma->dma_tx_sync_dev,
> -				davinci_spi_dma_tx_callback, spi,
> +				davinci_spi_dma_tx_callback, davinci_spi,
>  				davinci_spi_dma->eventq);
>  	if (r < 0) {
> -		edma_free_channel(davinci_spi_dma->dma_rx_channel);
> -		davinci_spi_dma->dma_rx_channel = -1;
> -		dev_dbg(sdev, "Unable to request DMA channel for SPI TX\n");
> -		return -EAGAIN;
> +		dev_dbg(sdev, "Unable to request DMA channel for MibSPI TX\n");
> +		r = -EAGAIN;
> +		goto tx_dma_failed;
>  	}
>  	davinci_spi_dma->dma_tx_channel = r;
>  
> +	r = edma_alloc_slot(EDMA_CTLR(davinci_spi_dma->dma_tx_sync_dev),
> +				EDMA_SLOT_ANY);
> +	if (r < 0) {
> +		dev_dbg(sdev, "Unable to request SPI DMA param slot\n");
> +		r = -EAGAIN;
> +		goto param_failed;
> +	}
> +	davinci_spi_dma->dummy_param_slot = r;
> +	edma_link(davinci_spi_dma->dummy_param_slot,
> +		  davinci_spi_dma->dummy_param_slot);
> +
>  	return 0;
> +
> +param_failed:
> +	edma_free_channel(davinci_spi_dma->dma_tx_channel);
> +	davinci_spi_dma->dma_tx_channel = -1;
> +tx_dma_failed:
> +	edma_free_channel(davinci_spi_dma->dma_rx_channel);
> +	davinci_spi_dma->dma_rx_channel = -1;
> +rx_dma_failed:
> +	return r;
>  }
>  
> -/**
> +/*

Don't change this.  /** means kernel-doc format.  Ditto throughout the file.

>   * davinci_spi_setup - This functions will set default transfer method
>   * @spi: spi device on which data transfer to be done
>   *
> @@ -438,129 +524,54 @@ static int davinci_spi_request_dma(struct spi_device *spi)
>  
>  static int davinci_spi_setup(struct spi_device *spi)
>  {
> -	int retval;
> +	int retval = 0;
>  	struct davinci_spi *davinci_spi;
> -	struct davinci_spi_dma *davinci_spi_dma;
> -	struct device *sdev;
> +	struct davinci_spi_dma *davinci_dma;
> +	struct davinci_spi_platform_data *pdata;
> +	struct davinci_spi_config *spi_cfg;
> +	u32 prescale;
>  
>  	davinci_spi = spi_master_get_devdata(spi->master);
> -	sdev = davinci_spi->bitbang.master->dev.parent;
> +	pdata = davinci_spi->pdata;
> +	spi_cfg = (struct davinci_spi_config *)spi->controller_data;
> +	davinci_dma = &(davinci_spi->dma_channels);
>  
>  	/* if bits per word length is zero then set it default 8 */
>  	if (!spi->bits_per_word)
>  		spi->bits_per_word = 8;
>  
> -	davinci_spi->slave[spi->chip_select].cmd_to_write = 0;
> +	if (!(spi->mode & SPI_NO_CS)) {
> +		if ((pdata->chip_sel == NULL) ||
> +		    (pdata->chip_sel[spi->chip_select] == SPI_INTERN_CS))
> +			set_io_bits(davinci_spi->base + SPIPC0,
> +					1 << spi->chip_select);
>  
> -	if (use_dma && davinci_spi->dma_channels) {
> -		davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
> -
> -		if ((davinci_spi_dma->dma_rx_channel == -1)
> -				|| (davinci_spi_dma->dma_tx_channel == -1)) {
> -			retval = davinci_spi_request_dma(spi);
> -			if (retval < 0)
> -				return retval;
> -		}
> -	}
> -
> -	/*
> -	 * SPI in DaVinci and DA8xx operate between
> -	 * 600 KHz and 50 MHz
> -	 */
> -	if (spi->max_speed_hz < 600000 || spi->max_speed_hz > 50000000) {
> -		dev_dbg(sdev, "Operating frequency is not in acceptable "
> -				"range\n");
> -		return -EINVAL;
>  	}
>  
> -	/*
> -	 * Set up SPIFMTn register, unique to this chipselect.
> -	 *
> -	 * NOTE: we could do all of these with one write.  Also, some
> -	 * of the "version 2" features are found in chips that don't
> -	 * support all of them...
> -	 */
> -	if (spi->mode & SPI_LSB_FIRST)
> -		set_fmt_bits(davinci_spi->base, SPIFMT_SHIFTDIR_MASK,
> -				spi->chip_select);
> -	else
> -		clear_fmt_bits(davinci_spi->base, SPIFMT_SHIFTDIR_MASK,
> -				spi->chip_select);
> +	if (spi->mode & SPI_READY)
> +		set_io_bits(davinci_spi->base + SPIPC0, SPIPC0_SPIENA_MASK);
>  
> -	if (spi->mode & SPI_CPOL)
> -		set_fmt_bits(davinci_spi->base, SPIFMT_POLARITY_MASK,
> -				spi->chip_select);
> -	else
> -		clear_fmt_bits(davinci_spi->base, SPIFMT_POLARITY_MASK,
> -				spi->chip_select);
> +	if (spi_cfg->io_type == SPI_IO_TYPE_DMA) {
> +		davinci_dma = &(davinci_spi->dma_channels);
>  
> -	if (!(spi->mode & SPI_CPHA))
> -		set_fmt_bits(davinci_spi->base, SPIFMT_PHASE_MASK,
> -				spi->chip_select);
> -	else
> -		clear_fmt_bits(davinci_spi->base, SPIFMT_PHASE_MASK,
> -				spi->chip_select);
> +		if ((davinci_dma->dma_tx_sync_dev == SPI_NO_RESOURCE) ||
> +		    (davinci_dma->dma_rx_sync_dev == SPI_NO_RESOURCE) ||
> +		    (davinci_dma->eventq == SPI_NO_RESOURCE))
> +			spi_cfg->io_type = SPI_IO_TYPE_INTR;
> +		else if ((davinci_dma->dma_rx_channel == -1) ||
> +			 (davinci_dma->dma_tx_channel == -1))
> +			retval = davinci_spi_request_dma(spi);
> +	}
>  
>  	/*
> -	 * Version 1 hardware supports two basic SPI modes:
> -	 *  - Standard SPI mode uses 4 pins, with chipselect
> -	 *  - 3 pin SPI is a 4 pin variant without CS (SPI_NO_CS)
> -	 *	(distinct from SPI_3WIRE, with just one data wire;
> -	 *	or similar variants without MOSI or without MISO)
> -	 *
> -	 * Version 2 hardware supports an optional handshaking signal,
> -	 * so it can support two more modes:
> -	 *  - 5 pin SPI variant is standard SPI plus SPI_READY
> -	 *  - 4 pin with enable is (SPI_READY | SPI_NO_CS)
> +	 * Validate desired clock rate
>  	 */
> +	prescale = davinci_spi_get_prescale(davinci_spi, spi->max_speed_hz);
> +	if ((prescale < 2) || (prescale > 255))
> +		return -EINVAL;
>  
> -	if (davinci_spi->version == SPI_VERSION_2) {
> -		clear_fmt_bits(davinci_spi->base, SPIFMT_WDELAY_MASK,
> -				spi->chip_select);
> -		set_fmt_bits(davinci_spi->base,
> -				(davinci_spi->pdata->wdelay
> -						<< SPIFMT_WDELAY_SHIFT)
> -					& SPIFMT_WDELAY_MASK,
> -				spi->chip_select);
> -
> -		if (davinci_spi->pdata->odd_parity)
> -			set_fmt_bits(davinci_spi->base,
> -					SPIFMT_ODD_PARITY_MASK,
> -					spi->chip_select);
> -		else
> -			clear_fmt_bits(davinci_spi->base,
> -					SPIFMT_ODD_PARITY_MASK,
> -					spi->chip_select);
> -
> -		if (davinci_spi->pdata->parity_enable)
> -			set_fmt_bits(davinci_spi->base,
> -					SPIFMT_PARITYENA_MASK,
> -					spi->chip_select);
> -		else
> -			clear_fmt_bits(davinci_spi->base,
> -					SPIFMT_PARITYENA_MASK,
> -					spi->chip_select);
> -
> -		if (davinci_spi->pdata->wait_enable)
> -			set_fmt_bits(davinci_spi->base,
> -					SPIFMT_WAITENA_MASK,
> -					spi->chip_select);
> -		else
> -			clear_fmt_bits(davinci_spi->base,
> -					SPIFMT_WAITENA_MASK,
> -					spi->chip_select);
> -
> -		if (davinci_spi->pdata->timer_disable)
> -			set_fmt_bits(davinci_spi->base,
> -					SPIFMT_DISTIMER_MASK,
> -					spi->chip_select);
> -		else
> -			clear_fmt_bits(davinci_spi->base,
> -					SPIFMT_DISTIMER_MASK,
> -					spi->chip_select);
> -	}
> -
> -	retval = davinci_spi_setup_transfer(spi, NULL);
> +	dev_info(&spi->dev, "DaVinci SPI driver in %s mode\n",
> +			io_type_names[spi_cfg->io_type]);
>  
>  	return retval;
>  }
> @@ -569,50 +580,19 @@ static void davinci_spi_cleanup(struct spi_device *spi)
>  {
>  	struct davinci_spi *davinci_spi = spi_master_get_devdata(spi->master);
>  	struct davinci_spi_dma *davinci_spi_dma;
> +	struct davinci_spi_platform_data *pdata;
>  
> -	davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
> -
> -	if (use_dma && davinci_spi->dma_channels) {
> -		davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
> -
> -		if ((davinci_spi_dma->dma_rx_channel != -1)
> -				&& (davinci_spi_dma->dma_tx_channel != -1)) {
> -			edma_free_channel(davinci_spi_dma->dma_tx_channel);
> -			edma_free_channel(davinci_spi_dma->dma_rx_channel);
> -		}
> -	}
> -}
> -
> -static int davinci_spi_bufs_prep(struct spi_device *spi,
> -				 struct davinci_spi *davinci_spi)
> -{
> -	int op_mode = 0;
> -
> -	/*
> -	 * REVISIT  unless devices disagree about SPI_LOOP or
> -	 * SPI_READY (SPI_NO_CS only allows one device!), this
> -	 * should not need to be done before each message...
> -	 * optimize for both flags staying cleared.
> -	 */
> -
> -	op_mode = SPIPC0_DIFUN_MASK
> -		| SPIPC0_DOFUN_MASK
> -		| SPIPC0_CLKFUN_MASK;
> -	if (!(spi->mode & SPI_NO_CS))
> -		op_mode |= 1 << spi->chip_select;
> -	if (spi->mode & SPI_READY)
> -		op_mode |= SPIPC0_SPIENA_MASK;
> +	davinci_spi_dma = &davinci_spi->dma_channels;
> +	pdata = davinci_spi->pdata;
>  
> -	iowrite32(op_mode, davinci_spi->base + SPIPC0);
> +	if (davinci_spi_dma->dma_rx_channel != -1)
> +		edma_free_channel(davinci_spi_dma->dma_rx_channel);
>  
> -	if (spi->mode & SPI_LOOP)
> -		set_io_bits(davinci_spi->base + SPIGCR1,
> -				SPIGCR1_LOOPBACK_MASK);
> -	else
> -		clear_io_bits(davinci_spi->base + SPIGCR1,
> -				SPIGCR1_LOOPBACK_MASK);
> +	if (davinci_spi_dma->dma_tx_channel != -1)
> +		edma_free_channel(davinci_spi_dma->dma_tx_channel);
>  
> -	return 0;
> +	if (davinci_spi_dma->dummy_param_slot != -1)
> +		edma_free_slot(davinci_spi_dma->dummy_param_slot);
>  }
>  
>  static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
> @@ -659,356 +639,243 @@ static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
>  	return 0;
>  }
>  
> -/**
> - * davinci_spi_bufs - functions which will handle transfer data
> - * @spi: spi device on which data transfer to be done
> - * @t: spi transfer in which transfer info is filled
> +/*
> + * davinci_spi_process_events - check for and handle any SPI controller events
> + * @davinci_spi - the controller data
>   *
> - * This function will put data to be transferred into data register
> - * of SPI controller and then wait until the completion will be marked
> - * by the IRQ Handler.
> + * This function will check the SPIFLG register and handle any events that are
> + * detected there
>   */
> -static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
> +static int davinci_spi_process_events(struct davinci_spi *davinci_spi)
>  {
> -	struct davinci_spi *davinci_spi;
> -	int int_status, count, ret;
> -	u8 conv, tmp;
> -	u32 tx_data, data1_reg_val;
> -	u32 buf_val, flg_val;
> -	struct davinci_spi_platform_data *pdata;
> -
> -	davinci_spi = spi_master_get_devdata(spi->master);
> -	pdata = davinci_spi->pdata;
> -
> -	davinci_spi->tx = t->tx_buf;
> -	davinci_spi->rx = t->rx_buf;
> -
> -	/* convert len to words based on bits_per_word */
> -	conv = davinci_spi->slave[spi->chip_select].bytes_per_word;
> -	davinci_spi->count = t->len / conv;
> -
> -	INIT_COMPLETION(davinci_spi->done);
> -
> -	ret = davinci_spi_bufs_prep(spi, davinci_spi);
> -	if (ret)
> -		return ret;
> -
> -	/* Enable SPI */
> -	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
> -
> -	iowrite32(0 | (pdata->c2tdelay << SPI_C2TDELAY_SHIFT) |
> -			(pdata->t2cdelay << SPI_T2CDELAY_SHIFT),
> -			davinci_spi->base + SPIDELAY);
> -
> -	count = davinci_spi->count;
> -	data1_reg_val = pdata->cs_hold << SPIDAT1_CSHOLD_SHIFT;
> -	tmp = ~(0x1 << spi->chip_select);
> -
> -	clear_io_bits(davinci_spi->base + SPIDEF, ~tmp);
> -
> -	data1_reg_val |= tmp << SPIDAT1_CSNR_SHIFT;
> -
> -	while ((ioread32(davinci_spi->base + SPIBUF)
> -				& SPIBUF_RXEMPTY_MASK) == 0)
> -		cpu_relax();
> -
> -	/* Determine the command to execute READ or WRITE */
> -	if (t->tx_buf) {
> -		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
> -
> -		while (1) {
> -			tx_data = davinci_spi->get_tx(davinci_spi);
> -
> -			data1_reg_val &= ~(0xFFFF);
> -			data1_reg_val |= (0xFFFF & tx_data);
> -
> -			buf_val = ioread32(davinci_spi->base + SPIBUF);
> -			if ((buf_val & SPIBUF_TXFULL_MASK) == 0) {
> -				iowrite32(data1_reg_val,
> -						davinci_spi->base + SPIDAT1);
> -
> -				count--;
> -			}
> -			while (ioread32(davinci_spi->base + SPIBUF)
> -					& SPIBUF_RXEMPTY_MASK)
> -				cpu_relax();
> -
> -			/* getting the returned byte */
> -			if (t->rx_buf) {
> -				buf_val = ioread32(davinci_spi->base + SPIBUF);
> -				davinci_spi->get_rx(buf_val, davinci_spi);
> -			}
> -			if (count <= 0)
> -				break;
> -		}
> -	} else {
> -		if (pdata->poll_mode) {
> -			while (1) {
> -				/* keeps the serial clock going */
> -				if ((ioread32(davinci_spi->base + SPIBUF)
> -						& SPIBUF_TXFULL_MASK) == 0)
> -					iowrite32(data1_reg_val,
> -						davinci_spi->base + SPIDAT1);
> -
> -				while (ioread32(davinci_spi->base + SPIBUF) &
> -						SPIBUF_RXEMPTY_MASK)
> -					cpu_relax();
> -
> -				flg_val = ioread32(davinci_spi->base + SPIFLG);
> -				buf_val = ioread32(davinci_spi->base + SPIBUF);
> -
> -				davinci_spi->get_rx(buf_val, davinci_spi);
> -
> -				count--;
> -				if (count <= 0)
> -					break;
> -			}
> -		} else {	/* Receive in Interrupt mode */
> -			int i;
> -
> -			for (i = 0; i < davinci_spi->count; i++) {
> -				set_io_bits(davinci_spi->base + SPIINT,
> -						SPIINT_BITERR_INTR
> -						| SPIINT_OVRRUN_INTR
> -						| SPIINT_RX_INTR);
> -
> -				iowrite32(data1_reg_val,
> -						davinci_spi->base + SPIDAT1);
> -
> -				while (ioread32(davinci_spi->base + SPIINT) &
> -						SPIINT_RX_INTR)
> -					cpu_relax();
> -			}
> -			iowrite32((data1_reg_val & 0x0ffcffff),
> -					davinci_spi->base + SPIDAT1);
> -		}
> +	u32 status, tx_data, rx_data, spidat1;
> +	u8 tx_word = 0;
> +
> +	status = ioread32(davinci_spi->base + SPIFLG);
> +
> +	if ((davinci_spi->version != SPI_VERSION_0) &&
> +	    (likely(status & SPIFLG_TX_INTR_MASK)) &&
> +	    (likely(davinci_spi->wcount > 0)))
> +		tx_word = 1;
> +
> +	if (likely(status & SPIFLG_RX_INTR_MASK)) {
> +		rx_data = ioread32(davinci_spi->base + SPIBUF) & 0xFFFF;
> +		davinci_spi->get_rx(rx_data, davinci_spi);
> +		davinci_spi->rcount--;
> +		if ((davinci_spi->version == SPI_VERSION_0) &&
> +		    (likely(davinci_spi->wcount > 0)))
> +			tx_word = 1;
>  	}
>  
> -	/*
> -	 * Check for bit error, desync error,parity error,timeout error and
> -	 * receive overflow errors
> -	 */
> -	int_status = ioread32(davinci_spi->base + SPIFLG);
> -
> -	ret = davinci_spi_check_error(davinci_spi, int_status);
> -	if (ret != 0)
> -		return ret;
> +	if (unlikely(status & SPIFLG_ERROR_MASK)) {
> +		davinci_spi->errors = (status & SPIFLG_ERROR_MASK);
> +		return -1;
> +	}
>  
> -	/* SPI Framework maintains the count only in bytes so convert back */
> -	davinci_spi->count *= conv;
> +	if (likely(tx_word)) {
> +		spidat1 = ioread32(davinci_spi->base + SPIDAT1);
> +		davinci_spi->wcount--;
> +		tx_data = davinci_spi->get_tx(davinci_spi);
> +		spidat1 &= 0xFFFF0000;
> +		spidat1 |= (tx_data & 0xFFFF);
> +		iowrite32(spidat1, davinci_spi->base + SPIDAT1);
> +	}
>  
> -	return t->len;
> +	return 0;
>  }
>  
> -#define DAVINCI_DMA_DATA_TYPE_S8	0x01
> -#define DAVINCI_DMA_DATA_TYPE_S16	0x02
> -#define DAVINCI_DMA_DATA_TYPE_S32	0x04
> -
> -static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
> +/*
> + * davinci_spi_txrx_bufs - function which will handle transfer data
> + * @spi: spi device on which data transfer to be done
> + * @t: spi transfer in which transfer info is filled
> + *
> + * This function will put data to be transferred into data register
> + * of SPI controller and then wait until the completion will be marked
> + * by the IRQ Handler.
> + */
> +static int davinci_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
>  {
>  	struct davinci_spi *davinci_spi;
> -	int int_status = 0;
> -	int count, temp_count;
> -	u8 conv = 1;
> -	u8 tmp;
> -	u32 data1_reg_val;
> -	struct davinci_spi_dma *davinci_spi_dma;
> -	int word_len, data_type, ret;
> -	unsigned long tx_reg, rx_reg;
> +	int data_type, ret = 0;
> +	u32 tx_data, spidat1;
> +	u16 tx_buf_count = 0, rx_buf_count = 0;
> +	struct davinci_spi_config *spi_cfg;
>  	struct davinci_spi_platform_data *pdata;
> +	struct davinci_spi_dma *davinci_dma;
>  	struct device *sdev;
> +	dma_addr_t tx_reg, rx_reg;
> +	void *tx_buf, *rx_buf;
> +	struct edmacc_param rx_param, tx_param;
>  
>  	davinci_spi = spi_master_get_devdata(spi->master);
>  	pdata = davinci_spi->pdata;
> -	sdev = davinci_spi->bitbang.master->dev.parent;
> -
> -	davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
> -
> -	tx_reg = (unsigned long)davinci_spi->pbase + SPIDAT1;
> -	rx_reg = (unsigned long)davinci_spi->pbase + SPIBUF;
> +	spi_cfg = (struct davinci_spi_config *)spi->controller_data;
> +	davinci_dma = &(davinci_spi->dma_channels);
>  
>  	davinci_spi->tx = t->tx_buf;
>  	davinci_spi->rx = t->rx_buf;
> +	davinci_spi->wcount = t->len / spi_cfg->bytes_per_word;
> +	davinci_spi->rcount = davinci_spi->wcount;
> +	davinci_spi->errors = 0;
>  
> -	/* convert len to words based on bits_per_word */
> -	conv = davinci_spi->slave[spi->chip_select].bytes_per_word;
> -	davinci_spi->count = t->len / conv;
> -
> -	INIT_COMPLETION(davinci_spi->done);
> -
> -	init_completion(&davinci_spi_dma->dma_rx_completion);
> -	init_completion(&davinci_spi_dma->dma_tx_completion);
> -
> -	word_len = conv * 8;
> -
> -	if (word_len <= 8)
> -		data_type = DAVINCI_DMA_DATA_TYPE_S8;
> -	else if (word_len <= 16)
> -		data_type = DAVINCI_DMA_DATA_TYPE_S16;
> -	else if (word_len <= 32)
> -		data_type = DAVINCI_DMA_DATA_TYPE_S32;
> -	else
> -		return -EINVAL;
> -
> -	ret = davinci_spi_bufs_prep(spi, davinci_spi);
> -	if (ret)
> -		return ret;
> -
> -	/* Put delay val if required */
> -	iowrite32(0 | (pdata->c2tdelay << SPI_C2TDELAY_SHIFT) |
> -			(pdata->t2cdelay << SPI_T2CDELAY_SHIFT),
> -			davinci_spi->base + SPIDELAY);
> -
> -	count = davinci_spi->count;	/* the number of elements */
> -	data1_reg_val = pdata->cs_hold << SPIDAT1_CSHOLD_SHIFT;
> +	spidat1 = ioread32(davinci_spi->base + SPIDAT1);
>  
> -	/* CS default = 0xFF */
> -	tmp = ~(0x1 << spi->chip_select);
> -
> -	clear_io_bits(davinci_spi->base + SPIDEF, ~tmp);
> -
> -	data1_reg_val |= tmp << SPIDAT1_CSNR_SHIFT;
> -
> -	/* disable all interrupts for dma transfers */
> -	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
> -	/* Disable SPI to write configuration bits in SPIDAT */
> -	clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
> -	iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
> -	/* Enable SPI */
> +	clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
>  	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
>  
> -	while ((ioread32(davinci_spi->base + SPIBUF)
> -				& SPIBUF_RXEMPTY_MASK) == 0)
> -		cpu_relax();
> -
> +	INIT_COMPLETION(davinci_spi->done);
>  
> -	if (t->tx_buf) {
> -		t->tx_dma = dma_map_single(&spi->dev, (void *)t->tx_buf, count,
> -				DMA_TO_DEVICE);
> -		if (dma_mapping_error(&spi->dev, t->tx_dma)) {
> -			dev_dbg(sdev, "Unable to DMA map a %d bytes"
> -				" TX buffer\n", count);
> -			return -ENOMEM;
> +	if ((spi_cfg->io_type == SPI_IO_TYPE_INTR) ||
> +	    (spi_cfg->io_type == SPI_IO_TYPE_POLL)) {
> +
> +		if (spi_cfg->io_type == SPI_IO_TYPE_INTR)
> +			set_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKINT);
> +
> +		/* start the transfer */
> +		davinci_spi->wcount--;
> +		tx_data = davinci_spi->get_tx(davinci_spi);
> +		spidat1 &= 0xFFFF0000;
> +		spidat1 |= (tx_data & 0xFFFF);
> +		iowrite32(spidat1, davinci_spi->base + SPIDAT1);
> +
> +	} else if (spi_cfg->io_type == SPI_IO_TYPE_DMA) {
> +		data_type = spi_cfg->bytes_per_word;
> +		tx_reg = (dma_addr_t)davinci_spi->pbase + SPIDAT1;
> +		rx_reg = (dma_addr_t)davinci_spi->pbase + SPIBUF;
> +
> +		if (t->tx_buf) {
> +			tx_buf = ((void *)t->tx_buf);
> +			tx_buf_count = davinci_spi->wcount;
> +		} else {
> +			tx_buf = (void *)davinci_spi->tmp_buf;
> +			tx_buf_count = SPI_BUFSIZ;
>  		}
> -		temp_count = count;
> -	} else {
> -		/* We need TX clocking for RX transaction */
> -		t->tx_dma = dma_map_single(&spi->dev,
> -				(void *)davinci_spi->tmp_buf, count + 1,
> -				DMA_TO_DEVICE);
> -		if (dma_mapping_error(&spi->dev, t->tx_dma)) {
> -			dev_dbg(sdev, "Unable to DMA map a %d bytes"
> -				" TX tmp buffer\n", count);
> -			return -ENOMEM;
> +		if (t->rx_buf) {
> +			rx_buf = (void *)t->rx_buf;
> +			rx_buf_count = davinci_spi->rcount;
> +		} else {
> +			rx_buf = (void *)davinci_spi->tmp_buf;
> +			rx_buf_count = SPI_BUFSIZ;
>  		}
> -		temp_count = count + 1;
> +
> +		t->tx_dma = dma_map_single(&spi->dev, tx_buf,
> +						tx_buf_count, DMA_TO_DEVICE);
> +		t->rx_dma = dma_map_single(&spi->dev, rx_buf,
> +						rx_buf_count, DMA_FROM_DEVICE);
> +
> +		tx_param.opt = TCINTEN | EDMA_TCC(davinci_dma->dma_tx_channel);
> +		tx_param.src = t->tx_buf ? t->tx_dma : tx_reg;
> +		tx_param.a_b_cnt = davinci_spi->wcount << 16 | data_type;
> +		tx_param.dst = tx_reg;
> +		tx_param.src_dst_bidx = t->tx_buf ? data_type : 0;
> +		tx_param.link_bcntrld = 0xffff;
> +		tx_param.src_dst_cidx = 0;
> +		tx_param.ccnt = 1;
> +		edma_write_slot(davinci_dma->dma_tx_channel, &tx_param);
> +		edma_link(davinci_dma->dma_tx_channel,
> +			  davinci_dma->dummy_param_slot);
> +
> +		rx_param.opt = TCINTEN | EDMA_TCC(davinci_dma->dma_rx_channel);
> +		rx_param.src = rx_reg;
> +		rx_param.a_b_cnt = davinci_spi->rcount << 16 | data_type;
> +		rx_param.dst = t->rx_dma;
> +		rx_param.src_dst_bidx = (t->rx_buf ? data_type : 0) << 16;
> +		rx_param.link_bcntrld = 0xffff;
> +		rx_param.src_dst_cidx = 0;
> +		rx_param.ccnt = 1;
> +		edma_write_slot(davinci_dma->dma_rx_channel, &rx_param);
> +
> +		iowrite16(spidat1 >> SPIDAT1_CSNR_SHIFT,
> +				davinci_spi->base + SPIDAT1 + 2);
> +
> +		edma_start(davinci_dma->dma_rx_channel);
> +		edma_start(davinci_dma->dma_tx_channel);
> +		set_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
>  	}
>  
> -	edma_set_transfer_params(davinci_spi_dma->dma_tx_channel,
> -					data_type, temp_count, 1, 0, ASYNC);
> -	edma_set_dest(davinci_spi_dma->dma_tx_channel, tx_reg, INCR, W8BIT);
> -	edma_set_src(davinci_spi_dma->dma_tx_channel, t->tx_dma, INCR, W8BIT);
> -	edma_set_src_index(davinci_spi_dma->dma_tx_channel, data_type, 0);
> -	edma_set_dest_index(davinci_spi_dma->dma_tx_channel, 0, 0);
> -
> -	if (t->rx_buf) {
> -		/* initiate transaction */
> -		iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
> -
> -		t->rx_dma = dma_map_single(&spi->dev, (void *)t->rx_buf, count,
> -				DMA_FROM_DEVICE);
> -		if (dma_mapping_error(&spi->dev, t->rx_dma)) {
> -			dev_dbg(sdev, "Couldn't DMA map a %d bytes RX buffer\n",
> -					count);
> -			if (t->tx_buf != NULL)
> -				dma_unmap_single(NULL, t->tx_dma,
> -						 count, DMA_TO_DEVICE);
> -			return -ENOMEM;
> +	/* Wait for the transfer to complete */
> +	if (spi_cfg->io_type != SPI_IO_TYPE_POLL) {
> +		wait_for_completion_interruptible(&(davinci_spi->done));
> +	} else {
> +		while ((davinci_spi->rcount > 0) && (ret == 0)) {
> +			ret = davinci_spi_process_events(davinci_spi);
> +			cpu_relax();
>  		}
> -		edma_set_transfer_params(davinci_spi_dma->dma_rx_channel,
> -				data_type, count, 1, 0, ASYNC);
> -		edma_set_src(davinci_spi_dma->dma_rx_channel,
> -				rx_reg, INCR, W8BIT);
> -		edma_set_dest(davinci_spi_dma->dma_rx_channel,
> -				t->rx_dma, INCR, W8BIT);
> -		edma_set_src_index(davinci_spi_dma->dma_rx_channel, 0, 0);
> -		edma_set_dest_index(davinci_spi_dma->dma_rx_channel,
> -				data_type, 0);
>  	}
>  
> -	if ((t->tx_buf) || (t->rx_buf))
> -		edma_start(davinci_spi_dma->dma_tx_channel);
> -
> -	if (t->rx_buf)
> -		edma_start(davinci_spi_dma->dma_rx_channel);
> -
> -	if ((t->rx_buf) || (t->tx_buf))
> -		davinci_spi_set_dma_req(spi, 1);
> -
> -	if (t->tx_buf)
> -		wait_for_completion_interruptible(
> -				&davinci_spi_dma->dma_tx_completion);
> -
> -	if (t->rx_buf)
> -		wait_for_completion_interruptible(
> -				&davinci_spi_dma->dma_rx_completion);
> -
> -	dma_unmap_single(NULL, t->tx_dma, temp_count, DMA_TO_DEVICE);
> -
> -	if (t->rx_buf)
> -		dma_unmap_single(NULL, t->rx_dma, count, DMA_FROM_DEVICE);
> -
> -	/*
> -	 * Check for bit error, desync error,parity error,timeout error and
> -	 * receive overflow errors
> -	 */
> -	int_status = ioread32(davinci_spi->base + SPIFLG);
> +	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
> +	if (spi_cfg->io_type == SPI_IO_TYPE_DMA) {
> +		dma_unmap_single(NULL, t->tx_dma, tx_buf_count,
> +					DMA_TO_DEVICE);
> +		dma_unmap_single(NULL, t->rx_dma, rx_buf_count,
> +					DMA_FROM_DEVICE);
> +	}
>  
> -	ret = davinci_spi_check_error(davinci_spi, int_status);
> -	if (ret != 0)
> -		return ret;
> +	clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
> +	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
>  
> -	/* SPI Framework maintains the count only in bytes so convert back */
> -	davinci_spi->count *= conv;
> +	if (davinci_spi->errors) {
> +		ret = davinci_spi_check_error(davinci_spi, davinci_spi->errors);
> +		if (ret != 0)
> +			return ret;
> +	}
> +	if ((davinci_spi->rcount != 0) || (davinci_spi->wcount != 0)) {
> +		sdev = davinci_spi->bitbang.master->dev.parent;
> +		dev_info(sdev, "SPI data transfer error\n");
> +		return -EIO;
> +	}
>  
>  	return t->len;
>  }
>  
> -/**
> - * davinci_spi_irq - IRQ handler for DaVinci SPI
> +/*
> + * davinci_spi_irq - probe function for SPI Master Controller
>   * @irq: IRQ number for this SPI Master
>   * @context_data: structure for SPI Master controller davinci_spi
> + *
> + * ISR will determine that interrupt arrives either for READ or WRITE command.
> + * According to command it will do the appropriate action. It will check
> + * transfer length and if it is not zero then dispatch transfer command again.
> + * If transfer length is zero then it will indicate the COMPLETION so that
> + * davinci_spi_bufs function can go ahead.
>   */
>  static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
>  {
>  	struct davinci_spi *davinci_spi = context_data;
> -	u32 int_status, rx_data = 0;
> -	irqreturn_t ret = IRQ_NONE;
> +	int status;
>  
> -	int_status = ioread32(davinci_spi->base + SPIFLG);
> +	status = davinci_spi_process_events(davinci_spi);
> +	if (unlikely(status != 0))
> +		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKINT);
>  
> -	while ((int_status & SPIFLG_RX_INTR_MASK)) {
> -		if (likely(int_status & SPIFLG_RX_INTR_MASK)) {
> -			ret = IRQ_HANDLED;
> +	if ((davinci_spi->rcount == 0) || (status != 0))
> +		complete(&(davinci_spi->done));
>  
> -			rx_data = ioread32(davinci_spi->base + SPIBUF);
> -			davinci_spi->get_rx(rx_data, davinci_spi);
> +	return IRQ_HANDLED;
> +}
>  
> -			/* Disable Receive Interrupt */
> -			iowrite32(~(SPIINT_RX_INTR | SPIINT_TX_INTR),
> -					davinci_spi->base + SPIINT);
> -		} else
> -			(void)davinci_spi_check_error(davinci_spi, int_status);
> +resource_size_t davinci_spi_get_dma_by_index(struct platform_device *dev,
> +		unsigned long index)
> +{
> +	struct resource *r;
>  
> -		int_status = ioread32(davinci_spi->base + SPIFLG);
> -	}
> +	r = platform_get_resource(dev, IORESOURCE_DMA, index);
> +	if (r != NULL)
> +		return r->start;
>  
> -	return ret;
> +	return SPI_NO_RESOURCE;
>  }
>  
> -/**
> +/*
>   * davinci_spi_probe - probe function for SPI Master Controller
>   * @pdev: platform_device structure which contains plateform specific data
> + *
> + * According to Linux Device Model this function will be invoked by Linux
> + * with platform_device struct which contains the device specific info.
> + * This function will map the SPI controller's memory, register IRQ,
> + * Reset SPI controller and setting its registers to default value.
> + * It will invoke spi_bitbang_start to create work queue so that client driver
> + * can register transfer method to work queue.
>   */
>  static int davinci_spi_probe(struct platform_device *pdev)
>  {
> @@ -1020,6 +887,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
>  	resource_size_t	dma_tx_chan = SPI_NO_RESOURCE;
>  	resource_size_t	dma_eventq = SPI_NO_RESOURCE;
>  	int i = 0, ret = 0;
> +	u32 spipc0;
>  
>  	pdata = pdev->dev.platform_data;
>  	if (pdata == NULL) {
> @@ -1071,16 +939,18 @@ static int davinci_spi_probe(struct platform_device *pdev)
>  		goto unmap_io;
>  	}
>  
> -	ret = request_irq(davinci_spi->irq, davinci_spi_irq, IRQF_DISABLED,
> +	ret = request_irq(davinci_spi->irq, davinci_spi_irq, 0,
>  			  dev_name(&pdev->dev), davinci_spi);
> -	if (ret)
> +	if (ret != 0) {
> +		ret = -EAGAIN;
>  		goto unmap_io;
> +	}
>  
>  	/* Allocate tmp_buf for tx_buf */
>  	davinci_spi->tmp_buf = kzalloc(SPI_BUFSIZ, GFP_KERNEL);
>  	if (davinci_spi->tmp_buf == NULL) {
>  		ret = -ENOMEM;
> -		goto irq_free;
> +		goto err1;
>  	}
>  
>  	davinci_spi->bitbang.master = spi_master_get(master);
> @@ -1104,55 +974,23 @@ static int davinci_spi_probe(struct platform_device *pdev)
>  
>  	davinci_spi->bitbang.chipselect = davinci_spi_chipselect;
>  	davinci_spi->bitbang.setup_transfer = davinci_spi_setup_transfer;
> +	davinci_spi->bitbang.txrx_bufs = davinci_spi_txrx_bufs;
>  
>  	davinci_spi->version = pdata->version;
> -	use_dma = pdata->use_dma;
>  
>  	davinci_spi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
>  	if (davinci_spi->version == SPI_VERSION_2)
>  		davinci_spi->bitbang.flags |= SPI_READY;
>  
> -	if (use_dma) {
> -			r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -			if (r)
> -				dma_rx_chan = r->start;
> -			r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> -			if (r)
> -				dma_tx_chan = r->start;
> -			r = platform_get_resource(pdev, IORESOURCE_DMA, 2);
> -			if (r)
> -				dma_eventq = r->start;
> -	}
> -
> -	if (!use_dma ||
> -	    dma_rx_chan == SPI_NO_RESOURCE ||
> -	    dma_tx_chan == SPI_NO_RESOURCE ||
> -	    dma_eventq	== SPI_NO_RESOURCE) {
> -		davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs_pio;
> -		use_dma = 0;
> -	} else {
> -		davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs_dma;
> -		davinci_spi->dma_channels = kzalloc(master->num_chipselect
> -				* sizeof(struct davinci_spi_dma), GFP_KERNEL);
> -		if (davinci_spi->dma_channels == NULL) {
> -			ret = -ENOMEM;
> -			goto free_clk;
> -		}
> -
> -		for (i = 0; i < master->num_chipselect; i++) {
> -			davinci_spi->dma_channels[i].dma_rx_channel = -1;
> -			davinci_spi->dma_channels[i].dma_rx_sync_dev =
> -				dma_rx_chan;
> -			davinci_spi->dma_channels[i].dma_tx_channel = -1;
> -			davinci_spi->dma_channels[i].dma_tx_sync_dev =
> -				dma_tx_chan;
> -			davinci_spi->dma_channels[i].eventq = dma_eventq;
> -		}
> -		dev_info(&pdev->dev, "DaVinci SPI driver in EDMA mode\n"
> -				"Using RX channel = %d , TX channel = %d and "
> -				"event queue = %d", dma_rx_chan, dma_tx_chan,
> -				dma_eventq);
> -	}
> +	dma_rx_chan = davinci_spi_get_dma_by_index(pdev, RX_DMA_INDEX);
> +	dma_tx_chan = davinci_spi_get_dma_by_index(pdev, TX_DMA_INDEX);
> +	dma_eventq  = davinci_spi_get_dma_by_index(pdev, EVENTQ_DMA_INDEX);
> +	davinci_spi->dma_channels.dma_rx_channel = -1;
> +	davinci_spi->dma_channels.dma_rx_sync_dev = dma_rx_chan;
> +	davinci_spi->dma_channels.dma_tx_channel = -1;
> +	davinci_spi->dma_channels.dma_tx_sync_dev = dma_tx_chan;
> +	davinci_spi->dma_channels.dummy_param_slot = -1;
> +	davinci_spi->dma_channels.eventq = dma_eventq;
>  
>  	davinci_spi->get_rx = davinci_spi_rx_buf_u8;
>  	davinci_spi->get_tx = davinci_spi_tx_buf_u8;
> @@ -1164,32 +1002,29 @@ static int davinci_spi_probe(struct platform_device *pdev)
>  	udelay(100);
>  	iowrite32(1, davinci_spi->base + SPIGCR0);
>  
> -	/* Clock internal */
> -	if (davinci_spi->pdata->clk_internal)
> -		set_io_bits(davinci_spi->base + SPIGCR1,
> -				SPIGCR1_CLKMOD_MASK);
> -	else
> -		clear_io_bits(davinci_spi->base + SPIGCR1,
> -				SPIGCR1_CLKMOD_MASK);
> +	/* Set up SPIPC0.  CS and ENA init is done in davinci_spi_setup */
> +	spipc0 = SPIPC0_DIFUN_MASK | SPIPC0_DOFUN_MASK | SPIPC0_CLKFUN_MASK;
> +	iowrite32(spipc0, davinci_spi->base + SPIPC0);
>  
> -	/* master mode default */
> -	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MASK);
> +	/* initialize chip selects */
> +	if (pdata->chip_sel != NULL) {
> +		for (i = 0; i < pdata->num_chipselect; i++) {
> +			if (pdata->chip_sel[i] != SPI_INTERN_CS)
> +				gpio_direction_output(pdata->chip_sel[i], 1);
> +		}
> +	}
> +	iowrite32(SPIDEF_CSDEF_MASK, davinci_spi->base + SPIDEF);
>  
> -	if (davinci_spi->pdata->intr_level)
> -		iowrite32(SPI_INTLVL_1, davinci_spi->base + SPILVL);
> -	else
> -		iowrite32(SPI_INTLVL_0, davinci_spi->base + SPILVL);
> +	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_CLKMOD_MASK);
> +	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MASK);
> +	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
>  
>  	ret = spi_bitbang_start(&davinci_spi->bitbang);
> -	if (ret)
> +	if (ret != 0)
>  		goto free_clk;
>  
>  	dev_info(&pdev->dev, "Controller at 0x%p \n", davinci_spi->base);
>  
> -	if (!pdata->poll_mode)
> -		dev_info(&pdev->dev, "Operating in interrupt mode"
> -			" using IRQ %d\n", davinci_spi->irq);
> -
>  	return ret;
>  
>  free_clk:
> @@ -1199,7 +1034,7 @@ put_master:
>  	spi_master_put(master);
>  free_tmp_buf:
>  	kfree(davinci_spi->tmp_buf);
> -irq_free:
> +err1:

why change this?

>  	free_irq(davinci_spi->irq, davinci_spi);
>  unmap_io:
>  	iounmap(davinci_spi->base);
> @@ -1211,7 +1046,7 @@ err:
>  	return ret;
>  }
>  
> -/**
> +/*
>   * davinci_spi_remove - remove function for SPI Master Controller
>   * @pdev: platform_device structure which contains plateform specific data
>   *
> @@ -1220,7 +1055,7 @@ err:
>   * It will also call spi_bitbang_stop to destroy the work queue which was
>   * created by spi_bitbang_start.
>   */
> -static int __exit davinci_spi_remove(struct platform_device *pdev)
> +static int __devexit davinci_spi_remove(struct platform_device *pdev)
>  {
>  	struct davinci_spi *davinci_spi;
>  	struct spi_master *master;
> @@ -1242,8 +1077,11 @@ static int __exit davinci_spi_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver davinci_spi_driver = {
> -	.driver.name = "spi_davinci",
> -	.remove = __exit_p(davinci_spi_remove),
> +	.driver = {
> +		.name = "spi_davinci",
> +		.owner = THIS_MODULE,
> +	},
> +	.remove = __devexit_p(davinci_spi_remove),
>  };
>  
>  static int __init davinci_spi_init(void)
> -- 
> 1.6.3.3
> 

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
