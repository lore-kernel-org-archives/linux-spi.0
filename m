From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Wed, 21 Nov 2012 17:38:29 +0530
Message-ID: <CAM=Q2cvoEMScnCmfrhoAueZ8bfPCX90TxZmsSigfeRbGeXbzMA@mail.gmail.com>
References: <1353464203.20353.6.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1353464203.20353.6.camel@bichao>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 21, 2012 at 7:46 AM, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

>
> This patch is to implement SSP SPI controller driver, which has been
> applied and
> validated on intel Moorestown & Medfield platform. The patch are
> originated by
> Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> and Sylvain Centelles <
> sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
> and to be further developed by Channing <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> and Chen Jun
> <jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> according to their integration & validation on
> Medfield platform.
>
> Signed-off-by: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Sylvain Centelles <sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: channing <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Chen Jun <jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/Kconfig                   |    9 +
>  drivers/spi/Makefile                  |    1 +
>  drivers/spi/spi-intel-mid-ssp.c       | 1407
> +++++++++++++++++++++++++++++++++
>  include/linux/spi/spi-intel-mid-ssp.h |  326 ++++++++
>  4 files changed, 1743 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi-intel-mid-ssp.c
>  create mode 100644 include/linux/spi/spi-intel-mid-ssp.h
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 1acae35..8b4461b 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -179,6 +179,15 @@ config SPI_IMX
>           This enables using the Freescale i.MX SPI controllers in master
>           mode.
>
> +config SPI_INTEL_MID_SSP
> +       tristate "SSP SPI controller driver for Intel MID platforms"
> +       depends on SPI_MASTER && INTEL_MID_DMAC
> +       help
> +         This is the unified SSP SPI master controller driver for
> +         the Intel MID platforms, handling Moorestown & Medfield,
> +         master clock mode.
> +         It supports Bulverde SSP core.
> +
>  config SPI_LM70_LLP
>         tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
>         depends on PARPORT && EXPERIMENTAL
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index c48df47..83f06d0 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_SPI_FSL_ESPI)            += spi-fsl-espi.o
>  obj-$(CONFIG_SPI_FSL_SPI)              += spi-fsl-spi.o
>  obj-$(CONFIG_SPI_GPIO)                 += spi-gpio.o
>  obj-$(CONFIG_SPI_IMX)                  += spi-imx.o
> +obj-$(CONFIG_SPI_INTEL_MID_SSP)                += spi-intel-mid-ssp.o
>  obj-$(CONFIG_SPI_LM70_LLP)             += spi-lm70llp.o
>  obj-$(CONFIG_SPI_MPC512x_PSC)          += spi-mpc512x-psc.o
>  obj-$(CONFIG_SPI_MPC52xx_PSC)          += spi-mpc52xx-psc.o
> diff --git a/drivers/spi/spi-intel-mid-ssp.c
> b/drivers/spi/spi-intel-mid-ssp.c
> new file mode 100644
> index 0000000..8fca48f
> --- /dev/null
> +++ b/drivers/spi/spi-intel-mid-ssp.c
> @@ -0,0 +1,1407 @@
> +/*
> + * spi-intel-mid-ssp.c
> + * This driver supports Bulverde SSP core used on Intel MID platforms
> + * It supports SSP of Moorestown & Medfield platforms and handles clock
> + * slave & master modes.
> + *
> + * Copyright (c) 2010, Intel Corporation.
> + *  Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> + *  Sylvain Centelles <sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +
> +/*
> + * Note:
> + *
> + * Supports DMA and non-interrupt polled transfers.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/highmem.h>
> +#include <linux/pci.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/intel_mid_dma.h>
> +#include <linux/pm_qos.h>
> +#include <linux/module.h>
> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-intel-mid-ssp.h>
> +
> +#define DRIVER_NAME "intel_mid_ssp_spi_unified"
> +
> +MODULE_AUTHOR("Ken Mills");
> +MODULE_DESCRIPTION("Bulverde SSP core SPI contoller");
> +MODULE_LICENSE("GPL");
> +
> +static const struct pci_device_id pci_ids[];
> +
> +#ifdef DUMP_RX
> +static void dump_trailer(const struct device *dev, char *buf, int len,
> int sz)
> +{
> +       int tlen1 = (len < sz ? len : sz);
> +       int tlen2 =  ((len - sz) > sz) ? sz : (len - sz);
> +       unsigned char *p;
> +       static char msg[MAX_SPI_TRANSFER_SIZE];
> +
> +       memset(msg, '\0', sizeof(msg));
> +       p = buf;
> +       while (p < buf + tlen1)
> +               sprintf(msg, "%s%02x", msg, (unsigned int)*p++);
> +
> +       if (tlen2 > 0) {
> +               sprintf(msg, "%s .....", msg);
> +               p = (buf+len) - tlen2;
> +               while (p < buf + len)
> +                       sprintf(msg, "%s%02x", msg, (unsigned int)*p++);
> +       }
> +
> +       dev_info(dev, "DUMP: %p[0:%d ... %d:%d]:%s", buf, tlen1 - 1,
> +                  len-tlen2, len - 1, msg);
> +}
> +#endif
> +
> +static inline u32 is_tx_fifo_empty(struct ssp_driver_context *drv_context)
> +{
> +       u32 sssr;
> +       sssr = read_SSSR(drv_context->ioaddr);
> +       if ((sssr & SSSR_TFL_MASK) || (sssr & SSSR_TNF) == 0)
> +               return 0;
> +       else
> +               return 1;
> +}
> +
> +static inline u32 is_rx_fifo_empty(struct ssp_driver_context *drv_context)
> +{
> +       return ((read_SSSR(drv_context->ioaddr) & SSSR_RNE) == 0);
> +}
> +
> +static inline void disable_interface(struct ssp_driver_context
> *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
> +}
> +
> +static inline void disable_triggers(struct ssp_driver_context
> *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       write_SSCR1(read_SSCR1(reg) & ~drv_context->cr1_sig, reg);
> +}
> +
> +
> +static void flush(struct ssp_driver_context *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       u32 i = 0;
> +
> +       /* If the transmit fifo is not empty, reset the interface. */
> +       if (!is_tx_fifo_empty(drv_context)) {
> +               dev_err(&drv_context->pdev->dev,
> +                               "TX FIFO not empty. Reset of SPI IF");
> +               disable_interface(drv_context);
> +               return;
> +       }
> +
> +       dev_dbg(&drv_context->pdev->dev, " SSSR=%x\r\n", read_SSSR(reg));
> +       while (!is_rx_fifo_empty(drv_context) && (i < SPI_FIFO_SIZE + 1)) {
> +               read_SSDR(reg);
> +               i++;
> +       }
> +       WARN(i > 0, "%d words flush occured\n", i);
> +
> +       return;
> +}
> +
> +static int null_writer(struct ssp_driver_context *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       u8 n_bytes = drv_context->n_bytes;
> +
> +       if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
> +               || (drv_context->tx == drv_context->tx_end))
> +               return 0;
> +
> +       write_SSDR(0, reg);
> +       drv_context->tx += n_bytes;
> +
> +       return 1;
> +}
> +
> +static int null_reader(struct ssp_driver_context *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       u8 n_bytes = drv_context->n_bytes;
> +
> +       while ((read_SSSR(reg) & SSSR_RNE)
> +               && (drv_context->rx < drv_context->rx_end)) {
> +               read_SSDR(reg);
> +               drv_context->rx += n_bytes;
> +       }
> +
> +       return drv_context->rx == drv_context->rx_end;
> +}
> +
> +static int u8_writer(struct ssp_driver_context *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
> +               || (drv_context->tx == drv_context->tx_end))
> +               return 0;
> +
> +       write_SSDR(*(u8 *)(drv_context->tx), reg);
> +       ++drv_context->tx;
> +
> +       return 1;
> +}
> +
> +static int u8_reader(struct ssp_driver_context *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       while ((read_SSSR(reg) & SSSR_RNE)
> +               && (drv_context->rx < drv_context->rx_end)) {
> +               *(u8 *)(drv_context->rx) = read_SSDR(reg);
> +               ++drv_context->rx;
> +       }
> +
> +       return drv_context->rx == drv_context->rx_end;
> +}
> +
> +static int u16_writer(struct ssp_driver_context *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
> +               || (drv_context->tx == drv_context->tx_end))
> +               return 0;
> +
> +       write_SSDR(*(u16 *)(drv_context->tx), reg);
> +       drv_context->tx += 2;
> +
> +       return 1;
> +}
> +
> +static int u16_reader(struct ssp_driver_context *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       while ((read_SSSR(reg) & SSSR_RNE)
> +               && (drv_context->rx < drv_context->rx_end)) {
> +               *(u16 *)(drv_context->rx) = read_SSDR(reg);
> +               drv_context->rx += 2;
> +       }
> +
> +       return drv_context->rx == drv_context->rx_end;
> +}
> +
> +static int u32_writer(struct ssp_driver_context *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
> +               || (drv_context->tx == drv_context->tx_end))
> +               return 0;
> +
> +       write_SSDR(*(u32 *)(drv_context->tx), reg);
> +       drv_context->tx += 4;
> +
> +       return 1;
> +}
> +
> +static int u32_reader(struct ssp_driver_context *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       while ((read_SSSR(reg) & SSSR_RNE)
> +               && (drv_context->rx < drv_context->rx_end)) {
> +               *(u32 *)(drv_context->rx) = read_SSDR(reg);
> +               drv_context->rx += 4;
> +       }
> +
> +       return drv_context->rx == drv_context->rx_end;
> +}
> +
> +static bool chan_filter(struct dma_chan *chan, void *param)
> +{
> +       struct ssp_driver_context *drv_context =
> +               (struct ssp_driver_context *)param;
> +       bool ret = false;
> +
> +       if (!drv_context->dmac1)
> +               return ret;
> +
> +       if (chan->device->dev == &drv_context->dmac1->dev)
> +               ret = true;
> +
> +       return ret;
> +}
> +
> +/**
> + * unmap_dma_buffers() - Unmap the DMA buffers used during the last
> transfer.
> + * @drv_context:       Pointer to the private driver context
> + */
> +static void unmap_dma_buffers(struct ssp_driver_context *drv_context)
> +{
> +       struct device *dev = &drv_context->pdev->dev;
> +
> +       if (!drv_context->dma_mapped)
> +               return;
> +       dma_unmap_single(dev, drv_context->rx_dma, drv_context->len,
> +               PCI_DMA_FROMDEVICE);
> +       dma_unmap_single(dev, drv_context->tx_dma, drv_context->len,
> +               PCI_DMA_TODEVICE);
> +       drv_context->dma_mapped = 0;
> +}
> +
> +/**
> + * intel_mid_ssp_spi_dma_done() - End of DMA transfer callback
> + * @arg:       Pointer to the data provided at callback registration
> + *
> + * This function is set as callback for both RX and TX DMA transfers. The
> + * RX or TX 'done' flag is set acording to the direction of the ended
> + * transfer. Then, if both RX and TX flags are set, it means that the
> + * transfer job is completed.
> + */
> +static void intel_mid_ssp_spi_dma_done(void *arg)
> +{
> +       struct callback_param *cb_param = (struct callback_param *)arg;
> +       struct ssp_driver_context *drv_context = cb_param->drv_context;
> +       struct device *dev = &drv_context->pdev->dev;
> +       void *reg = drv_context->ioaddr;
> +
> +       if (cb_param->direction == TX_DIRECTION)
> +               drv_context->txdma_done = 1;
> +       else
> +               drv_context->rxdma_done = 1;
> +
> +       dev_dbg(dev, "DMA callback for direction %d [RX done:%d] [TX
> done:%d]\n",
> +               cb_param->direction, drv_context->rxdma_done,
> +               drv_context->txdma_done);
> +
> +       if (drv_context->txdma_done && drv_context->rxdma_done) {
> +               /* Clear Status Register */
> +               write_SSSR(drv_context->clear_sr, reg);
> +               dev_dbg(dev, "DMA done\n");
> +               /* Disable Triggers to DMA or to CPU*/
> +               disable_triggers(drv_context);
> +               unmap_dma_buffers(drv_context);
> +
> +               queue_work(drv_context->dma_wq,
> &drv_context->complete_work);
> +       }
> +}
> +
> +/**
> + * intel_mid_ssp_spi_dma_init() - Initialize DMA
> + * @drv_context:       Pointer to the private driver context
> + *
> + * This function is called at driver setup phase to allocate DMA
> + * ressources.
> + */
> +static void intel_mid_ssp_spi_dma_init(struct ssp_driver_context
> *drv_context)
> +{
> +       struct intel_mid_dma_slave *rxs, *txs;
> +       struct dma_slave_config *ds;
> +       dma_cap_mask_t mask;
> +       struct device *dev = &drv_context->pdev->dev;
> +       unsigned int device_id;
> +
> +       /* Configure RX channel parameters */
> +       rxs = &drv_context->dmas_rx;
> +       ds = &rxs->dma_slave;
> +
> +       ds->direction = DMA_FROM_DEVICE;
> +       rxs->hs_mode = LNW_DMA_HW_HS;
> +       rxs->cfg_mode = LNW_DMA_PER_TO_MEM;
> +       ds->dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +       ds->src_addr_width = drv_context->n_bytes;
> +
> +       /* Use a DMA burst according to the FIFO thresholds */
> +       if (drv_context->rx_fifo_threshold == 8) {
> +               ds->src_maxburst = 8;
> +               ds->dst_maxburst = 8;
> +       } else if (drv_context->rx_fifo_threshold == 4) {
> +               ds->src_maxburst = 4;
> +               ds->dst_maxburst = 4;
> +       } else {
> +               ds->src_maxburst = 1;
> +               ds->dst_maxburst = 1;
> +       }
> +
> +       /* Configure TX channel parameters */
> +       txs = &drv_context->dmas_tx;
> +       ds = &txs->dma_slave;
> +
> +       ds->direction = DMA_TO_DEVICE;
> +       txs->hs_mode = LNW_DMA_HW_HS;
> +       txs->cfg_mode = LNW_DMA_MEM_TO_PER;
> +       ds->src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +       ds->dst_addr_width = drv_context->n_bytes;
> +
> +       /* Use a DMA burst according to the FIFO thresholds */
> +       if (drv_context->rx_fifo_threshold == 8) {
> +               ds->src_maxburst = 8;
> +               ds->dst_maxburst = 8;
> +       } else if (drv_context->rx_fifo_threshold == 4) {
> +               ds->src_maxburst = 4;
> +               ds->dst_maxburst = 4;
> +       } else {
> +               ds->src_maxburst = 1;
> +               ds->dst_maxburst = 1;
> +       }
> +
> +       /* Nothing more to do if already initialized */
> +       if (drv_context->dma_initialized)
> +               return;
> +
> +       /* Use DMAC1 */
> +       if (drv_context->quirks & QUIRKS_PLATFORM_MRST)
> +               device_id = PCI_MRST_DMAC1_ID;
> +       else
> +               device_id = PCI_MDFL_DMAC1_ID;
> +
> +       drv_context->dmac1 = pci_get_device(PCI_VENDOR_ID_INTEL,
> +                                                       device_id, NULL);
> +
> +       if (!drv_context->dmac1) {
> +               dev_err(dev, "Can't find DMAC1");
> +               return;
> +       }
> +
> +       if (drv_context->quirks & QUIRKS_SRAM_ADDITIONAL_CPY) {
> +               drv_context->virt_addr_sram_rx =
> ioremap_nocache(SRAM_BASE_ADDR,
> +                               2 * MAX_SPI_TRANSFER_SIZE);
> +               if (drv_context->virt_addr_sram_rx)
> +                       drv_context->virt_addr_sram_tx =
> +                               drv_context->virt_addr_sram_rx +
> +                               MAX_SPI_TRANSFER_SIZE;
> +               else
> +                       dev_err(dev, "Virt_addr_sram_rx is null\n");
> +       }
> +
> +       /* 1. Allocate rx channel */
> +       dma_cap_zero(mask);
> +       dma_cap_set(DMA_MEMCPY, mask);
> +       dma_cap_set(DMA_SLAVE, mask);
> +
> +       drv_context->rxchan = dma_request_channel(mask, chan_filter,
> +               drv_context);
> +       if (!drv_context->rxchan)
> +               goto err_exit;
> +
> +       drv_context->rxchan->private = rxs;
> +
> +       /* 2. Allocate tx channel */
> +       dma_cap_set(DMA_SLAVE, mask);
> +       dma_cap_set(DMA_MEMCPY, mask);
> +
> +       drv_context->txchan = dma_request_channel(mask, chan_filter,
> +               drv_context);
> +
> +       if (!drv_context->txchan)
> +               goto free_rxchan;
> +       else
> +               drv_context->txchan->private = txs;
> +
> +       /* set the dma done bit to 1 */
> +       drv_context->txdma_done = 1;
> +       drv_context->rxdma_done = 1;
> +
> +       drv_context->tx_param.drv_context  = drv_context;
> +       drv_context->tx_param.direction = TX_DIRECTION;
> +       drv_context->rx_param.drv_context  = drv_context;
> +       drv_context->rx_param.direction = RX_DIRECTION;
> +
> +       drv_context->dma_initialized = 1;
> +
> +       return;
> +
> +free_rxchan:
> +       dma_release_channel(drv_context->rxchan);
> +err_exit:
> +       dev_err(dev, "Error : DMA Channel Not available\n");
> +
> +       if (drv_context->quirks & QUIRKS_SRAM_ADDITIONAL_CPY)
> +               iounmap(drv_context->virt_addr_sram_rx);
> +
> +       pci_dev_put(drv_context->dmac1);
> +       return;
> +}
> +
> +/**
> + * intel_mid_ssp_spi_dma_exit() - Release DMA ressources
> + * @drv_context:       Pointer to the private driver context
> + */
> +static void intel_mid_ssp_spi_dma_exit(struct ssp_driver_context
> *drv_context)
> +{
> +       dma_release_channel(drv_context->txchan);
> +       dma_release_channel(drv_context->rxchan);
> +
> +       if (drv_context->quirks & QUIRKS_SRAM_ADDITIONAL_CPY)
> +               iounmap(drv_context->virt_addr_sram_rx);
> +
> +       pci_dev_put(drv_context->dmac1);
> +}
> +
> +/**
> + * dma_transfer() - Initiate a DMA transfer
> + * @drv_context:       Pointer to the private driver context
> + */
> +static void dma_transfer(struct ssp_driver_context *drv_context)
> +{
> +       dma_addr_t ssdr_addr;
> +       struct dma_async_tx_descriptor *txdesc = NULL, *rxdesc = NULL;
> +       struct dma_chan *txchan, *rxchan;
> +       enum dma_ctrl_flags flag;
> +       struct device *dev = &drv_context->pdev->dev;
> +
> +       /* get Data Read/Write address */
> +       ssdr_addr = (dma_addr_t)(drv_context->paddr + 0x10);
> +
> +       if (drv_context->tx_dma)
> +               drv_context->txdma_done = 0;
> +
> +       if (drv_context->rx_dma)
> +               drv_context->rxdma_done = 0;
> +
> +       /* 2. prepare the RX dma transfer */
> +       txchan = drv_context->txchan;
> +       rxchan = drv_context->rxchan;
> +
> +       flag = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
> +
> +       if (likely(drv_context->quirks & QUIRKS_DMA_USE_NO_TRAIL)) {
> +               /* Since the DMA is configured to do 32bits access */
> +               /* to/from the DDR, the DMA transfer size must be  */
> +               /* a multiple of 4 bytes                           */
> +               drv_context->len_dma_rx = drv_context->len & ~(4 - 1);
> +               drv_context->len_dma_tx = drv_context->len_dma_rx;
> +
> +               /* In Rx direction, TRAIL Bytes are handled by memcpy */
> +               if (drv_context->rx_dma &&
> +                       (drv_context->len_dma_rx >
> +                       drv_context->rx_fifo_threshold *
> drv_context->n_bytes))
> +                       drv_context->len_dma_rx =
> +                                       TRUNCATE(drv_context->len_dma_rx,
> +                                       drv_context->rx_fifo_threshold *
> +                                       drv_context->n_bytes);
> +               else if (!drv_context->rx_dma)
> +                       dev_err(dev, "ERROR : rx_dma is null\r\n");
> +       } else {
> +               /* TRAIL Bytes are handled by DMA */
> +               if (drv_context->rx_dma) {
> +                       drv_context->len_dma_rx = drv_context->len;
> +                       drv_context->len_dma_tx = drv_context->len;
> +               } else {
> +                       dev_err(dev, "ERROR : drv_context->rx_dma is
> null!\n");
> +               }
> +       }
> +
> +       rxdesc = rxchan->device->device_prep_dma_memcpy
> +               (rxchan,                                /* DMA Channel */
> +               drv_context->rx_dma,                    /* DAR */
> +               ssdr_addr,                              /* SAR */
> +               drv_context->len_dma_rx,                /* Data Length */
> +               flag);                                  /* Flag */
> +
> +       if (rxdesc) {
> +               rxdesc->callback = intel_mid_ssp_spi_dma_done;
> +               rxdesc->callback_param = &drv_context->rx_param;
> +       } else {
> +               dev_dbg(dev, "rxdesc is null! (len_dma_rx:%zd)\n",
> +                       drv_context->len_dma_rx);
> +               drv_context->rxdma_done = 1;
> +       }
> +
> +       /* 3. prepare the TX dma transfer */
> +       if (drv_context->tx_dma) {
> +               txdesc = txchan->device->device_prep_dma_memcpy
> +               (txchan,                                /* DMA Channel */
> +               ssdr_addr,                              /* DAR */
> +               drv_context->tx_dma,                    /* SAR */
> +               drv_context->len_dma_tx,                /* Data Length */
> +               flag);                                  /* Flag */
> +               if (txdesc) {
> +                       txdesc->callback = intel_mid_ssp_spi_dma_done;
> +                       txdesc->callback_param = &drv_context->tx_param;
> +               } else {
> +                       dev_dbg(dev, "txdesc is null! (len_dma_tx:%zd)\n",
> +                               drv_context->len_dma_tx);
> +                       drv_context->txdma_done = 1;
> +               }
> +       } else {
> +               dev_err(dev, "ERROR : drv_context->tx_dma is null!\n");
> +               return;
> +       }
> +
> +       dev_info(dev, "DMA transfer len:%zd len_dma_tx:%zd
> len_dma_rx:%zd\n",
> +               drv_context->len, drv_context->len_dma_tx,
> +               drv_context->len_dma_rx);
> +
> +       if (rxdesc || txdesc) {
> +               if (rxdesc) {
> +                       dev_dbg(dev, "Firing DMA RX channel\n");
> +                       rxdesc->tx_submit(rxdesc);
> +               }
> +               if (txdesc) {
> +                       dev_dbg(dev, "Firing DMA TX channel\n");
> +                       txdesc->tx_submit(txdesc);
> +               }
> +       } else {
> +               struct callback_param cb_param;
> +               cb_param.drv_context = drv_context;
> +               dev_dbg(dev, "Bypassing DMA transfer\n");
> +               intel_mid_ssp_spi_dma_done(&cb_param);
> +       }
> +}
> +
> +/**
> + * map_dma_buffers() - Map DMA buffer before a transfer
> + * @drv_context:       Pointer to the private drivzer context
> + */
> +static int map_dma_buffers(struct ssp_driver_context *drv_context)
> +{
> +       struct device *dev = &drv_context->pdev->dev;
> +
> +       if (unlikely(drv_context->dma_mapped)) {
> +               dev_err(dev, "ERROR : DMA buffers already mapped\n");
> +               return 0;
> +       }
> +       if (unlikely(drv_context->quirks & QUIRKS_SRAM_ADDITIONAL_CPY)) {
> +               /* Copy drv_context->tx into sram_tx */
> +               memcpy_toio(drv_context->virt_addr_sram_tx,
> drv_context->tx,
> +                       drv_context->len);
> +#ifdef DUMP_RX
> +               dump_trailer(&drv_context->pdev->dev, drv_context->tx,
> +                       drv_context->len, 16);
> +#endif
> +               drv_context->rx_dma = SRAM_RX_ADDR;
> +               drv_context->tx_dma = SRAM_TX_ADDR;
> +       } else {
> +               /* no QUIRKS_SRAM_ADDITIONAL_CPY */
> +               if (unlikely(drv_context->dma_mapped))
> +                       return 1;
> +
> +               drv_context->tx_dma =
> +                       dma_map_single(dev, drv_context->tx,
> drv_context->len,
> +                               PCI_DMA_TODEVICE);
> +               if (unlikely(dma_mapping_error(dev, drv_context->tx_dma)))
> {
> +                       dev_err(dev, "ERROR : tx dma mapping failed\n");
> +                       return 0;
> +               }
> +
> +               drv_context->rx_dma =
> +                       dma_map_single(dev, drv_context->rx,
> drv_context->len,
> +                               PCI_DMA_FROMDEVICE);
> +               if (unlikely(dma_mapping_error(dev, drv_context->rx_dma)))
> {
> +                       dma_unmap_single(dev, drv_context->tx_dma,
> +                               drv_context->len, DMA_TO_DEVICE);
> +                       dev_err(dev, "ERROR : rx dma mapping failed\n");
> +                       return 0;
> +               }
> +       }
> +       return 1;
> +}
> +
> +/**
> + * drain_trail() - Handle trailing bytes of a transfer
> + * @drv_context:       Pointer to the private driver context
> + *
> + * This function handles the trailing bytes of a transfer for the case
> + * they are not handled by the DMA.
> + */
> +void drain_trail(struct ssp_driver_context *drv_context)
> +{
> +       struct device *dev = &drv_context->pdev->dev;
> +       void *reg = drv_context->ioaddr;
> +
> +       if (drv_context->len != drv_context->len_dma_rx) {
> +               dev_dbg(dev, "Handling trailing bytes. SSSR:%08x\n",
> +                       read_SSSR(reg));
> +               drv_context->rx += drv_context->len_dma_rx;
> +               drv_context->tx += drv_context->len_dma_tx;
> +
> +               while ((drv_context->tx != drv_context->tx_end) ||
> +                       (drv_context->rx != drv_context->rx_end)) {
> +                       drv_context->read(drv_context);
> +                       drv_context->write(drv_context);
> +               }
> +       }
> +}
> +
> +/**
> + * sram_to_ddr_cpy() - Copy data from Langwell SDRAM to DDR
> + * @drv_context:       Pointer to the private driver context
> + */
> +static void sram_to_ddr_cpy(struct ssp_driver_context *drv_context)
> +{
> +       u32 length = drv_context->len;
> +
> +       if ((drv_context->quirks & QUIRKS_DMA_USE_NO_TRAIL)
> +               && (drv_context->len > drv_context->rx_fifo_threshold *
> +               drv_context->n_bytes))
> +               length = TRUNCATE(drv_context->len,
> +                       drv_context->rx_fifo_threshold *
> drv_context->n_bytes);
> +
> +       memcpy_fromio(drv_context->rx, drv_context->virt_addr_sram_rx,
> length);
> +}
> +
> +static void int_transfer_complete(struct ssp_driver_context *drv_context)
> +{
> +       void *reg = drv_context->ioaddr;
> +       struct spi_message *msg;
> +       struct device *dev = &drv_context->pdev->dev;
> +
> +       if (unlikely(drv_context->quirks & QUIRKS_USE_PM_QOS))
> +               pm_qos_update_request(&drv_context->pm_qos_req,
> +                                       PM_QOS_DEFAULT_VALUE);
> +
> +       if (unlikely(drv_context->quirks & QUIRKS_SRAM_ADDITIONAL_CPY))
> +               sram_to_ddr_cpy(drv_context);
> +
> +       if (likely(drv_context->quirks & QUIRKS_DMA_USE_NO_TRAIL))
> +               drain_trail(drv_context);
> +       else
> +               /* Stop getting Time Outs */
> +               write_SSTO(0, reg);
> +
> +       drv_context->cur_msg->status = 0;
> +       drv_context->cur_msg->actual_length = drv_context->len;
> +
> +#ifdef DUMP_RX
> +       dump_trailer(dev, drv_context->rx, drv_context->len, 16);
> +#endif
> +
> +       dev_dbg(dev, "End of transfer. SSSR:%08X\n", read_SSSR(reg));
> +       msg = drv_context->cur_msg;
> +       if (likely(msg->complete))
> +               msg->complete(msg->context);
> +}
> +
> +static void int_transfer_complete_work(struct work_struct *work)
> +{
> +       struct ssp_driver_context *drv_context = container_of(work,
> +                               struct ssp_driver_context, complete_work);
> +
> +       int_transfer_complete(drv_context);
> +}
> +
> +static void poll_transfer_complete(struct ssp_driver_context *drv_context)
> +{
> +       struct spi_message *msg;
> +
> +       /* Update total byte transfered return count actual bytes read */
> +       drv_context->cur_msg->actual_length +=
> +               drv_context->len - (drv_context->rx_end - drv_context->rx);
> +
> +       drv_context->cur_msg->status = 0;
> +
> +       msg = drv_context->cur_msg;
> +       if (likely(msg->complete))
> +               msg->complete(msg->context);
> +}
> +
> +/**
> + * ssp_int() - Interrupt handler
> + * @irq
> + * @dev_id
> + *
> + * The SSP interrupt is not used for transfer which are handled by
> + * DMA or polling: only under/over run are catched to detect
> + * broken transfers.
> + */
> +static irqreturn_t ssp_int(int irq, void *dev_id)
> +{
> +       struct ssp_driver_context *drv_context = dev_id;
> +       void *reg = drv_context->ioaddr;
> +       struct device *dev = &drv_context->pdev->dev;
> +       u32 status = read_SSSR(reg);
> +
> +       /* It should never be our interrupt since SSP will */
> +       /* only trigs interrupt for under/over run.        */
> +       if (likely(!(status & drv_context->mask_sr)))
> +               return IRQ_NONE;
> +
> +       if (status & SSSR_ROR || status & SSSR_TUR) {
> +               dev_err(dev, "--- SPI ROR or TUR occurred : SSSR=%x\n",
> status);
> +               WARN_ON(1);
> +               if (status & SSSR_ROR)
> +                       dev_err(dev, "we have Overrun\n");
> +               if (status & SSSR_TUR)
> +                       dev_err(dev, "we have Underrun\n");
> +       }
> +
> +       /* We can fall here when not using DMA mode */
> +       if (!drv_context->cur_msg) {
> +               disable_interface(drv_context);
> +               disable_triggers(drv_context);
> +       }
> +       /* clear status register */
> +       write_SSSR(drv_context->clear_sr, reg);
> +       return IRQ_HANDLED;
> +}
> +
> +static void poll_transfer(unsigned long data)
> +{
> +       struct ssp_driver_context *drv_context =
> +               (struct ssp_driver_context *)data;
> +
> +       if (drv_context->tx)
> +               while (drv_context->tx != drv_context->tx_end) {
> +                       drv_context->write(drv_context);
> +                       drv_context->read(drv_context);
> +               }
> +
> +       while (!drv_context->read(drv_context))
> +               cpu_relax();
> +
> +       poll_transfer_complete(drv_context);
> +}
> +
> +/**
> + * start_bitbanging() - Clock synchronization by bit banging
> + * @drv_context:       Pointer to private driver context
> + *
> + * This clock synchronization will be removed as soon as it is
> + * handled by the SCU.
> + */
> +static void start_bitbanging(struct ssp_driver_context *drv_context)
> +{
> +       u32 sssr;
> +       u32 count = 0;
> +       u32 cr0;
> +       void *i2c_reg = drv_context->I2C_ioaddr;
> +       struct device *dev = &drv_context->pdev->dev;
> +       void *reg = drv_context->ioaddr;
> +       struct chip_data *chip =
> spi_get_ctldata(drv_context->cur_msg->spi);
> +       cr0 = chip->cr0;
> +
> +       dev_warn(dev, "In %s : Starting bit banging\n",\
> +               __func__);
> +       if (read_SSSR(reg) & SSP_NOT_SYNC)
> +               dev_warn(dev, "SSP clock desynchronized.\n");
> +       if (!(read_SSCR0(reg) & SSCR0_SSE))
> +               dev_warn(dev, "in SSCR0, SSP disabled.\n");
> +
> +       dev_dbg(dev, "SSP not ready, start CLK sync\n");
> +
> +       write_SSCR0(cr0 & ~SSCR0_SSE, reg);
> +       write_SSPSP(0x02010007, reg);
> +
> +       write_SSTO(chip->timeout, reg);
> +       write_SSCR0(cr0, reg);
> +
> +       /*
> +       *  This routine uses the DFx block to override the SSP inputs
> +       *  and outputs allowing us to bit bang SSPSCLK. On Langwell,
> +       *  we have to generate the clock to clear busy.
> +       */
> +       write_I2CDATA(0x3, i2c_reg);
> +       udelay(I2C_ACCESS_USDELAY);
> +       write_I2CCTRL(0x01070034, i2c_reg);
> +       udelay(I2C_ACCESS_USDELAY);
> +       write_I2CDATA(0x00000099, i2c_reg);
> +       udelay(I2C_ACCESS_USDELAY);
> +       write_I2CCTRL(0x01070038, i2c_reg);
> +       udelay(I2C_ACCESS_USDELAY);
> +       sssr = read_SSSR(reg);
> +
> +       /* Bit bang the clock until CSS clears */
> +       while ((sssr & 0x400000) && (count < MAX_BITBANGING_LOOP)) {
> +               write_I2CDATA(0x2, i2c_reg);
> +               udelay(I2C_ACCESS_USDELAY);
> +               write_I2CCTRL(0x01070034, i2c_reg);
> +               udelay(I2C_ACCESS_USDELAY);
> +               write_I2CDATA(0x3, i2c_reg);
> +               udelay(I2C_ACCESS_USDELAY);
> +               write_I2CCTRL(0x01070034, i2c_reg);
> +               udelay(I2C_ACCESS_USDELAY);
> +               sssr = read_SSSR(reg);
> +               count++;
> +       }
> +       if (count >= MAX_BITBANGING_LOOP)
> +               dev_err(dev,
> +                       "ERROR in %s : infinite loop on bit banging.
> Aborting\n",
> +                       __func__);
> +
> +       dev_dbg(dev, "---Bit bang count=%d\n", count);
> +
> +       write_I2CDATA(0x0, i2c_reg);
> +       udelay(I2C_ACCESS_USDELAY);
> +       write_I2CCTRL(0x01070038, i2c_reg);
> +}
> +
> +static unsigned int ssp_get_clk_div(int speed)
> +{
> +       return max(100000000 / speed, 4) - 1;
> +}
> +
> +/**
> + * transfer() - Start a SPI transfer
> + * @spi:       Pointer to the spi_device struct
> + * @msg:       Pointer to the spi_message struct
> + */
> +static int transfer(struct spi_device *spi, struct spi_message *msg)
> +{
> +       struct ssp_driver_context *drv_context = \
> +       spi_master_get_devdata(spi->master);
> +       struct chip_data *chip = NULL;
> +       struct spi_transfer *transfer = NULL;
> +       void *reg = drv_context->ioaddr;
> +       u32 cr1;
> +       struct device *dev = &drv_context->pdev->dev;
> +       chip = spi_get_ctldata(msg->spi);
> +
> +       msg->actual_length = 0;
> +       msg->status = -EINPROGRESS;
> +       drv_context->cur_msg = msg;
> +
> +       /* We handle only one transfer message since the protocol module
> has to
> +          control the out of band signaling. */
> +       transfer = list_entry(msg->transfers.next,
> +                                       struct spi_transfer,
> +                                       transfer_list);
> +
> +       /* Check transfer length */
> +       if (unlikely((transfer->len > MAX_SPI_TRANSFER_SIZE) ||
> +               (transfer->len == 0))) {
> +               dev_warn(dev, "transfer length null or greater than %d\n",
> +                       MAX_SPI_TRANSFER_SIZE);
> +               dev_warn(dev, "length = %d\n", transfer->len);
> +               msg->status = -EINVAL;
> +
> +               if (msg->complete)
> +                       msg->complete(msg->context);
> +
> +               return 0;
> +       }
> +
> +       /* Flush any remaining data (in case of failed previous transfer)
> */
> +       flush(drv_context);
> +
> +       drv_context->tx  = (void *)transfer->tx_buf;
> +       drv_context->rx  = (void *)transfer->rx_buf;
> +       drv_context->len = transfer->len;
> +       drv_context->write = chip->write;
> +       drv_context->read = chip->read;
> +
> +       if (likely(chip->dma_enabled)) {
> +               drv_context->dma_mapped = map_dma_buffers(drv_context);
> +               if (unlikely(!drv_context->dma_mapped))
> +                       return 0;
> +       } else {
> +               drv_context->write = drv_context->tx ?
> +                       chip->write : null_writer;
> +               drv_context->read  = drv_context->rx ?
> +                       chip->read : null_reader;
> +       }
> +       drv_context->tx_end = drv_context->tx + transfer->len;
> +       drv_context->rx_end = drv_context->rx + transfer->len;
> +
> +       /* Clear status  */
> +       write_SSSR(drv_context->clear_sr, reg);
> +
> +       /* setup the CR1 control register */
> +       cr1 = chip->cr1 | drv_context->cr1_sig;
> +
> +       if (likely(drv_context->quirks & QUIRKS_DMA_USE_NO_TRAIL)) {
> +               /* in case of len smaller than burst size, adjust the RX
>   */
> +               /* threshold. All other cases will use the default
> threshold */
> +               /* value. The RX fifo threshold must be aligned with the
> DMA */
> +               /* RX transfer size, which may be limited to a multiple of
> 4 */
> +               /* bytes due to 32bits DDR access.
>   */
> +               if  (drv_context->len / drv_context->n_bytes <=
> +                       drv_context->rx_fifo_threshold) {
> +                       u32 rx_fifo_threshold;
> +
> +                       rx_fifo_threshold = (drv_context->len & ~(4 - 1)) /
> +                               drv_context->n_bytes;
> +                       cr1 &= ~(SSCR1_RFT);
> +                       cr1 |= SSCR1_RxTresh(rx_fifo_threshold)
> +                                       & SSCR1_RFT;
> +               } else {
> +                       write_SSTO(chip->timeout, reg);
> +               }
> +       }
> +
> +       dev_dbg(dev,
> +               "transfer len:%zd  n_bytes:%d  cr0:%x  cr1:%x",
> +               drv_context->len, drv_context->n_bytes, chip->cr0, cr1);
> +
> +       /* first set CR1 */
> +       write_SSCR1(cr1, reg);
> +
> +       /* Do bitbanging only if SSP not-enabled or not-synchronized */
> +       if (unlikely(((read_SSSR(reg) & SSP_NOT_SYNC) ||
> +               (!(read_SSCR0(reg) & SSCR0_SSE))) &&
> +               (drv_context->quirks & QUIRKS_BIT_BANGING))) {
> +                       start_bitbanging(drv_context);
> +       } else {
> +               /* (re)start the SSP */
> +               write_SSCR0(chip->cr0, reg);
> +       }
> +
> +       if (likely(chip->dma_enabled)) {
> +               if (unlikely(drv_context->quirks & QUIRKS_USE_PM_QOS))
> +                       pm_qos_update_request(&drv_context->pm_qos_req,
> +                               MIN_EXIT_LATENCY);
> +               dma_transfer(drv_context);
> +       } else {
> +               tasklet_schedule(&drv_context->poll_transfer);
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * setup() - Driver setup procedure
> + * @spi:       Pointeur to the spi_device struct
> + */
> +static int setup(struct spi_device *spi)
> +{
> +       struct intel_mid_ssp_spi_chip *chip_info = NULL;
> +       struct chip_data *chip;
> +       struct ssp_driver_context *drv_context =
> +               spi_master_get_devdata(spi->master);
> +       u32 tx_fifo_threshold;
> +       u32 burst_size;
> +       u32 clk_div;
> +
> +       if (!spi->bits_per_word)
> +               spi->bits_per_word = DFLT_BITS_PER_WORD;
> +
> +       if ((spi->bits_per_word < MIN_BITS_PER_WORD
> +               || spi->bits_per_word > MAX_BITS_PER_WORD))
> +               return -EINVAL;
> +
> +       chip = spi_get_ctldata(spi);
> +       if (!chip) {
> +               chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
> +               if (!chip) {
> +                       dev_err(&spi->dev,
> +                       "failed setup: can't allocate chip data\n");
> +                       return -ENOMEM;
> +               }
> +       }
> +       chip->cr0 = SSCR0_Motorola | SSCR0_DataSize(spi->bits_per_word >
> 16 ?
> +               spi->bits_per_word - 16 : spi->bits_per_word)
> +                       | SSCR0_SSE
> +                       | (spi->bits_per_word > 16 ? SSCR0_EDSS : 0);
> +
> +       /* protocol drivers may change the chip settings, so...  */
> +       /* if chip_info exists, use it                           */
> +       chip_info = spi->controller_data;
> +
> +       /* chip_info isn't always needed */
> +       chip->cr1 = 0;
> +       if (chip_info) {
> +               burst_size = chip_info->burst_size;
> +               if (burst_size > IMSS_FIFO_BURST_8)
> +                       burst_size = DFLT_FIFO_BURST_SIZE;
> +
> +               chip->timeout = chip_info->timeout;
> +
> +               if (chip_info->enable_loopback)
> +                       chip->cr1 |= SSCR1_LBM;
>
> Who sets the enable_loopback?


<snip>


> +/* spi_board_info.controller_data for SPI slave devices,
> + * copied to spi_device.platform_data ... mostly for dma tuning
> + */
> +struct intel_mid_ssp_spi_chip {
> +       enum intel_mid_ssp_spi_fifo_burst burst_size;
> +       u32 timeout;
> +       u8 enable_loopback;
> +       u8 dma_enabled;
> +};
> +
> +
> +#define SPI_DIB_NAME_LEN  16
> +#define SPI_DIB_SPEC_INFO_LEN      10
> +
> +struct spi_dib_header {
> +       u32       signature;
> +       u32       length;
> +       u8         rev;
> +       u8         checksum;
> +       u8         dib[0];
> +} __packed;
> +
> +#endif /*INTEL_MID_SSP_SPI_H_*/
> --
> 1.7.1
>
>
>
>
>
> ------------------------------------------------------------------------------
> Monitor your physical, virtual and cloud infrastructure from a single
> web console. Get in-depth insight into apps, servers, databases, vmware,
> SAP, cloud infrastructure, etc. Download 30-day Free Trial.
> Pricing starts from $795 for 25 servers or applications!
> http://p.sf.net/sfu/zoho_dev2dev_nov
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>
------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
