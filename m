From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH RESEND] intel_mid_ssp_spi: Moorestown and Medfield SPI
	for SSP devices
Date: Thu, 9 Feb 2012 07:31:21 -0800
Message-ID: <20120209153121.GC11249@ponder.secretlab.ca>
References: <20120208104059.23036.78003.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120208104059.23036.78003.stgit-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 08, 2012 at 10:41:10AM +0000, Alan Cox wrote:
> From: Mathieu SOULARD <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> This driver is a fusion of various internal drivers into a single
> driver for the SPI slave/master on the Intel Moorestown and Medfield
> SSP devices.
> 
> Signed-off-by: Mathieu SOULARD <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> [Queueing and runtime pm added]
> Signed-off-by: Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> [Ported to the -next tree DMA engine]
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> 
>  drivers/spi/Kconfig             |    8 
>  drivers/spi/Makefile            |    2 
>  drivers/spi/spi-intel-mid-ssp.c | 1426 +++++++++++++++++++++++++++++++++++++++
>  drivers/spi/spi-intel-mid-ssp.h |  308 ++++++++

If this is merging several of the drivers, what is the plan for the existing
SPI_DESIGNWARE and SPI_TOPCLIFF_PCH drivers?  Or are those for different
devices?

...
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 61c3261..e81757a 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -58,4 +58,4 @@ obj-$(CONFIG_SPI_TLE62X0)		+= spi-tle62x0.o
>  obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
>  obj-$(CONFIG_SPI_TXX9)			+= spi-txx9.o
>  obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
> -
> +obj-$(CONFIG_SPI_INTEL_MID_SSP)		+= spi-intel-mid-ssp.o

I'm trying to keep this list alphabetized.

...
> +#ifdef DUMP_RX
> +static void dump_trailer(const struct device *dev, char *buf, int len, int sz)
> +{
> +	int tlen1 = (len < sz ? len : sz);
> +	int tlen2 =  ((len - sz) > sz) ? sz : (len - sz);
> +	unsigned char *p;
> +	static char msg[MAX_SPI_TRANSFER_SIZE];
> +
> +	memset(msg, '\0', sizeof(msg));
> +	p = buf;
> +	while (p < buf + tlen1)
> +		sprintf(msg, "%s%02x", msg, (unsigned int)*p++);
> +
> +	if (tlen2 > 0) {
> +		sprintf(msg, "%s .....", msg);
> +		p = (buf+len) - tlen2;
> +		while (p < buf + len)
> +			sprintf(msg, "%s%02x", msg, (unsigned int)*p++);
> +	}
> +
> +	dev_info(dev, "DUMP: %p[0:%d ... %d:%d]:%s", buf, tlen1 - 1,
> +		   len-tlen2, len - 1, msg);
> +}
> +#endif

Yet another hex dump debug utility function?  What about lib/hexdump.c?

...
> diff --git a/drivers/spi/spi-intel-mid-ssp.h b/drivers/spi/spi-intel-mid-ssp.h
> new file mode 100644
> index 0000000..11fad57
> --- /dev/null
> +++ b/drivers/spi/spi-intel-mid-ssp.h

How much of this stuff is actually needed in a .h file?  If it is only used
by the .c file, then I want it moved there.

