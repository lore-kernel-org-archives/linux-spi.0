From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] SPI slave driver for Intel's
	Moorestown platform
Date: Wed, 20 Jan 2010 08:28:57 -0700
Message-ID: <fa686aa41001200728k2fbdc41ei41c63e982e37bf9f@mail.gmail.com>
References: <1261528613.17041.3.camel@ubuntu-vmware>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1261528613.17041.3.camel@ubuntu-vmware>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Ken,

Thanks for the patch.  Some comments below.

On Tue, Dec 22, 2009 at 5:36 PM, Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> diff --git a/drivers/spi/mrst_spi_slave.c b/drivers/spi/mrst_spi_slave.c
> new file mode 100644
> index 0000000..7180ece
> --- /dev/null
> +++ b/drivers/spi/mrst_spi_slave.c
> @@ -0,0 +1,1136 @@
> +/*
> + * =A0mrst_spi_slave.c - Moorestown SPI slave controller driver

Drop the file name from the comment.  File names often change.  All you
need here is the statement of what the driver is.

> + * =A0based on pxa2xx_spi.c
> + *
> + * =A0Copyright (C) Intel 2009
> + * =A0Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> + *
> + * =A0This program is free software; you can redistribute it and/or modi=
fy
> + * =A0it under the terms of the GNU General Public License as published =
by
> + * =A0the Free Software Foundation; either version 2 of the License, or
> + * =A0(at your option) any later version.
> + *
> + * =A0This program is distributed in the hope that it will be useful,
> + * =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * =A0GNU General Public License for more details.
> + *
> + * =A0You should have received a copy of the GNU General Public License
> + * =A0along with this program; if not, write to the Free Software
> + * =A0Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A002111-=
1307 =A0USA
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~

Please drop the ~~~~ horizontal rules.  And unless Intel legal insists
on the 3 paragraph license text, I think just the first paragraph is
necessary.  I like to see boilerplate kept to a minimum in files so it
is easy to glean out the essential information at a glance.

> + *
> + */
> +
> +/*
> + * Note:
> + *
> + * Supports interrupt programmed I/O, DMA and non-interrupt polled trans=
fers.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/highmem.h>
> +#include <linux/pci.h>
> +
> +#ifdef CONFIG_SPI_MRST_SLAVE_DMA
> +#include <linux/dma-mapping.h>
> +#include <linux/lnw_dma.h>
> +#endif
> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/mrst_spi_slave.h>
> +
> +
> +#define DRIVER_NAME "mrst_spi_slave"

DRIVER_NAME is used in exactly 1 place.  Please drop this line.

> +
> +#define SSP_NOT_SYNC 0x400000
> +
> +MODULE_AUTHOR("");

Either fill in, or drop this line.

> +MODULE_DESCRIPTION("Moorestown SPI Slave Contoller");
> +MODULE_LICENSE("GPL");
> +
> +/*
> + * For testing SSCR1 changes that require SSP restart, basically
> + * everything except the service and interrupt enables
> + */
> +#define SSCR1_CHANGE_MASK (SSCR1_TTELP | SSCR1_TTE | SSCR1_EBCEI | SSCR1=
_SCFR \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SSCR1_ECR=
A | SSCR1_ECRB | SSCR1_SCLKDIR \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SSCR1_SFR=
MDIR \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SSCR1_RWO=
T | SSCR1_TRAIL | SSCR1_PINTE \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SSCR1_STR=
F | SSCR1_EFWR | SSCR1_RFT \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SSCR1_TFT=
 | SSCR1_SPH | SSCR1_SPO)
> +
> +#define DEFINE_SSP_REG(reg, off) \
> +static inline u32 read_##reg(void *p) { return __raw_readl(p + (off)); }=
 \
> +static inline void write_##reg(u32 v, void *p) { __raw_writel(v, p + (of=
f)); }

Even though they are restricted to the file scope, static globals still
compete with the global namespace.  It is good practise to prefix all
global statics with a driver prefix.  This goes for all declarations;
variables, functions and structures.

Adding a prefix also makes it easier to differentiate between driver local
stuff and common functions when reviewing code.

> +#define START_STATE ((void *)0)
> +#define RUNNING_STATE ((void *)1)
> +#define DONE_STATE ((void *)2)
> +#define ERROR_STATE ((void *)-1)

This looks pretty ugly, and while the state pointer gets set to these
values, it doesn't seem to be actually used anywhere.

