From: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 2/3] spi: Add spi driver for Socionext Synquacer platform
Date: Thu, 8 Feb 2018 20:42:44 +0000
Message-ID: <CAKv+Gu_Bzs8iW4xiA-N47Q_58QQcmt=VrNK2fe3URoRMcFswTw@mail.gmail.com>
References: <1516358213-4400-1-git-send-email-jassisinghbrar@gmail.com> <1516358251-4523-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1516358251-4523-1-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Jassi,

On 19 January 2018 at 10:37,  <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> This patch adds support for controller found on synquacer platforms.
>
> Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

I added the following nodes to my SynQuacer boards:

    clk_fip006_spi: spi_ihclk {
        compatible = "fixed-clock";
        #clock-cells = <0>;
        clock-frequency = <125000000>;
    };

    spi@54810000 {
        compatible = "socionext,synquacer-spi";
        reg = <0x0 0x54810000 0x0 0x1000>;
        clocks = <&clk_fip006_spi>;
        clock-names = "iHCLK";
        socionext,use-rtm;
        socionext,set-aces;
        #address-cells = <1>;
        #size-cells = <0>;

        tpm@0 {
            reg = <0x0>;
            compatible = "infineon,slb9670";
            spi-max-frequency = <22500000>;
        };
    };

and I end up with the following splat:

[    5.741886] Unable to handle kernel paging request at virtual
address fffffffffffffffe
[    5.741889] Mem abort info:
[    5.741891]   ESR = 0x96000004
[    5.741895]   Exception class = DABT (current EL), IL = 32 bits
[    5.741898]   SET = 0, FnV = 0
[    5.741899]   EA = 0, S1PTW = 0
[    5.741901] Data abort info:
[    5.741903]   ISV = 0, ISS = 0x00000004
[    5.741905]   CM = 0, WnR = 0
[    5.741910] swapper pgtable: 4k pages, 48-bit VAs, pgd = 0000000042134b9d
[    5.741913] [fffffffffffffffe] *pgd=0000000000000000
[    5.741920] Internal error: Oops: 96000004 [#1] SMP
[    5.741924] Modules linked in: efivars(+) gpio_keys(+)
spi_synquacer(+) efivarfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 fscrypto sd_mod ahci xhci_pci libahci xhci_hcd libata
usbcore realtek scsi_mod netsec of_mdio fixed_phy libphy gpio_mb86s7x
[    5.741974] CPU: 18 PID: 389 Comm: systemd-udevd Not tainted 4.15.0+ #1
[    5.741976] Hardware name: Socionext Developer Box (DT)
[    5.741981] pstate: a0000005 (NzCv daif -PAN -UAO)
[    5.741995] pc : clk_prepare+0x1c/0x60
[    5.742007] lr : synquacer_spi_probe+0xe8/0x290 [spi_synquacer]
[    5.742008] sp : ffff00000d5739e0
[    5.742011] x29: ffff00000d5739e0 x28: ffff01911d855000
[    5.742016] x27: ffff3dda0e962000 x26: 0000000000000000
[    5.742021] x25: ffff01911d8542d0 x24: 0000000000000010
[    5.742026] x23: ffffbed27ffed5c8 x22: ffffbed25b7cb400
[    5.742031] x21: fffffffffffffffe x20: ffffbed25658b000
[    5.742036] x19: fffffffffffffffe x18: ffffffffffffffff
[    5.742041] x17: 0000ffff90f5ce58 x16: ffff3dda0e3cb818
[    5.742046] x15: ffff3dda0ee59c08 x14: ffffffffffffffff
[    5.742051] x13: 0000000000000028 x12: 0101010101010101
[    5.742055] x11: 0000000000000038 x10: 0101010101010101
[    5.742060] x9 : 0000000000000002 x8 : 7f7f7f7f7f7f7f7f
[    5.742065] x7 : ff6c73712c647274 x6 : 0000000000000080
[    5.742070] x5 : 0000000000000000 x4 : 8000000000000000
[    5.742075] x3 : 0000000000000000 x2 : 0000000000000000
[    5.742079] x1 : 0000000000000001 x0 : ffff01911d852778
[    5.742086] Process systemd-udevd (pid: 389, stack limit =
0x00000000cdd89d3b)
[    5.742088] Call trace:
[    5.742093]  clk_prepare+0x1c/0x60
[    5.742101]  synquacer_spi_probe+0xe8/0x290 [spi_synquacer]
[    5.742109]  platform_drv_probe+0x60/0xc8
[    5.742114]  driver_probe_device+0x2dc/0x480
[    5.742119]  __driver_attach+0x124/0x128
[    5.742124]  bus_for_each_dev+0x78/0xe0
[    5.742128]  driver_attach+0x30/0x40
[    5.742132]  bus_add_driver+0x1f8/0x2b0
[    5.742136]  driver_register+0x68/0x100
[    5.742141]  __platform_driver_register+0x54/0x60
[    5.742148]  synquacer_spi_driver_init+0x1c/0x1000 [spi_synquacer]
[    5.742154]  do_one_initcall+0x5c/0x168
[    5.742161]  do_init_module+0x64/0x1e0
[    5.742167]  load_module+0x1ed0/0x2198
[    5.742172]  SyS_finit_module+0x128/0x140
[    5.742176]  __sys_trace_return+0x0/0x4
[    5.742183] Code: aa0003f3 aa1e03e0 d503201f b4000193 (f9400273)
[    5.742188] ---[ end trace 831278301b1eda70 ]---


It looks like the call

clk_prepare_enable(sspi->clk[IPCLK]);

is passing the ERR() value of devm_clk_get() rather than NULL. Adding
'if (!IS_ERR())' fixes it for me.


> ---
>  drivers/spi/Kconfig         |  11 +
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-synquacer.c | 661 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 673 insertions(+)
>  create mode 100644 drivers/spi/spi-synquacer.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 6037839..9e04bbe 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -659,6 +659,17 @@ config SPI_SUN6I
>         help
>           This enables using the SPI controller on the Allwinner A31 SoCs.
>
> +config SPI_SYNQUACER
> +       tristate "Socionext's Synquacer HighSpeed SPI controller"
> +       depends on ARCH_SYNQUACER || COMPILE_TEST
> +       select SPI_BITBANG
> +       help
> +         SPI driver for Socionext's High speed SPI controller which provides
> +         various operating modes for interfacing to serial peripheral devices
> +         that use the de-facto standard SPI protocol.
> +
> +         It also supports the new dual-bit and quad-bit SPI protocol.
> +
>  config SPI_MXS
>         tristate "Freescale MXS SPI controller"
>         depends on ARCH_MXS
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 34c5f28..7c222f2 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -96,6 +96,7 @@ obj-$(CONFIG_SPI_STM32)               += spi-stm32.o
>  obj-$(CONFIG_SPI_ST_SSC4)              += spi-st-ssc4.o
>  obj-$(CONFIG_SPI_SUN4I)                        += spi-sun4i.o
>  obj-$(CONFIG_SPI_SUN6I)                        += spi-sun6i.o
> +obj-$(CONFIG_SPI_SYNQUACER)            += spi-synquacer.o
>  obj-$(CONFIG_SPI_TEGRA114)             += spi-tegra114.o
>  obj-$(CONFIG_SPI_TEGRA20_SFLASH)       += spi-tegra20-sflash.o
>  obj-$(CONFIG_SPI_TEGRA20_SLINK)                += spi-tegra20-slink.o
> diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
> new file mode 100644
> index 0000000..15568b1
> --- /dev/null
> +++ b/drivers/spi/spi-synquacer.c
> @@ -0,0 +1,661 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Synquacer HSSPI controller driver
> +//
> +// Copyright (c) 2015-2018 Socionext Inc.
> +// Copyright (c) 2018 Linaro Ltd.
> +//
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spinlock.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +
> +#define MCTRL          0x0
> +#define MEN    BIT(0)
> +#define CSEN   BIT(1)
> +#define BPCLK  BIT(3)
> +#define MES    BIT(4)
> +#define SYNCON BIT(5)
> +
> +#define PCC0           0x4
> +#define PCC(n)         (PCC0 + (n) * 4)
> +#define RTM    BIT(3)
> +#define ACES   BIT(2)
> +#define SAFESYNC       BIT(16)
> +#define CPHA   BIT(0)
> +#define CPOL   BIT(1)
> +#define SSPOL  BIT(4)
> +#define SDIR   BIT(7)
> +#define SS2CD  5
> +#define SENDIAN        BIT(8)
> +#define CDRS_SHIFT     9
> +#define CDRS_MASK      0x7f
> +
> +#define TXF            0x14
> +#define TXE            0x18
> +#define TXC            0x1c
> +#define RXF            0x20
> +#define RXE            0x24
> +#define RXC            0x28
> +
> +#define FAULTF         0x2c
> +#define FAULTC         0x30
> +
> +#define DMCFG          0x34
> +#define SSDC           BIT(1)
> +#define MSTARTEN       BIT(2)
> +
> +#define        DMSTART         0x38
> +#define TRIGGER                BIT(0)
> +#define DMSTOP         BIT(8)
> +#define CS_MASK                3
> +#define CS_SHIFT       16
> +#define DATA_TXRX      0
> +#define DATA_RX                1
> +#define DATA_TX                2
> +#define DATA_MASK      3
> +#define DATA_SHIFT     26
> +#define BUS_WIDTH      24
> +
> +#define        DMBCC           0x3c
> +#define DMSTATUS       0x40
> +#define RX_DATA_MASK   0x1f
> +#define RX_DATA_SHIFT  8
> +#define TX_DATA_MASK   0x1f
> +#define TX_DATA_SHIFT  16
> +
> +#define TXBITCNT       0x44
> +
> +#define FIFOCFG                0x4c
> +#define BPW_MASK       0x3
> +#define BPW_SHIFT      8
> +#define RX_FLUSH       BIT(11)
> +#define TX_FLUSH       BIT(12)
> +#define RX_TRSHLD_MASK         0xf
> +#define RX_TRSHLD_SHIFT                0
> +#define TX_TRSHLD_MASK         0xf
> +#define TX_TRSHLD_SHIFT                4
> +
> +#define TXFIFO         0x50
> +#define RXFIFO         0x90
> +#define MID            0xfc
> +
> +#define FIFO_DEPTH     16
> +#define TX_TRSHLD      4
> +#define RX_TRSHLD      (FIFO_DEPTH - TX_TRSHLD)
> +
> +#define TXBIT  BIT(1)
> +#define RXBIT  BIT(2)
> +
> +#define IHCLK  0
> +#define IPCLK  1
> +
> +struct synquacer_spi {
> +       struct device *dev;
> +       struct spi_master *master;
> +
> +       unsigned int cs;
> +       unsigned int bpw;
> +       unsigned int mode;
> +       unsigned int speed;
> +       bool aces, rtm;
> +       void *rx_buf;
> +       const void *tx_buf;
> +       struct clk *clk[2];
> +       void __iomem *regs;
> +       unsigned int tx_words, rx_words;
> +       unsigned int bus_width;
> +};
> +
> +static void read_fifo(struct synquacer_spi *sspi)
> +{
> +       u32 len = readl_relaxed(sspi->regs + DMSTATUS);
> +       int i;
> +
> +       len = (len >> RX_DATA_SHIFT) & RX_DATA_MASK;
> +       len = min_t(unsigned int, len, sspi->rx_words);
> +
> +       switch (sspi->bpw) {
> +       case 8:
> +               {
> +               u8 *buf = sspi->rx_buf;
> +
> +               for (i = 0; i < len; i++)
> +                       *buf++ = readb_relaxed(sspi->regs + RXFIFO);
> +               sspi->rx_buf = buf;
> +               break;
> +               }
> +       case 16:
> +               {
> +               u16 *buf = sspi->rx_buf;
> +
> +               for (i = 0; i < len; i++)
> +                       *buf++ = readw_relaxed(sspi->regs + RXFIFO);
> +               sspi->rx_buf = buf;
> +               break;
> +               }
> +       default:
> +               {
> +               u32 *buf = sspi->rx_buf;
> +
> +               for (i = 0; i < len; i++)
> +                       *buf++ = readl_relaxed(sspi->regs + RXFIFO);
> +               sspi->rx_buf = buf;
> +               break;
> +               }
> +       }
> +
> +       sspi->rx_words -= len;
> +}
> +
> +static void write_fifo(struct synquacer_spi *sspi)
> +{
> +       u32 len = readl_relaxed(sspi->regs + DMSTATUS);
> +       int i;
> +
> +       len = (len >> TX_DATA_SHIFT) & TX_DATA_MASK;
> +       len = min_t(unsigned int, FIFO_DEPTH - len, sspi->tx_words);
> +
> +       switch (sspi->bpw) {
> +       case 8:
> +               {
> +               const u8 *buf = sspi->tx_buf;
> +
> +               for (i = 0; i < len; i++)
> +                       writeb_relaxed(*buf++, sspi->regs + TXFIFO);
> +               sspi->tx_buf = buf;
> +               break;
> +               }
> +       case 16:
> +               {
> +               const u16 *buf = sspi->tx_buf;
> +
> +               for (i = 0; i < len; i++)
> +                       writew_relaxed(*buf++, sspi->regs + TXFIFO);
> +               sspi->tx_buf = buf;
> +               break;
> +               }
> +       default:
> +               {
> +               const u32 *buf = sspi->tx_buf;
> +
> +               for (i = 0; i < len; i++)
> +                       writel_relaxed(*buf++, sspi->regs + TXFIFO);
> +               sspi->tx_buf = buf;
> +               break;
> +               }
> +       }
> +       sspi->tx_words -= len;
> +}
> +
> +static int synquacer_spi_config(struct spi_master *master,
> +                               struct spi_device *spi,
> +                               struct spi_transfer *xfer)
> +{
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       unsigned int speed, mode, bpw, cs, bus_width;
> +       unsigned long rate;
> +       u32 val, div;
> +
> +       /* Full Duplex only on 1bit wide bus */
> +       if (xfer->rx_buf && xfer->tx_buf &&
> +           (xfer->rx_nbits != 1 || xfer->tx_nbits != 1)) {
> +               dev_err(sspi->dev,
> +                       "RX and TX bus widths must match for Full-Duplex!\n");
> +               return -EINVAL;
> +       }
> +
> +       if (xfer->tx_buf)
> +               bus_width = xfer->tx_nbits;
> +       else
> +               bus_width = xfer->rx_nbits;
> +
> +       mode = spi->mode;
> +       cs = spi->chip_select;
> +       speed = xfer->speed_hz;
> +       bpw = xfer->bits_per_word;
> +
> +       /* return if nothing to change */
> +       if (speed == sspi->speed &&
> +           bus_width == sspi->bus_width && bpw == sspi->bpw &&
> +           mode == sspi->mode && cs == sspi->cs) {
> +               return 0;
> +       }
> +
> +       rate = master->max_speed_hz;
> +
> +       div = DIV_ROUND_UP(rate, speed);
> +       if (div > 254) {
> +               dev_err(sspi->dev, "Requested rate too low (%u)\n",
> +                       sspi->speed);
> +               return -EINVAL;
> +       }
> +
> +       val = readl_relaxed(sspi->regs + PCC(cs));
> +       val &= ~SAFESYNC;
> +       if (bpw == 8 && (mode & (SPI_TX_DUAL | SPI_RX_DUAL)) && div < 3)
> +               val |= SAFESYNC;
> +       if (bpw == 8 && (mode & (SPI_TX_QUAD | SPI_RX_QUAD)) && div < 6)
> +               val |= SAFESYNC;
> +       if (bpw == 16 && (mode & (SPI_TX_QUAD | SPI_RX_QUAD)) && div < 3)
> +               val |= SAFESYNC;
> +
> +       if (mode & SPI_CPHA)
> +               val |= CPHA;
> +       else
> +               val &= ~CPHA;
> +
> +       if (mode & SPI_CPOL)
> +               val |= CPOL;
> +       else
> +               val &= ~CPOL;
> +
> +       if (mode & SPI_CS_HIGH)
> +               val |= SSPOL;
> +       else
> +               val &= ~SSPOL;
> +
> +       if (mode & SPI_LSB_FIRST)
> +               val |= SDIR;
> +       else
> +               val &= ~SDIR;
> +
> +       if (sspi->aces)
> +               val |= ACES;
> +       else
> +               val &= ~ACES;
> +
> +       if (sspi->rtm)
> +               val |= RTM;
> +       else
> +               val &= ~RTM;
> +
> +       val |= (3 << SS2CD);
> +       val |= SENDIAN;
> +
> +       val &= ~(CDRS_MASK << CDRS_SHIFT);
> +       val |= ((div >> 1) << CDRS_SHIFT);
> +
> +       writel_relaxed(val, sspi->regs + PCC(cs));
> +
> +       val = readl_relaxed(sspi->regs + FIFOCFG);
> +       val &= ~(BPW_MASK << BPW_SHIFT);
> +       val |= ((bpw / 8 - 1) << BPW_SHIFT);
> +       writel_relaxed(val, sspi->regs + FIFOCFG);
> +
> +       val = readl_relaxed(sspi->regs + DMSTART);
> +       val &= ~(DATA_MASK << DATA_SHIFT);
> +
> +       if (xfer->tx_buf && xfer->rx_buf)
> +               val |= (DATA_TXRX << DATA_SHIFT);
> +       else if (xfer->rx_buf)
> +               val |= (DATA_RX << DATA_SHIFT);
> +       else
> +               val |= (DATA_TX << DATA_SHIFT);
> +
> +       val &= ~(3 << BUS_WIDTH);
> +       val |= ((bus_width >> 1) << BUS_WIDTH);
> +       writel_relaxed(val, sspi->regs + DMSTART);
> +
> +       sspi->bpw = bpw;
> +       sspi->mode = mode;
> +       sspi->speed = speed;
> +       sspi->cs = spi->chip_select;
> +       sspi->bus_width = bus_width;
> +
> +       return 0;
> +}
> +
> +static int synquacer_spi_transfer_one(struct spi_master *master,
> +                                     struct spi_device *spi,
> +                                     struct spi_transfer *xfer)
> +{
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       int ret, words, busy = 0;
> +       unsigned long bpw;
> +       u32 val;
> +
> +       val = readl_relaxed(sspi->regs + FIFOCFG);
> +       val |= RX_FLUSH;
> +       val |= TX_FLUSH;
> +       writel_relaxed(val, sspi->regs + FIFOCFG);
> +
> +       /* See if we can transfer 4-bytes as 1 word even if not asked */
> +       bpw = xfer->bits_per_word;
> +       if (bpw == 8 && !(xfer->len % 4) && !(spi->mode & SPI_LSB_FIRST))
> +               xfer->bits_per_word = 32;
> +
> +       ret = synquacer_spi_config(master, spi, xfer);
> +
> +       /* restore */
> +       xfer->bits_per_word = bpw;
> +
> +       if (ret)
> +               return ret;
> +
> +       sspi->tx_buf = xfer->tx_buf;
> +       sspi->rx_buf = xfer->rx_buf;
> +
> +       switch (sspi->bpw) {
> +       case 8:
> +               words = xfer->len;
> +               break;
> +       case 16:
> +               words = xfer->len / 2;
> +               break;
> +       default:
> +               words = xfer->len / 4;
> +               break;
> +       }
> +
> +       if (xfer->tx_buf) {
> +               busy |= TXBIT;
> +               sspi->tx_words = words;
> +       } else {
> +               sspi->tx_words = 0;
> +       }
> +
> +       if (xfer->rx_buf) {
> +               busy |= RXBIT;
> +               sspi->rx_words = words;
> +       } else {
> +               sspi->rx_words = 0;
> +       }
> +
> +       if (xfer->tx_buf)
> +               write_fifo(sspi);
> +
> +       if (xfer->rx_buf) {
> +               val = readl_relaxed(sspi->regs + FIFOCFG);
> +               val &= ~(RX_TRSHLD_MASK << RX_TRSHLD_SHIFT);
> +               val |= ((sspi->rx_words > FIFO_DEPTH ?
> +                       RX_TRSHLD : sspi->rx_words) << RX_TRSHLD_SHIFT);
> +               writel_relaxed(val, sspi->regs + FIFOCFG);
> +       }
> +
> +       writel_relaxed(~0, sspi->regs + TXC);
> +       writel_relaxed(~0, sspi->regs + RXC);
> +
> +       /* Trigger */
> +       val = readl_relaxed(sspi->regs + DMSTART);
> +       val |= TRIGGER;
> +       writel_relaxed(val, sspi->regs + DMSTART);
> +
> +       while (busy & (RXBIT | TXBIT)) {
> +               if (sspi->rx_words)
> +                       read_fifo(sspi);
> +               else
> +                       busy &= ~RXBIT;
> +
> +               if (sspi->tx_words) {
> +                       write_fifo(sspi);
> +               } else {
> +                       u32 len;
> +
> +                       do { /* wait for shifter to empty out */
> +                               cpu_relax();
> +                               len = readl_relaxed(sspi->regs + DMSTATUS);
> +                               len = (len >> TX_DATA_SHIFT) & TX_DATA_MASK;
> +                       } while (xfer->tx_buf && len);
> +                       busy &= ~TXBIT;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void synquacer_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +       struct synquacer_spi *sspi = spi_master_get_devdata(spi->master);
> +       u32 val;
> +
> +       val = readl_relaxed(sspi->regs + DMSTART);
> +       val &= ~(CS_MASK << CS_SHIFT);
> +       val |= spi->chip_select << CS_SHIFT;
> +
> +       if (!enable) {
> +               writel_relaxed(val, sspi->regs + DMSTART);
> +
> +               val = readl_relaxed(sspi->regs + DMSTART);
> +               val &= ~DMSTOP;
> +               writel_relaxed(val, sspi->regs + DMSTART);
> +       } else {
> +               val |= DMSTOP;
> +               writel_relaxed(val, sspi->regs + DMSTART);
> +
> +               if (sspi->rx_buf) {
> +                       u32 buf[16];
> +
> +                       sspi->rx_buf = buf;
> +                       sspi->rx_words = 16;
> +                       read_fifo(sspi);
> +               }
> +       }
> +}
> +
> +static int synquacer_spi_enable(struct spi_master *master)
> +{
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       u32 val;
> +
> +       /* Disable module */
> +       writel_relaxed(0, sspi->regs + MCTRL);
> +       val = 0xfffff;
> +       while (--val && (readl_relaxed(sspi->regs + MCTRL) & MES))
> +               cpu_relax();
> +       if (!val)
> +               return -EBUSY;
> +
> +       writel_relaxed(0, sspi->regs + TXE);
> +       writel_relaxed(0, sspi->regs + RXE);
> +       val = readl_relaxed(sspi->regs + TXF);
> +       writel_relaxed(val, sspi->regs + TXC);
> +       val = readl_relaxed(sspi->regs + RXF);
> +       writel_relaxed(val, sspi->regs + RXC);
> +       val = readl_relaxed(sspi->regs + FAULTF);
> +       writel_relaxed(val, sspi->regs + FAULTC);
> +
> +       val = readl_relaxed(sspi->regs + DMCFG);
> +       val &= ~SSDC;
> +       val &= ~MSTARTEN;
> +       writel_relaxed(val, sspi->regs + DMCFG);
> +
> +       val = readl_relaxed(sspi->regs + MCTRL);
> +       if (IS_ERR(sspi->clk[IPCLK]))
> +               val &= ~BPCLK;
> +       else
> +               val |= BPCLK;
> +
> +       val &= ~CSEN;
> +       val |= MEN;
> +       val |= SYNCON;
> +       writel_relaxed(val, sspi->regs + MCTRL);
> +
> +       return 0;
> +}
> +
> +static int synquacer_spi_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct spi_master *master;
> +       struct synquacer_spi *sspi;
> +       struct resource *res;
> +       int ret;
> +
> +       master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
> +       if (!master)
> +               return -ENOMEM;
> +       platform_set_drvdata(pdev, master);
> +
> +       sspi = spi_master_get_devdata(master);
> +       sspi->dev = &pdev->dev;
> +       sspi->master = master;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       sspi->regs = devm_ioremap_resource(sspi->dev, res);
> +       if (IS_ERR(sspi->regs)) {
> +               ret = PTR_ERR(sspi->regs);
> +               goto put_spi;
> +       }
> +
> +       sspi->clk[IHCLK] = devm_clk_get(sspi->dev, "iHCLK");
> +       if (IS_ERR(sspi->clk[IHCLK])) {
> +               dev_err(&pdev->dev, "iHCLK not found\n");
> +               ret = PTR_ERR(sspi->clk[IHCLK]);
> +               goto put_spi;
> +       }
> +
> +       sspi->clk[IPCLK] = devm_clk_get(sspi->dev, "iPCLK");
> +
> +       sspi->aces = of_property_read_bool(np, "socionext,set-aces");
> +       sspi->rtm = of_property_read_bool(np, "socionext,use-rtm");
> +
> +       master->num_chipselect = 4; /* max 4 supported */
> +
> +       clk_prepare_enable(sspi->clk[IPCLK]);
> +       ret = clk_prepare_enable(sspi->clk[IHCLK]);
> +       if (ret)
> +               goto put_spi;
> +
> +       master->dev.of_node = np;
> +       master->auto_runtime_pm = true;
> +       master->bus_num = pdev->id;
> +
> +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
> +                               SPI_TX_QUAD | SPI_RX_QUAD;
> +       master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24)
> +                                        | SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
> +
> +       if (!IS_ERR(sspi->clk[IPCLK]))
> +               master->max_speed_hz = clk_get_rate(sspi->clk[IPCLK]);
> +       else
> +               master->max_speed_hz = clk_get_rate(sspi->clk[IHCLK]);
> +       master->min_speed_hz = master->max_speed_hz / 254;
> +
> +       master->set_cs = synquacer_spi_set_cs;
> +       master->transfer_one = synquacer_spi_transfer_one;
> +
> +       ret = synquacer_spi_enable(master);
> +       if (ret)
> +               goto fail_enable;
> +
> +       pm_runtime_set_active(sspi->dev);
> +       pm_runtime_enable(sspi->dev);
> +
> +       ret = devm_spi_register_master(sspi->dev, master);
> +       if (ret)
> +               goto disable_pm;
> +
> +       return 0;
> +
> +disable_pm:
> +       pm_runtime_disable(sspi->dev);
> +fail_enable:
> +       clk_disable_unprepare(sspi->clk[IHCLK]);
> +       clk_disable_unprepare(sspi->clk[IPCLK]);
> +put_spi:
> +       spi_master_put(master);
> +
> +       return ret;
> +}
> +
> +static int synquacer_spi_remove(struct platform_device *pdev)
> +{
> +       struct spi_master *master = platform_get_drvdata(pdev);
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +
> +       pm_runtime_disable(sspi->dev);
> +       clk_disable_unprepare(sspi->clk[IHCLK]);
> +       clk_disable_unprepare(sspi->clk[IPCLK]);
> +       spi_master_put(master);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int synquacer_spi_suspend(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       int ret;
> +
> +       ret = spi_master_suspend(master);
> +       if (ret)
> +               return ret;
> +
> +       if (!pm_runtime_suspended(dev)) {
> +               clk_disable_unprepare(sspi->clk[IPCLK]);
> +               clk_disable_unprepare(sspi->clk[IHCLK]);
> +       }
> +
> +       return ret;
> +}
> +
> +static int synquacer_spi_resume(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       int ret;
> +
> +       if (!pm_runtime_suspended(dev)) {
> +               /* Ensure reconfigure during next xfer */
> +               sspi->speed = 0;
> +
> +               clk_prepare_enable(sspi->clk[IPCLK]);
> +               ret = clk_prepare_enable(sspi->clk[IHCLK]);
> +               if (ret < 0) {
> +                       dev_err(dev, "failed to enable clk (%d)\n", ret);
> +                       return ret;
> +               }
> +
> +               ret = synquacer_spi_enable(master);
> +               if (ret) {
> +                       dev_err(dev, "failed to enable spi (%d)\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       ret = spi_master_resume(master);
> +       if (ret < 0) {
> +               clk_disable_unprepare(sspi->clk[IHCLK]);
> +               clk_disable_unprepare(sspi->clk[IPCLK]);
> +       }
> +
> +       return ret;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops synquacer_spi_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(synquacer_spi_suspend, synquacer_spi_resume)
> +};
> +
> +static const struct of_device_id synquacer_spi_of_match[] = {
> +       {.compatible = "socionext,synquacer-spi",},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, synquacer_spi_of_match);
> +
> +static struct platform_driver synquacer_spi_driver = {
> +       .driver = {
> +               .name = "synquacer-spi",
> +               .pm = &synquacer_spi_pm_ops,
> +               .of_match_table = of_match_ptr(synquacer_spi_of_match),
> +       },
> +       .probe = synquacer_spi_probe,
> +       .remove = synquacer_spi_remove,
> +};
> +module_platform_driver(synquacer_spi_driver);
> +
> +MODULE_DESCRIPTION("Socionext Synquacer HS-SPI controller driver");
> +MODULE_AUTHOR("Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