> @@ -0,0 +1,308 @@
> +/*
> + *  Copyright (C) Intel 2009
> + *  Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> + *  Sylvain Centelles <sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + */
> +#ifndef SPI_INTEL_MID_SSP_H_
> +#define SPI_INTEL_MID_SSP_H_
> +
> +#define PCI_MRST_DMAC1_ID	0x0814
> +#define PCI_MDFL_DMAC1_ID	0x0827
> +
> +#define SSP_NOT_SYNC 0x400000
> +#define MAX_SPI_TRANSFER_SIZE 8192
> +#define MAX_BITBANGING_LOOP   10000
> +#define SPI_FIFO_SIZE 16
> +
> +/* PM QoS define */
> +#define MIN_EXIT_LATENCY 20
> +
> +/* SSP assignement configuration from PCI config */
> +#define SSP_CFG_GET_MODE(ssp_cfg)	((ssp_cfg) & 0x07)
> +#define SSP_CFG_GET_SPI_BUS_NB(ssp_cfg)	(((ssp_cfg) >> 3) & 0x07)
> +#define SSP_CFG_IS_SPI_SLAVE(ssp_cfg)	((ssp_cfg) & 0x40)
> +#define SSP_CFG_SPI_MODE_ID		1
> +/* adid field offset is 6 inside the vendor specific capability */
> +#define VNDR_CAPABILITY_ADID_OFFSET	6
> +
> +/* Driver's quirk flags */
> +/* This workarround bufferizes data in the audio fabric SDRAM from  */
> +/* where the DMA transfers will operate. Should be enabled only for */
> +/* SPI slave mode.                                                  */
> +#define QUIRKS_DMA_USE_NO_TRAIL		2
> +/* If set, the driver will use PM_QOS to reduce the latency         */
> +/* introduced by the deeper C-states which may produce over/under   */
> +/* run issues. Must be used in slave mode. In master mode, the      */
> +/* latency is not critical, but setting this workarround  may       */
> +/* improve the SPI throughput.                                      */
> +#define QUIRKS_USE_PM_QOS		4
> +/* This quirks is set on Medfield                                   */
> +#define QUIRKS_PLATFORM_MDFL		16
> +/* If set, SPI is in slave clock mode                               */
> +#define QUIRKS_SPI_SLAVE_CLOCK_MODE	64
> +
> +/* Uncomment to get RX and TX short dumps after each transfer */
> +/* #define DUMP_RX 1 */
> +#define MAX_TRAILING_BYTE_RETRY 16
> +#define MAX_TRAILING_BYTE_LOOP 100
> +#define DELAY_TO_GET_A_WORD 3
> +#define DFLT_TIMEOUT_VAL 500
> +
> +#define DEFINE_SSP_REG(reg, off) \
> +static inline u32 read_##reg(void *p) { return __raw_readl(p + (off)); } \
> +static inline void write_##reg(u32 v, void *p) { __raw_writel(v, p + (off)); }
> +
> +#define RX_DIRECTION 0
> +#define TX_DIRECTION 1
> +
> +#define I2C_ACCESS_USDELAY 10
> +
> +#define DFLT_BITS_PER_WORD 16
> +#define MIN_BITS_PER_WORD     4
> +#define MAX_BITS_PER_WORD     32
> +#define DFLT_FIFO_BURST_SIZE	IMSS_FIFO_BURST_8
> +
> +#define TRUNCATE(x, a) ((x) & ~((a)-1))
> +
> +DEFINE_SSP_REG(SSCR0, 0x00)
> +DEFINE_SSP_REG(SSCR1, 0x04)
> +DEFINE_SSP_REG(SSSR, 0x08)
> +DEFINE_SSP_REG(SSITR, 0x0c)
> +DEFINE_SSP_REG(SSDR, 0x10)
> +DEFINE_SSP_REG(SSTO, 0x28)
> +DEFINE_SSP_REG(SSPSP, 0x2c)
> +
> +DEFINE_SSP_REG(I2CCTRL, 0x00);
> +DEFINE_SSP_REG(I2CDATA, 0x04);
> +
> +DEFINE_SSP_REG(GPLR1, 0x04);
> +DEFINE_SSP_REG(GPDR1, 0x0c);
> +DEFINE_SSP_REG(GPSR1, 0x14);
> +DEFINE_SSP_REG(GPCR1, 0x1C);
> +DEFINE_SSP_REG(GAFR1_U, 0x44);
> +
> +#define SYSCFG  0x20bc0
> +
> +#define SRAM_BASE_ADDR 0xfffdc000
> +#define SRAM_RX_ADDR   SRAM_BASE_ADDR
> +#define SRAM_TX_ADDR  (SRAM_BASE_ADDR + MAX_SPI_TRANSFER_SIZE)
> +
> +#define SSCR0_DSS   (0x0000000f)     /* Data Size Select (mask) */
> +#define SSCR0_DataSize(x)  ((x) - 1)    /* Data Size Select [4..16] */
> +#define SSCR0_FRF   (0x00000030)     /* FRame Format (mask) */
> +#define SSCR0_Motorola        (0x0 << 4)         /* Motorola's SPI mode */
> +#define SSCR0_ECS   (1 << 6) /* External clock select */
> +#define SSCR0_SSE   (1 << 7) /* Synchronous Serial Port Enable */
> +
> +#define SSCR0_SCR   (0x000fff00)      /* Serial Clock Rate (mask) */
> +#define SSCR0_SerClkDiv(x) (((x) - 1) << 8) /* Divisor [1..4096] */
> +#define SSCR0_EDSS  (1 << 20)           /* Extended data size select */
> +#define SSCR0_NCS   (1 << 21)           /* Network clock select */
> +#define SSCR0_RIM    (1 << 22)           /* Receive FIFO overrrun int mask */
> +#define SSCR0_TUM   (1 << 23)           /* Transmit FIFO underrun int mask */
> +#define SSCR0_FRDC (0x07000000)     /* Frame rate divider control (mask) */
> +#define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24) /* Time slots per frame */
> +#define SSCR0_ADC   (1 << 30)           /* Audio clock select */
> +#define SSCR0_MOD  (1 << 31)           /* Mode (normal or network) */
> +
> +#define SSCR1_RIE    (1 << 0) /* Receive FIFO Interrupt Enable */
> +#define SSCR1_TIE     (1 << 1) /* Transmit FIFO Interrupt Enable */
> +#define SSCR1_LBM   (1 << 2) /* Loop-Back Mode */
> +#define SSCR1_SPO   (1 << 3) /* SSPSCLK polarity setting */
> +#define SSCR1_SPH   (1 << 4) /* Motorola SPI SSPSCLK phase setting */
> +#define SSCR1_MWDS           (1 << 5) /* Microwire Transmit Data Size */
> +#define SSCR1_TFT    (0x000003c0)     /* Transmit FIFO Threshold (mask) */
> +#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
> +#define SSCR1_RFT    (0x00003c00)     /* Receive FIFO Threshold (mask) */
> +#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
> +
> +#define SSSR_TNF		(1 << 2)	/* Tx FIFO Not Full */
> +#define SSSR_RNE		(1 << 3)	/* Rx FIFO Not Empty */
> +#define SSSR_BSY		(1 << 4)	/* SSP Busy */
> +#define SSSR_TFS		(1 << 5)	/* Tx FIFO Service Request */
> +#define SSSR_RFS		(1 << 6)	/* Rx FIFO Service Request */
> +#define SSSR_ROR		(1 << 7)	/* Rx FIFO Overrun */
> +#define SSSR_TFL_MASK           (0x0F << 8)     /* Tx FIFO level field mask */
> +
> +#define SSCR0_TIM    (1 << 23)          /* Transmit FIFO Under Run Int Mask */
> +#define SSCR0_RIM    (1 << 22)          /* Receive FIFO Over Run int Mask */
> +#define SSCR0_NCS    (1 << 21)          /* Network Clock Select */
> +#define SSCR0_EDSS   (1 << 20)          /* Extended Data Size Select */
> +
> +#define SSCR0_TISSP      (1 << 4)  /* TI Sync Serial Protocol */
> +#define SSCR0_PSP        (3 << 4)  /* PSP - Programmable Serial Protocol */
> +#define SSCR1_TTELP      (1 << 31) /* TXD Tristate Enable Last Phase */
> +#define SSCR1_TTE        (1 << 30) /* TXD Tristate Enable */
> +#define SSCR1_EBCEI      (1 << 29) /* Enable Bit Count Error interrupt */
> +#define SSCR1_SCFR       (1 << 28) /* Slave Clock free Running */
> +#define SSCR1_ECRA       (1 << 27) /* Enable Clock Request A */
> +#define SSCR1_ECRB       (1 << 26) /* Enable Clock request B */
> +#define SSCR1_SCLKDIR    (1 << 25) /* Serial Bit Rate Clock Direction */
> +#define SSCR1_SFRMDIR    (1 << 24) /* Frame Direction */
> +#define SSCR1_RWOT       (1 << 23) /* Receive Without Transmit */
> +#define SSCR1_TRAIL      (1 << 22) /* Trailing Byte */
> +#define SSCR1_TSRE       (1 << 21) /* Transmit Service Request Enable */
> +#define SSCR1_RSRE       (1 << 20) /* Receive Service Request Enable */
> +#define SSCR1_TINTE      (1 << 19) /* Receiver Time-out Interrupt enable */
> +#define SSCR1_PINTE      (1 << 18) /* Trailing Byte Interupt Enable */
> +#define SSCR1_STRF       (1 << 15) /* Select FIFO or EFWR */
> +#define SSCR1_EFWR       (1 << 14) /* Enable FIFO Write/Read */
> +#define SSCR1_IFS        (1 << 16) /* Invert Frame Signal */
> +
> +#define SSSR_BCE         (1 << 23) /* Bit Count Error */
> +#define SSSR_CSS         (1 << 22) /* Clock Synchronisation Status */
> +#define SSSR_TUR         (1 << 21) /* Transmit FIFO Under Run */
> +#define SSSR_EOC         (1 << 20) /* End Of Chain */
> +#define SSSR_TINT        (1 << 19) /* Receiver Time-out Interrupt */
> +#define SSSR_PINT        (1 << 18) /* Peripheral Trailing Byte Interrupt */
> +
> +#define SSPSP_FSRT       (1 << 25)   /* Frame Sync Relative Timing */
> +#define SSPSP_DMYSTOP(x) ((x) << 23) /* Dummy Stop */
> +#define SSPSP_SFRMWDTH(x)((x) << 16) /* Serial Frame Width */
> +#define SSPSP_SFRMDLY(x) ((x) << 9)  /* Serial Frame Delay */
> +#define SSPSP_DMYSTRT(x) ((x) << 7)  /* Dummy Start */
> +#define SSPSP_STRTDLY(x) ((x) << 4)  /* Start Delay */
> +#define SSPSP_ETDS       (1 << 3)    /* End of Transfer data State */
> +#define SSPSP_SFRMP      (1 << 2)    /* Serial Frame Polarity */
> +#define SSPSP_SCMODE(x)  ((x) << 0)  /* Serial Bit Rate Clock Mode */
> +
> +/*
> + * For testing SSCR1 changes that require SSP restart, basically
> + * everything except the service and interrupt enables
> + */
> +
> +#define SSCR1_CHANGE_MASK (SSCR1_TTELP | SSCR1_TTE | SSCR1_SCFR \
> +				| SSCR1_ECRA | SSCR1_ECRB | SSCR1_SCLKDIR \
> +				| SSCR1_SFRMDIR | SSCR1_RWOT | SSCR1_TRAIL \
> +				| SSCR1_IFS | SSCR1_STRF | SSCR1_EFWR \
> +				| SSCR1_RFT | SSCR1_TFT | SSCR1_MWDS \
> +				| SSCR1_SPH | SSCR1_SPO | SSCR1_LBM)
> +
> +struct callback_param {
> +	void *drv_context;
> +	u32 direction;
> +};
> +
> +struct ssp_driver_context {
> +	/* Driver model hookup */
> +	struct pci_dev *pdev;
> +
> +	/* SPI framework hookup */
> +	struct spi_master *master;
> +
> +	/* SSP register addresses */
> +	unsigned long paddr;
> +	void *ioaddr;
> +	int irq;
> +
> +	/* SSP masks*/
> +	u32 cr1_sig;
> +	u32 cr1;
> +	u32 clear_sr;
> +	u32 mask_sr;
> +
> +	struct tasklet_struct poll_transfer;
> +
> +	spinlock_t lock;
> +
> +	/* Current message transfer state info */
> +	struct spi_message *cur_msg;
> +	size_t len;
> +	size_t len_dma_rx;
> +	size_t len_dma_tx;
> +	void *tx;
> +	void *tx_end;
> +	void *rx;
> +	void *rx_end;
> +	bool dma_initialized;
> +	int dma_mapped;
> +	dma_addr_t rx_dma;
> +	dma_addr_t tx_dma;
> +	u8 n_bytes;
> +	int (*write)(struct ssp_driver_context *drv_context);
> +	int (*read)(struct ssp_driver_context *drv_context);
> +
> +	struct intel_mid_dma_slave    dmas_tx;
> +	struct intel_mid_dma_slave    dmas_rx;
> +	struct dma_chan    *txchan;
> +	struct dma_chan    *rxchan;
> +	struct workqueue_struct *dma_wq;
> +	struct work_struct complete_work;
> +
> +	spinlock_t 		queue_lock;
> +	struct list_head	queue;
> +	struct workqueue_struct	*transfer_queue;
> +	struct work_struct	transfer_work;
> +	bool			running;
> +
> +	int txdma_done;
> +	int rxdma_done;
> +	struct callback_param tx_param;
> +	struct callback_param rx_param;
> +	struct pci_dev *dmac1;
> +
> +	unsigned long quirks;
> +	u32 rx_fifo_threshold;
> +};
> +
> +struct chip_data {
> +	u32 cr0;
> +	u32 cr1;
> +	u32 timeout;
> +	u8 n_bytes;
> +	u8 dma_enabled;
> +	u8 bits_per_word;
> +	u32 speed_hz;
> +	int (*write)(struct ssp_driver_context *drv_context);
> +	int (*read)(struct ssp_driver_context *drv_context);
> +};
> +
> +
> +enum intel_mid_ssp_spi_fifo_burst {
> +	IMSS_FIFO_BURST_1,
> +	IMSS_FIFO_BURST_4,
> +	IMSS_FIFO_BURST_8
> +};
> +
> +/* spi_board_info.controller_data for SPI slave devices,
> + * copied to spi_device.platform_data ... mostly for dma tuning
> + */
> +struct intel_mid_ssp_spi_chip {
> +	enum intel_mid_ssp_spi_fifo_burst burst_size;
> +	u32 timeout;
> +	u8 enable_loopback;
> +	u8 dma_enabled;
> +};
> +
> +
> +#define SPI_DIB_NAME_LEN  16
> +#define SPI_DIB_SPEC_INFO_LEN      10
> +
> +struct spi_dib_header {
> +	u32       signature;
> +	u32       length;
> +	u8         rev;
> +	u8         checksum;
> +	u8         dib[0];
> +} __attribute__((packed));
> +
> +#endif /* SPI_INTEL_MID_SSP_H_*/
> 

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