> +
> +struct chip_data {
> + =A0 =A0 =A0 u32 cr0;
> + =A0 =A0 =A0 u32 cr1;
> + =A0 =A0 =A0 u32 psp;
> + =A0 =A0 =A0 u32 timeout;
> + =A0 =A0 =A0 u8 n_bytes;
> + =A0 =A0 =A0 u32 threshold;
> + =A0 =A0 =A0 u8 enable_dma;
> + =A0 =A0 =A0 u8 poll_mode; =A0 =A0 /* 1 means use poll mode */
> + =A0 =A0 =A0 u8 bits_per_word;
> + =A0 =A0 =A0 int (*write)(struct driver_data *drv_data);
> + =A0 =A0 =A0 int (*read)(struct driver_data *drv_data);
> +};
> +
> +static void flush(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 u32 sssr;
> +
> + =A0 =A0 =A0 /* If the transmit fifo is not empty, reset the interface. =
*/
> + =A0 =A0 =A0 sssr =3D read_SSSR(reg);
> + =A0 =A0 =A0 if ((sssr & 0xf00) || (sssr & SSSR_TNF) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, r=
eg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 while (read_SSSR(reg) & SSSR_RNE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_SSDR(reg);
> +
> + =A0 =A0 =A0 write_SSSR(SSSR_ROR, reg);
> + =A0 =A0 =A0 write_SSSR(SSSR_TUR, reg);
> +
> + =A0 =A0 =A0 return;
> +}
> +
> +static int null_writer(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 u8 n_bytes =3D drv_data->n_bytes;
> +
> + =A0 =A0 =A0 if (((read_SSSR(reg) & 0x00000f00) =3D=3D 0x00000f00)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 || (drv_data->tx =3D=3D drv_data->tx_end))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 write_SSDR(0, reg);
> + =A0 =A0 =A0 drv_data->tx +=3D n_bytes;
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +static int null_reader(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 u8 n_bytes =3D drv_data->n_bytes;
> +
> + =A0 =A0 =A0 while ((read_SSSR(reg) & SSSR_RNE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (drv_data->rx < drv_data->rx_end)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_SSDR(reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->rx +=3D n_bytes;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return drv_data->rx =3D=3D drv_data->rx_end;
> +}
> +
> +static int u8_writer(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 if (((read_SSSR(reg) & 0x00000f00) =3D=3D 0x00000f00)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 || (drv_data->tx =3D=3D drv_data->tx_end))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 write_SSDR(*(u8 *)(drv_data->tx), reg);
> + =A0 =A0 =A0 ++drv_data->tx;
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +static int u8_reader(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 while ((read_SSSR(reg) & SSSR_RNE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (drv_data->rx < drv_data->rx_end)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(drv_data->rx) =3D read_SSDR(reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++drv_data->rx;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return drv_data->rx =3D=3D drv_data->rx_end;
> +}
> +
> +static int u16_writer(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 if (((read_SSSR(reg) & 0x00000f00) =3D=3D 0x00000f00)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 || (drv_data->tx =3D=3D drv_data->tx_end))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 write_SSDR(*(u16 *)(drv_data->tx), reg);
> + =A0 =A0 =A0 drv_data->tx +=3D 2;
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +static int u16_reader(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 while ((read_SSSR(reg) & SSSR_RNE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (drv_data->rx < drv_data->rx_end)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u16 *)(drv_data->rx) =3D read_SSDR(reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->rx +=3D 2;
> + =A0 =A0 =A0 }
> +
> +return drv_data->rx =3D=3D drv_data->rx_end;
> +}
> +
> +static int u32_writer(struct driver_data *drv_data)
> +{
> +void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 if (((read_SSSR(reg) & 0x00000f00) =3D=3D 0x00000f00)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 || (drv_data->tx =3D=3D drv_data->tx_end))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 write_SSDR(*(u32 *)(drv_data->tx), reg);
> + =A0 =A0 =A0 drv_data->tx +=3D 4;
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +static int u32_reader(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 while ((read_SSSR(reg) & SSSR_RNE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (drv_data->rx < drv_data->rx_end)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u32 *)(drv_data->rx) =3D read_SSDR(reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->rx +=3D 4;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return drv_data->rx =3D=3D drv_data->rx_end;
> +}
> +
> +
> +
> +/* caller already set message->status; dma and pio irqs are blocked */
> +static void giveback(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 struct spi_message *msg;
> +
> + =A0 =A0 =A0 msg =3D drv_data->cur_msg;
> + =A0 =A0 =A0 msg->state =3D NULL;
> + =A0 =A0 =A0 if (msg->complete)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->complete(msg->context);
> +}
> +
> +#ifdef CONFIG_SPI_MRST_SLAVE_DMA
> +
> +static bool chan_filter(struct dma_chan *chan, void *param)
> +{
> + =A0 =A0 =A0 struct driver_data *drv_data =3D (struct driver_data *)para=
m;
> + =A0 =A0 =A0 bool ret =3D false;
> +
> + =A0 =A0 =A0 if (!drv_data->dmac1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 if (chan->device->dev =3D=3D &drv_data->dmac1->dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D true;
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static void int_transfer_complete(struct driver_data *drv_data);
> +static void unmap_dma_buffers(struct driver_data *drv_data);
> +
> +static void mrst_spi_dma_done(void *arg)
> +{
> + =A0 =A0 =A0 u64 *param =3D arg;
> + =A0 =A0 =A0 struct driver_data *drv_data;
> + =A0 =A0 =A0 int *done;
> +
> + =A0 =A0 =A0 drv_data =3D (struct driver_data *)(u32)(*param >> 32);
> + =A0 =A0 =A0 done =3D (int *)(u32)(*param & 0xffffffff);
> + =A0 =A0 =A0 *done =3D 1;
> +
> + =A0 =A0 =A0 unmap_dma_buffers(drv_data);
> +
> + =A0 =A0 =A0 if (!drv_data->txdma_done || !drv_data->rxdma_done)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 int_transfer_complete(drv_data);
> +}
> +
> +static void mrst_spi_dma_init(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 struct lnw_dma_slave *rxs, *txs;
> + =A0 =A0 =A0 dma_cap_mask_t mask;
> +
> + =A0 =A0 =A0 /* Use DMAC1 */
> + =A0 =A0 =A0 drv_data->dmac1 =3D pci_get_device(PCI_VENDOR_ID_INTEL, 0x0=
814, NULL);
> + =A0 =A0 =A0 if (!drv_data->dmac1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "SPI Slave:Can't find D=
MAC1\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> +/* 1. init rx channel */
> + =A0 =A0 =A0 rxs =3D &drv_data->dmas_rx;
> +
> + =A0 =A0 =A0 rxs->dirn =3D DMA_FROM_DEVICE;
> + =A0 =A0 =A0 rxs->hs_mode =3D LNW_DMA_HW_HS;
> + =A0 =A0 =A0 rxs->cfg_mode =3D LNW_DMA_PER_TO_MEM;
> + =A0 =A0 =A0 rxs->src_width =3D LNW_DMA_WIDTH_16BIT;
> + =A0 =A0 =A0 rxs->dst_width =3D LNW_DMA_WIDTH_32BIT;
> + =A0 =A0 =A0 rxs->src_msize =3D LNW_DMA_MSIZE_8;
> + =A0 =A0 =A0 rxs->dst_msize =3D LNW_DMA_MSIZE_8;
> +
> +
> + =A0 =A0 =A0 dma_cap_zero(mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_MEMCPY, mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);
> +
> + =A0 =A0 =A0 drv_data->rxchan =3D dma_request_channel(mask, chan_filter,=
 drv_data);
> + =A0 =A0 =A0 if (!drv_data->rxchan)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_exit;
> +
> + =A0 =A0 =A0 drv_data->rxchan->private =3D rxs;
> +
> + =A0 =A0 =A0 /* 2. init tx channel */
> + =A0 =A0 =A0 txs =3D &drv_data->dmas_tx;
> +
> + =A0 =A0 =A0 txs->dirn =3D DMA_TO_DEVICE;
> + =A0 =A0 =A0 txs->hs_mode =3D LNW_DMA_HW_HS;
> + =A0 =A0 =A0 txs->cfg_mode =3D LNW_DMA_MEM_TO_PER;
> + =A0 =A0 =A0 txs->src_width =3D LNW_DMA_WIDTH_32BIT;
> + =A0 =A0 =A0 txs->dst_width =3D LNW_DMA_WIDTH_16BIT;
> + =A0 =A0 =A0 txs->src_msize =3D LNW_DMA_MSIZE_8;
> + =A0 =A0 =A0 txs->dst_msize =3D LNW_DMA_MSIZE_8;
> +
> +
> + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_MEMCPY, mask);
> +
> + =A0 =A0 =A0 drv_data->txchan =3D dma_request_channel(mask, chan_filter,=
 drv_data);
> + =A0 =A0 =A0 if (!drv_data->txchan)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_rxchan;
> + =A0 =A0 =A0 else
> +
> + =A0 =A0 =A0 drv_data->txchan->private =3D txs;
> +
> + =A0 =A0 =A0 /* set the dma done bit to 1 */
> + =A0 =A0 =A0 drv_data->txdma_done =3D 1;
> + =A0 =A0 =A0 drv_data->rxdma_done =3D 1;
> +
> + =A0 =A0 =A0 drv_data->tx_param =3D ((u64)(u32)drv_data << 32)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (u32)(&drv_data->txdma_done);
> + =A0 =A0 =A0 drv_data->rx_param =3D ((u64)(u32)drv_data << 32)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (u32)(&drv_data->rxdma_done);
> + =A0 =A0 =A0 return;
> +
> +free_rxchan:
> + =A0 =A0 =A0 printk(KERN_ERR "SPI-Slave Error : DMA Channle Not availabl=
e\n");
> + =A0 =A0 =A0 dma_release_channel(drv_data->rxchan);
> +err_exit:
> + =A0 =A0 =A0 printk(KERN_ERR "SPI-Slave Error : DMA Channel Not availabl=
e\n");
> + =A0 =A0 =A0 pci_dev_put(drv_data->dmac1);
> + =A0 =A0 =A0 return;
> +}
> +
> +static void mrst_spi_dma_exit(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 dma_release_channel(drv_data->txchan);
> + =A0 =A0 =A0 dma_release_channel(drv_data->rxchan);
> + =A0 =A0 =A0 pci_dev_put(drv_data->dmac1);
> +}
> +
> +static void dma_transfer(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 dma_addr_t ssdr_addr;
> + =A0 =A0 =A0 struct dma_async_tx_descriptor *txdesc =3D NULL, *rxdesc =
=3D NULL;
> + =A0 =A0 =A0 struct dma_chan *txchan, *rxchan;
> + =A0 =A0 =A0 enum dma_ctrl_flags flag;
> +
> + =A0 =A0 =A0 /* get Data Read/Write address */
> + =A0 =A0 =A0 ssdr_addr =3D (dma_addr_t)(u32)(drv_data->paddr + 0x10);
> +
> + =A0 =A0 =A0 if (drv_data->tx_dma)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->txdma_done =3D 0;
> +
> + =A0 =A0 =A0 if (drv_data->rx_dma)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->rxdma_done =3D 0;
> +
> + =A0 =A0 =A0 /* 2. start the TX dma transfer */
> + =A0 =A0 =A0 txchan =3D drv_data->txchan;
> + =A0 =A0 =A0 rxchan =3D drv_data->rxchan;
> +
> + =A0 =A0 =A0 flag =3D DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
> +
> + =A0 =A0 =A0 if (drv_data->rx_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc =3D rxchan->device->device_prep_dma_=
memcpy
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rxchan, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =
DMA Channel */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->rx_dma, =A0 =A0 =A0 /* DAR */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssdr_addr, =A0 =A0 =A0 =A0 =A0 =A0 =A0/* SA=
R */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->len, =A0 =A0 =A0 =A0 =A0/* Data L=
ength */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* Flag */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc->callback =3D mrst_spi_dma_done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc->callback_param =3D &drv_data->rx_pa=
ram;
> + =A0 =A0 =A0 }
> +
> +/* 3. start the RX dma transfer */
> + =A0 =A0 =A0 if (drv_data->tx_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc =3D txchan->device->device_prep_dma_=
memcpy
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (txchan, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =
DMA Channel */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssdr_addr, =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DA=
R */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->tx_dma, =A0 =A0 =A0 /* SAR */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->len, =A0 =A0 =A0 =A0 =A0/* Data L=
ength */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* Flag */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc->callback =3D mrst_spi_dma_done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc->callback_param =3D &drv_data->tx_pa=
ram;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (rxdesc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc->tx_submit(rxdesc);
> + =A0 =A0 =A0 if (txdesc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc->tx_submit(txdesc);
> +}
> +
> +static int map_dma_buffers(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 struct device *dev =3D &drv_data->pdev->dev;
> +
> + =A0 =A0 =A0 if (drv_data->dma_mapped)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 drv_data->tx_dma =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_map_single(dev, drv_data->tx, drv_data-=
>len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCI_DMA_TODEVICE);
> + =A0 =A0 =A0 if (dma_mapping_error(dev, drv_data->tx_dma))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 drv_data->rx_dma =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_map_single(dev, drv_data->rx, drv_data-=
>len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCI_DMA_FROMDEVICE);
> + =A0 =A0 =A0 if (dma_mapping_error(dev, drv_data->rx_dma)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(dev, drv_data->tx_dma,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->tx_map_len, DMA_T=
O_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +static void unmap_dma_buffers(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 struct device *dev =3D &drv_data->pdev->dev;
> +
> + =A0 =A0 =A0 if (!drv_data->dma_mapped)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 dma_unmap_single(dev, drv_data->rx_dma, drv_data->len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCI_DMA_FROMDEVICE);
> + =A0 =A0 =A0 dma_unmap_single(dev, drv_data->tx_dma, drv_data->len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCI_DMA_TODEVICE);
> + =A0 =A0 =A0 drv_data->dma_mapped =3D 0;
> +}
> +
> +#endif
> +
> +static void int_error_stop(struct driver_data *drv_data, const char* msg)
> +{
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> +
> + =A0 =A0 =A0 /* Stop and reset SSP */
> + =A0 =A0 =A0 write_SSSR(drv_data->clear_sr, reg);
> + =A0 =A0 =A0 write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
> + =A0 =A0 =A0 write_SSTO(0, reg);
> + =A0 =A0 =A0 flush(drv_data);
> +
> + =A0 =A0 =A0 dev_err(&drv_data->pdev->dev, "%s\n", msg);
> +
> + =A0 =A0 =A0 drv_data->cur_msg->state =3D ERROR_STATE;
> +}
> +
> +static void int_transfer_complete(struct driver_data *drv_data)
> +{
> +void *reg =3D drv_data->ioaddr;
> +
> + =A0 =A0 =A0 /* Clear Status Register */
> + =A0 =A0 =A0 write_SSSR(drv_data->clear_sr, reg);
> +
> +#ifdef CONFIG_SPI_MRST_SLAVE_DMA
> + =A0 =A0 =A0 /* Disable Triggers to DMA */
> + =A0 =A0 =A0 write_SSCR1(read_SSCR1(reg) & ~drv_data->dma_cr1, reg);
> +#else
> + =A0 =A0 =A0 /* Disable Interrupt */
> + =A0 =A0 =A0 write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
> +#endif
> + =A0 =A0 =A0 /* Stop getting Time Outs */
> + =A0 =A0 =A0 write_SSTO(0, reg);
> +
> + =A0 =A0 =A0 /* Update total byte transfered return count actual bytes r=
ead */
> + =A0 =A0 =A0 drv_data->cur_msg->actual_length +=3D drv_data->len -
> + =A0 =A0 =A0 (drv_data->rx_end - drv_data->rx);
> +
> + =A0 =A0 =A0 drv_data->cur_msg->status =3D 0;
> + =A0 =A0 =A0 giveback(drv_data);
> +}
> +
> +static void transfer_complete(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 /* Update total byte transfered return count actual bytes r=
ead */
> + =A0 =A0 =A0 drv_data->cur_msg->actual_length +=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->len - (drv_data->rx_end - drv_dat=
a->rx);
> +
> + =A0 =A0 =A0 drv_data->cur_msg->status =3D 0;
> + =A0 =A0 =A0 giveback(drv_data);
> +}
> +
> +static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
> +{
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 u32 irq_mask =3D (read_SSCR1(reg) & SSCR1_TIE) ?
> + =A0 =A0 =A0 drv_data->mask_sr : drv_data->mask_sr & ~SSSR_TFS;
> +
> + =A0 =A0 =A0 u32 irq_status =3D read_SSSR(reg) & irq_mask;
> + =A0 =A0 =A0 if (irq_status & SSSR_ROR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int_error_stop(drv_data, "interrupt_transfe=
r: fifo overrun");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (irq_status & SSSR_TINT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_SSSR(SSSR_TINT, reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv_data->read(drv_data)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int_transfer_complete(drv_d=
ata);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> +/* Drain rx fifo, Fill tx fifo and prevent overruns */

Indentation

> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv_data->read(drv_data)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int_transfer_complete(drv_d=
ata);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } while (drv_data->write(drv_data));
> +
> + =A0 =A0 =A0 if (drv_data->read(drv_data)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int_transfer_complete(drv_data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (drv_data->tx =3D=3D drv_data->tx_end)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_SSCR1(read_SSCR1(reg) & ~SSCR1_TIE, r=
eg);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ssp_int(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct driver_data *drv_data =3D dev_id;
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> +#ifdef CONFIG_SPI_MRST_SLAVE_DMA
> + =A0 =A0 =A0 u32 status =3D read_SSSR(reg);
> +
> + =A0 =A0 =A0 if (status & SSSR_ROR || status & SSSR_TUR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "--- SPI ROR or TUR occur=
red : SSSR=3D%x\n",
> + =A0 =A0 =A0 status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_SSSR(SSSR_ROR, reg); =A0 =A0 =A0 =A0 =
=A0 =A0 =A0/* Clear ROR */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_SSSR(SSSR_TUR, reg); =A0 =A0 =A0 =A0 =
=A0 =A0 =A0/* Clear TUR */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return IRQ_NONE;
> +#endif

I don't see CONFIG_SPI_MRST_SLAVE_DMA defined anywhere.  Please drop these
sections from the driver until that bit is ready.  It can be added in a
follow-on patch.

> + =A0 =A0 =A0 /* just return if this is not our interrupt */
> + =A0 =A0 =A0 if (!(read_SSSR(reg) & drv_data->mask_sr))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
> +
> + =A0 =A0 =A0 if (!drv_data->cur_msg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, r=
eg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_SSCR1(read_SSCR1(reg) & ~drv_data->in=
t_cr1, reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_SSSR(drv_data->clear_sr, reg);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Never fail */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return drv_data->transfer_handler(drv_data);
> +}
> +
> +static void poll_transfer(unsigned long data)
> +{
> + =A0 =A0 =A0 struct driver_data *drv_data =3D (struct driver_data *)data;
> +
> + =A0 =A0 =A0 if (drv_data->tx)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (drv_data->tx !=3D drv_data->tx_end) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->write(drv_data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_data->read(drv_data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 while (!drv_data->read(drv_data))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> +
> + =A0 =A0 =A0 transfer_complete(drv_data);
> +}
> +
> +static int transfer(struct spi_device *spi, struct spi_message *msg)
> +{
> + =A0 =A0 =A0 struct driver_data *drv_data =3D \
> + =A0 =A0 =A0 spi_slave_get_devdata(spi->slave);

Backslashes are unnecessary in normal C code.  :-)

> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 struct chip_data *chip =3D NULL;
> + =A0 =A0 =A0 struct spi_transfer *transfer =3D NULL;
> + =A0 =A0 =A0 void *reg =3D drv_data->ioaddr;
> + =A0 =A0 =A0 void *i2cReg =3D drv_data->I2C_ioaddr;
> + =A0 =A0 =A0 u32 clk_div =3D 0;
> + =A0 =A0 =A0 u8 bits =3D 0;
> + =A0 =A0 =A0 u32 cr0;
> + =A0 =A0 =A0 u32 cr1;
> + =A0 =A0 =A0 u32 sssr;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&drv_data->lock, flags);
> + =A0 =A0 =A0 msg->actual_length =3D 0;
> + =A0 =A0 =A0 msg->status =3D -EINPROGRESS;
> + =A0 =A0 =A0 drv_data->cur_msg =3D msg;
> + =A0 =A0 =A0 /* Initial message state*/
> + =A0 =A0 =A0 msg->state =3D START_STATE;
> +
> + =A0 =A0 =A0 /* We handle only one transfer message since the protocol m=
odule has to
> + =A0 =A0 =A0 =A0 =A0control the out of band signaling. */

Try to keep lines down under 80 chars as much as possible.

> + =A0 =A0 =A0 transfer =3D list_entry(msg->transfers.next,
> + =A0 =A0 =A0 struct spi_transfer,
> + =A0 =A0 =A0 transfer_list);
> +
> + =A0 =A0 =A0 chip =3D spi_get_ctldata(msg->spi);
> +
> + =A0 =A0 =A0 drv_data->busy =3D 1;
> +
> +/* Check transfer length */

indent

> + =A0 =A0 =A0 if (transfer->len > 8192) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&drv_data->pdev->dev, "SPI-SLAVE: =
transfer "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "length greater than 8192\n");

Indent second line so it is obvious that this is a continuation of the
dev_warn parameters.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->status =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 giveback(drv_data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&drv_data->lock, fla=
gs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Setup the transfer state based on the type of transfer */
> + =A0 =A0 =A0 flush(drv_data);
> + =A0 =A0 =A0 drv_data->n_bytes =3D chip->n_bytes;
> + =A0 =A0 =A0 drv_data->tx =3D (void *)transfer->tx_buf;
> + =A0 =A0 =A0 drv_data->tx_end =3D drv_data->tx + transfer->len;
> + =A0 =A0 =A0 drv_data->rx =3D transfer->rx_buf;
> + =A0 =A0 =A0 drv_data->rx_end =3D drv_data->rx + transfer->len;
> + =A0 =A0 =A0 drv_data->rx_dma =3D transfer->rx_dma;
> + =A0 =A0 =A0 drv_data->tx_dma =3D transfer->tx_dma;
> + =A0 =A0 =A0 drv_data->len =3D transfer->len;
> + =A0 =A0 =A0 drv_data->write =3D drv_data->tx ? chip->write : null_write=
r;
> + =A0 =A0 =A0 drv_data->read =3D drv_data->rx ? chip->read : null_reader;
> +
> + =A0 =A0 =A0 /* Change speed and bit per word on a per transfer */
> + =A0 =A0 =A0 cr0 =3D chip->cr0;
> + =A0 =A0 =A0 if (transfer->bits_per_word) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bits =3D chip->bits_per_word;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_div =3D 0x0;
> +
> + =A0 =A0 =A0 if (transfer->bits_per_word)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bits =3D transfer->bits_per_word;

ick.  Must fix this indentation over whole file so a reader can follow
the scope.

> diff --git a/include/linux/spi/mrst_spi_slave.h b/include/linux/spi/mrst_=
spi_slave.h
> new file mode 100644
> index 0000000..70ea3b7
> --- /dev/null
> +++ b/include/linux/spi/mrst_spi_slave.h
> @@ -0,0 +1,134 @@
> +/*

Include a one-line statement on what this file is.

> + * =A0Copyright (C) Intel 2009
> + * =A0Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> + *
> + * =A0This program is free software; you can redistribute it and/or modi=
fy
> + * =A0it under the terms of the GNU General Public License as published =
by
> + * =A0the Free Software Foundation; either version 2 of the License, or
> + * =A0(at your option) any later version.
> + *
> + * =A0This program is distributed in the hope that it will be useful,
> + * =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * =A0GNU General Public License for more details.
> + *
> + * =A0You should have received a copy of the GNU General Public License
> + * =A0along with this program; if not, write to the Free Software
> + * =A0Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A002111-=
1307 =A0USA
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~

Same comment as on .c file.
> + *
> + */
> +#ifndef MRST_SSP_H_
> +#define MRST_SSP_H_
> +
> +
> +/*
> + * Langwell SSP serial port register definitions
> + */
> +
> +#define SSCR0_DSS =A0 =A0 =A0(0x0000000f) =A0 =A0/* Data Size Select (ma=
sk) */
> +#define SSCR0_DataSize(x) ((x) - 1) =A0 =A0/* Data Size Select [4..16] */
> +#define SSCR0_FRF =A0 =A0 =A0(0x00000030) =A0 =A0/* FRame Format (mask) =
*/
> +#define SSCR0_Motorola (0x0 << 4) =A0 =A0 =A0/* Motorola's SPI mode */
> +#define SSCR0_ECS =A0 =A0 =A0(1 << 6) =A0 =A0 =A0 =A0/* External clock s=
elect */
> +#define SSCR0_SSE =A0 =A0 =A0(1 << 7) =A0 =A0 =A0 =A0/* Synchronous Seri=
al Port Enable */
> +
> +
> +#define SSCR0_SCR =A0 =A0 =A0(0x000fff00) =A0 =A0/* Serial Clock Rate (m=
ask) */
> +#define SSCR0_SerClkDiv(x) (((x) - 1) << 8)/* Divisor [1..4096] */
> +#define SSCR0_EDSS =A0 =A0 (1 << 20) =A0 =A0 =A0 /* Extended data size s=
elect */
> +#define SSCR0_NCS =A0 =A0 =A0(1 << 21) =A0 =A0 =A0 /* Network clock sele=
ct */
> +#define SSCR0_RIM =A0 =A0 =A0(1 << 22) =A0 =A0 =A0 /* Receive FIFO overr=
run int mask */
> +#define SSCR0_TUM =A0 =A0 =A0(1 << 23) =A0 =A0 =A0 /* Transmit FIFO unde=
rrun int mask */
> +#define SSCR0_FRDC =A0 =A0 (0x07000000) =A0 =A0/* Frame rate divider con=
trol (mask) */
> +#define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24)/* Time slots per frame */
> +#define SSCR0_ADC =A0 =A0 =A0(1 << 30) =A0 =A0 =A0 /* Audio clock select=
 */
> +#define SSCR0_MOD =A0 =A0 =A0(1 << 31) =A0 =A0 =A0 /* Mode (normal or ne=
twork) */
> +
> +
> +#define SSCR1_RIE =A0 =A0 =A0(1 << 0) =A0 =A0 =A0 =A0/* Receive FIFO Int=
errupt Enable */
> +#define SSCR1_TIE =A0 =A0 =A0(1 << 1) =A0 =A0 =A0 =A0/* Transmit FIFO In=
terrupt Enable */
> +#define SSCR1_LBM =A0 =A0 =A0(1 << 2) =A0 =A0 =A0 =A0/* Loop-Back Mode */
> +#define SSCR1_SPO =A0 =A0 =A0(1 << 3) =A0 =A0 =A0 =A0/* SSPSCLK polarity=
 setting */
> +#define SSCR1_SPH =A0 =A0 =A0(1 << 4) =A0 =A0 =A0 =A0/* Motorola SPI SSP=
SCLK phase setting */
> +#define SSCR1_MWDS =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0/* Microwire Transmit=
 Data Size */
> +#define SSCR1_TFT =A0 =A0 =A0(0x000003c0) =A0 =A0/* Transmit FIFO Thresh=
old (mask) */
> +#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
> +#define SSCR1_RFT =A0 =A0 =A0(0x00003c00) =A0 =A0/* Receive FIFO Thresho=
ld (mask) */
> +#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
> +
> +#define SSSR_TNF =A0 =A0 =A0 (1 << 2) =A0 =A0 =A0 =A0/* Transmit FIFO No=
t Full */
> +#define SSSR_RNE =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0/* Receive FIFO Not=
 Empty */
> +#define SSSR_BSY =A0 =A0 =A0 (1 << 4) =A0 =A0 =A0 =A0/* SSP Busy */
> +#define SSSR_TFS =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0/* Transmit FIFO Se=
rvice Request */
> +#define SSSR_RFS =A0 =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* Receive FIFO Ser=
vice Request */
> +#define SSSR_ROR =A0 =A0 =A0 (1 << 7) =A0 =A0 =A0 =A0/* Receive FIFO Ove=
rrun */
> +
> +#define SSCR0_TIM =A0 =A0 =A0(1 << 23) =A0 =A0 =A0 /* Transmit FIFO Unde=
r Run Int Mask */
> +#define SSCR0_RIM =A0 =A0 =A0(1 << 22) =A0 =A0 =A0 /* Receive FIFO Over =
Run int Mask */
> +#define SSCR0_NCS =A0 =A0 =A0(1 << 21) =A0 =A0 =A0 /* Network Clock Sele=
ct */
> +#define SSCR0_EDSS =A0 =A0 (1 << 20) =A0 =A0 =A0 /* Extended Data Size S=
elect */
> +
> +#define SSCR0_TISSP =A0 =A0(1 << 4) =A0 =A0 =A0 =A0/* TI Sync Serial Pro=
tocol */
> +#define SSCR0_PSP =A0 =A0 =A0(3 << 4) =A0 =A0 =A0 =A0/* PSP - Programmab=
le Serial Protocol */
> +#define SSCR1_TTELP =A0 =A0(1 << 31) =A0 =A0 =A0 /* TXD Tristate Enable =
Last Phase */
> +#define SSCR1_TTE =A0 =A0 =A0(1 << 30) =A0 =A0 =A0 /* TXD Tristate Enabl=
e */
> +#define SSCR1_EBCEI =A0 =A0(1 << 29) =A0 =A0 =A0 /* Enable Bit Count Err=
or interrupt */
> +#define SSCR1_SCFR =A0 =A0 (1 << 28) =A0 =A0 =A0 /* Slave Clock free Run=
ning */
> +#define SSCR1_ECRA =A0 =A0 (1 << 27) =A0 =A0 =A0 /* Enable Clock Request=
 A */
> +#define SSCR1_ECRB =A0 =A0 (1 << 26) =A0 =A0 =A0 /* Enable Clock request=
 B */
> +#define SSCR1_SCLKDIR =A0(1 << 25) =A0 =A0 =A0 /* Serial Bit Rate Clock =
Direction */
> +#define SSCR1_SFRMDIR =A0(1 << 24) =A0 =A0 =A0 /* Frame Direction */
> +#define SSCR1_RWOT =A0 =A0 (1 << 23) =A0 =A0 =A0 /* Receive Without Tran=
smit */
> +#define SSCR1_TRAIL =A0 =A0(1 << 22) =A0 =A0 =A0 /* Trailing Byte */
> +#define SSCR1_TSRE =A0 =A0 (1 << 21) =A0 =A0 =A0 /* Transmit Service Req=
uest Enable */
> +#define SSCR1_RSRE =A0 =A0 (1 << 20) =A0 =A0 =A0 /* Receive Service Requ=
est Enable */
> +#define SSCR1_TINTE =A0 =A0(1 << 19) =A0 =A0 =A0 /* Receiver Time-out In=
terrupt enable */
> +#define SSCR1_PINTE =A0 =A0(1 << 18) =A0 =A0 =A0 /* Trailing Byte Interu=
pt Enable */
> +#define SSCR1_STRF =A0 =A0 (1 << 15) =A0 =A0 =A0 /* Select FIFO or EFWR =
*/
> +#define SSCR1_EFWR =A0 =A0 (1 << 14) =A0 =A0 =A0 /* Enable FIFO Write/Re=
ad */
> +
> +#define SSSR_BCE =A0 =A0 =A0 (1 << 23) =A0 =A0 =A0 /* Bit Count Error */
> +#define SSSR_CSS =A0 =A0 =A0 (1 << 22) =A0 =A0 =A0 /* Clock Synchronisat=
ion Status */
> +#define SSSR_TUR =A0 =A0 =A0 (1 << 21) =A0 =A0 =A0 /* Transmit FIFO Unde=
r Run */
> +#define SSSR_EOC =A0 =A0 =A0 (1 << 20) =A0 =A0 =A0 /* End Of Chain */
> +#define SSSR_TINT =A0 =A0 =A0(1 << 19) =A0 =A0 =A0 /* Receiver Time-out =
Interrupt */
> +#define SSSR_PINT =A0 =A0 =A0(1 << 18) =A0 =A0 =A0 /* Peripheral Trailin=
g Byte Interrupt */
> +
> +#define SSPSP_FSRT =A0 =A0 (1 << 25) =A0 =A0 =A0 /* Frame Sync Relative =
Timing */
> +#define SSPSP_DMYSTOP(x) ((x) << 23) =A0 /* Dummy Stop */
> +#define SSPSP_SFRMWDTH(x) ((x) << 16) =A0/* Serial Frame Width */
> +#define SSPSP_SFRMDLY(x) ((x) << 9) =A0 =A0/* Serial Frame Delay */
> +#define SSPSP_DMYSTRT(x) ((x) << 7) =A0 =A0/* Dummy Start */
> +#define SSPSP_STRTDLY(x) ((x) << 4) =A0 =A0/* Start Delay */
> +#define SSPSP_ETDS(1 << 3) =A0 =A0 =A0 =A0 =A0 =A0 /* End of Transfer da=
ta State */
> +#define SSPSP_SFRMP =A0(1 << 2) =A0 =A0 =A0 =A0 =A0/* Serial Frame Polar=
ity */
> +#define SSPSP_SCMODE(x)((x) << 0) =A0 =A0 =A0/* Serial Bit Rate Clock Mo=
de */

Move these #defines to the .c file.  They aren't part of the interface.

> +
> +/* spi_board_info.controller_data for SPI slave devices,
> + * copied to spi_device.platform_data ... mostly for dma tuning
> + */
> +struct mrst_spi_chip {
> + =A0 =A0 =A0 u8 tx_threshold;
> + =A0 =A0 =A0 u8 rx_threshold;
> + =A0 =A0 =A0 u8 dma_burst_size;
> + =A0 =A0 =A0 u32 timeout;
> + =A0 =A0 =A0 u8 enable_loopback;
> + =A0 =A0 =A0 u16 extra_data[5];
> +};
> +
> +#define SPI_DIB_NAME_LEN =A016
> +#define SPI_DIB_SPEC_INFO_LEN =A010

Not used anywhere

> +struct spi_dib_header {
> + =A0 =A0 =A0 u32signature;
> + =A0 =A0 =A0 u32length;
> + =A0 =A0 =A0 u8 rev;
> + =A0 =A0 =A0 u8 checksum;
> + =A0 =A0 =A0 u8 dib[0];
> +} __attribute__((packed));

spi_dib_header isn't used anywhere.

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
