From: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH V2, 2/4] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Fri, 27 May 2016 16:42:12 -0400
Message-ID: <CAKekbeufyY6SDN0SN_Pm+Bn+qeobr5=n3vTZEWEXkLyoQwiTvQ@mail.gmail.com>
References: <1464380097-25125-1-git-send-email-kdasu.kdev@gmail.com>
 <1464380097-25125-2-git-send-email-kdasu.kdev@gmail.com> <5748AE99.8050303@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5748AE99.8050303-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Will take care of the header and 'depends'.

Kamal

On Fri, May 27, 2016 at 4:31 PM, Scott Branden
<scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
> Hi Kamal,
>
> A few comments.
>
> On 16-05-27 01:14 PM, Kamal Dasu wrote:
>>
>> Adding unified SPI flash and MSPI driver for Broadcom
>> BRCMSTB, NS2, NSP SoCs. Driver shall work with
>> brcm,7120-l2-intc or brcm-l2-intc or with a single
>> muxed L1 interrupt source. Driver implements the
>> queued transfer_one_message() method for reading
>> from and writing to spi device.
>>
>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy
>> <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>> V2 Changes:
>>   Implemented transfer_one_message() method, removed deprecated transfer()
>> method
>>   Refactored MSPI hw read write code to handle spi transfers
>>   Refactored BSPI reads to handle spi transfers
>>   Better handling of LE and BE archtectures via register rw inline
>> functions
>>   Removed all uneceesary code related to message queue handling
>> ---
>>
>>   drivers/spi/Kconfig        |    6 +
>>   drivers/spi/Makefile       |    1 +
>>   drivers/spi/spi-bcm-qspi.c | 1841
>> ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1848 insertions(+)
>>   create mode 100644 drivers/spi/spi-bcm-qspi.c
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 4b931ec..396f9a2 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -153,6 +153,12 @@ config SPI_BCM63XX_HSSPI
>>           This enables support for the High Speed SPI controller present
>> on
>>           newer Broadcom BCM63XX SoCs.
>>
>> +config SPI_BCM_QSPI
>> +       tristate "Broadcom BSPI and MSPI controller support"
>
> depends on ARCH_BCM || COMPILE_TEST
>>
>> +       help
>> +         Enables support for the Broadcom SPI flash and MSPI controller.
>> +         Currently supports BRCMSTB, NSP, NS2 SoCs
>> +
>>   config SPI_BITBANG
>>         tristate "Utilities for Bitbanging SPI masters"
>>         help
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index 3c74d00..2c356c7 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -21,6 +21,7 @@ obj-$(CONFIG_SPI_BCM2835AUX)          +=
>> spi-bcm2835aux.o
>>   obj-$(CONFIG_SPI_BCM53XX)             += spi-bcm53xx.o
>>   obj-$(CONFIG_SPI_BCM63XX)             += spi-bcm63xx.o
>>   obj-$(CONFIG_SPI_BCM63XX_HSSPI)               += spi-bcm63xx-hsspi.o
>> +obj-$(CONFIG_SPI_BCM_QSPI)             += spi-bcm-qspi.o
>>   obj-$(CONFIG_SPI_BFIN5XX)             += spi-bfin5xx.o
>>   obj-$(CONFIG_SPI_ADI_V3)                += spi-adi-v3.o
>>   obj-$(CONFIG_SPI_BFIN_SPORT)          += spi-bfin-sport.o
>> diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
>> new file mode 100644
>> index 0000000..323a6d9
>> --- /dev/null
>> +++ b/drivers/spi/spi-bcm-qspi.c
>> @@ -0,0 +1,1841 @@
>> +/*
>> + * Copyright (C) 2014-2016 Broadcom
>> + *
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions
>> + * are met:
>> + * 1. Redistributions of source code must retain the above copyright
>> + *    notice, this list of conditions and the following disclaimer.
>> + * 2. Redistributions in binary form must reproduce the above copyright
>> + *    notice, this list of conditions and the following disclaimer in the
>> + *    documentation and/or other materials provided with the
>> distribution.
>> + * 3. Neither the name of the project nor the names of its contributors
>> + *    may be used to endorse or promote products derived from this
>> software
>> + *    without specific prior written permission.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS''
>> AND
>> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
>> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
>> PURPOSE
>> + * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE
>> LIABLE
>> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>> CONSEQUENTIAL
>> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
>> GOODS
>> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
>> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
>> STRICT
>> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
>> WAY
>> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
>> + * SUCH DAMAGE.
>> + */
>
> This file should have the standard Broadcom GPL header on it.
>
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/ioport.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mtd/cfi.h>
>> +#include <linux/mtd/spi-nor.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/types.h>
>> +
>> +#define DRIVER_NAME "bcm_qspi"
>> +
>> +#define DBG(...)                               pr_debug(__VA_ARGS__)
>> +
>> +#define STATE_IDLE                             0
>> +#define STATE_RUNNING                          1
>> +#define STATE_SHUTDOWN                         2
>> +
>> +/* BSPI register offsets */
>> +#define BSPI_REVISION_ID                       0x000
>> +#define BSPI_SCRATCH                           0x004
>> +#define BSPI_MAST_N_BOOT_CTRL                  0x008
>> +#define BSPI_BUSY_STATUS                       0x00c
>> +#define BSPI_INTR_STATUS                       0x010
>> +#define BSPI_B0_STATUS                         0x014
>> +#define BSPI_B0_CTRL                           0x018
>> +#define BSPI_B1_STATUS                         0x01c
>> +#define BSPI_B1_CTRL                           0x020
>> +#define BSPI_STRAP_OVERRIDE_CTRL               0x024
>> +#define BSPI_FLEX_MODE_ENABLE                  0x028
>> +#define BSPI_BITS_PER_CYCLE                    0x02c
>> +#define BSPI_BITS_PER_PHASE                    0x030
>> +#define BSPI_CMD_AND_MODE_BYTE                 0x034
>> +#define BSPI_BSPI_FLASH_UPPER_ADDR_BYTE        0x038
>> +#define BSPI_BSPI_XOR_VALUE                    0x03c
>> +#define BSPI_BSPI_XOR_ENABLE                   0x040
>> +#define BSPI_BSPI_PIO_MODE_ENABLE              0x044
>> +#define BSPI_BSPI_PIO_IODIR                    0x048
>> +#define BSPI_BSPI_PIO_DATA                     0x04c
>> +
>> +/* RAF register offsets */
>> +#define BSPI_RAF_START_ADDR                    0x100
>> +#define BSPI_RAF_NUM_WORDS                     0x104
>> +#define BSPI_RAF_CTRL                          0x108
>> +#define BSPI_RAF_FULLNESS                      0x10c
>> +#define BSPI_RAF_WATERMARK                     0x110
>> +#define BSPI_RAF_STATUS                        0x114
>> +#define BSPI_RAF_READ_DATA                     0x118
>> +#define BSPI_RAF_WORD_CNT                      0x11c
>> +#define BSPI_RAF_CURR_ADDR                     0x120
>> +
>> +/* MSPI register offsets */
>> +#define MSPI_SPCR0_LSB                         0x000
>> +#define MSPI_SPCR0_MSB                         0x004
>> +#define MSPI_SPCR1_LSB                         0x008
>> +#define MSPI_SPCR1_MSB                         0x00c
>> +#define MSPI_NEWQP                             0x010
>> +#define MSPI_ENDQP                             0x014
>> +#define MSPI_SPCR2                             0x018
>> +#define MSPI_MSPI_STATUS                       0x020
>> +#define MSPI_CPTQP                             0x024
>> +#define MSPI_SPCR3                             0x028
>> +#define MSPI_TXRAM                             0x040
>> +#define MSPI_RXRAM                             0x0c0
>> +#define MSPI_CDRAM                             0x140
>> +#define MSPI_WRITE_LOCK                        0x180
>> +
>> +#define MSPI_MASTER_BIT                        BIT(7)
>> +
>> +#define MSPI_NUM_CDRAM                         16
>> +#define MSPI_CDRAM_CONT_BIT                    BIT(7)
>> +#define MSPI_CDRAM_BITSE_BIT                   BIT(6)
>> +#define MSPI_CDRAM_PCS                         0xf
>> +
>> +#define MSPI_SPCR2_SPE                         BIT(6)
>> +#define MSPI_SPCR2_CONT_AFTER_CMD              BIT(7)
>> +
>> +#define MSPI_MSPI_STATUS_SPIF                  BIT(0)
>> +
>> +#define BSPI_ADDRLEN_3BYTES                    3
>> +#define BSPI_ADDRLEN_4BYTES                    4
>> +
>> +#define BSPI_RAF_STATUS_FIFO_EMPTY_MASK        BIT(1)
>> +
>> +#define BSPI_RAF_CTRL_START_MASK               BIT(0)
>> +#define BSPI_RAF_CTRL_CLEAR_MASK               BIT(1)
>> +
>> +#define BSPI_BPP_MODE_SELECT_MASK              BIT(8)
>> +#define BSPI_BPP_ADDR_SELECT_MASK              BIT(16)
>> +
>> +/* HIF INTR2 offsets */
>> +#define HIF_SPI_INTR2_CPU_STATUS               0x00
>> +#define HIF_SPI_INTR2_CPU_SET                  0x04
>> +#define HIF_SPI_INTR2_CPU_CLEAR                0x08
>> +#define HIF_SPI_INTR2_CPU_MASK_STATUS          0x0c
>> +#define HIF_SPI_INTR2_CPU_MASK_SET             0x10
>> +#define HIF_SPI_INTR2_CPU_MASK_CLEAR           0x14
>> +
>> +#define INTR_BASE_BIT_SHIFT                    0x02
>> +#define INTR_COUNT                             0x07
>> +
>> +/* MSPI Interrupt masks */
>> +#define INTR_MSPI_HALTED_MASK                  BIT(6)
>> +#define INTR_MSPI_DONE_MASK                     BIT(5)
>> +
>> +/* BSPI interrupt masks */
>> +#define INTR_BSPI_LR_OVERREAD_MASK             BIT(4)
>> +#define INTR_BSPI_LR_SESSION_DONE_MASK         BIT(3)
>> +#define INTR_BSPI_LR_IMPATIENT_MASK            BIT(2)
>> +#define INTR_BSPI_LR_SESSION_ABORTED_MASK      BIT(1)
>> +#define INTR_BSPI_LR_FULLNESS_REACHED_MASK     BIT(0)
>> +
>> +/* Override mode masks */
>> +#define BSPI_STRAP_OVERRIDE_CTRL_OVERRIDE      BIT(0)
>> +#define BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL     BIT(1)
>> +#define BSPI_STRAP_OVERRIDE_CTRL_ADDR_4BYTE    BIT(2)
>> +#define BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD     BIT(3)
>> +#define BSPI_STRAP_OVERRIDE_CTRL_ENDAIN_MODE   BIT(4)
>> +
>> +#define MSPI_INTERRUPTS_ALL                    \
>> +       (INTR_MSPI_DONE_MASK |                  \
>> +        INTR_MSPI_HALTED_MASK)
>> +
>> +#define BSPI_LR_INTERRUPTS_DATA                \
>> +       (INTR_BSPI_LR_SESSION_DONE_MASK |       \
>> +        INTR_BSPI_LR_FULLNESS_REACHED_MASK)
>> +
>> +#define BSPI_LR_INTERRUPTS_ERROR               \
>> +       (INTR_BSPI_LR_OVERREAD_MASK |           \
>> +        INTR_BSPI_LR_IMPATIENT_MASK |          \
>> +        INTR_BSPI_LR_SESSION_ABORTED_MASK)
>> +
>> +#define BSPI_LR_INTERRUPTS_ALL                 \
>> +       (BSPI_LR_INTERRUPTS_ERROR |             \
>> +        BSPI_LR_INTERRUPTS_DATA)
>> +
>> +#define QSPI_INTERRUPTS_ALL                    \
>> +       (MSPI_INTERRUPTS_ALL |                  \
>> +        BSPI_LR_INTERRUPTS_ALL)
>> +
>> +#define BSPI_FLASH_TYPE_UNKNOWN                -1
>> +
>> +#define NUM_CHIPSELECT                         4
>> +#define MSPI_BASE_FREQ                         27000000UL
>> +#define QSPI_SPBR_MIN                          8U
>> +#define QSPI_SPBR_MAX                          255U
>> +#define MAX_SPEED_HZ           (MSPI_BASE_FREQ / (QSPI_SPBR_MIN * 2))
>> +
>> +#define OPCODE_DIOR                            0xBB
>> +#define OPCODE_QIOR                            0xEB
>> +#define OPCODE_DIOR_4B                         0xBC
>> +#define OPCODE_QIOR_4B                         0xEC
>> +
>> +#define PARMS_NO_OVERRIDE                      0
>> +#define PARMS_OVERRIDE                         1
>> +
>> +#define DWORD_ALIGNED(a)                       IS_ALIGNED((uintptr_t)(a),
>> 4)
>> +#define ADDR_TO_4MBYTE_SEGMENT(addr)           (((u32)(addr)) >> 22)
>> +
>> +static int bspi_flash = BSPI_FLASH_TYPE_UNKNOWN;
>> +
>> +struct bcm_qspi_parms {
>> +       u32 speed_hz;
>> +       u8 chip_select;
>> +       u8 mode;
>> +       u8 bits_per_word;
>> +};
>> +
>> +static const struct bcm_qspi_parms bcm_qspi_default_parms_cs0 = {
>> +       .speed_hz = MAX_SPEED_HZ,
>> +       .chip_select = 0,
>> +       .mode = SPI_MODE_3,
>> +       .bits_per_word = 8,
>> +};
>> +
>> +struct bcm_xfer_mode {
>> +       bool flex_mode;
>> +       unsigned int width;
>> +       unsigned int addrlen;
>> +       unsigned int hp;
>> +};
>> +
>> +enum base_type {
>> +       MSPI,
>> +       BSPI,
>> +       INTR,
>> +       INTR_STATUS,
>> +       CHIP_SELECT,
>> +       BASEMAX,
>> +};
>> +
>> +struct bcm_qspi_irq {
>> +       const char *irq_name;
>> +       const irq_handler_t irq_handler;
>> +       u32 mask;
>> +};
>> +
>> +struct bcm_qspi_dev_id {
>> +       const struct bcm_qspi_irq *irqp;
>> +       void *dev;
>> +};
>> +
>> +struct position {
>> +       struct spi_transfer     *trans;
>> +       int                     byte;
>> +};
>> +
>> +struct bcm_qspi {
>> +       struct platform_device *pdev;
>> +       struct spi_master *master;
>> +       struct clk *clk;
>> +       u32 base_clk;
>> +       u32 max_speed_hz;
>> +       void __iomem *base[BASEMAX];
>> +       struct bcm_qspi_parms last_parms;
>> +       struct position  pos;
>> +       int state;
>> +       int next_udelay;
>> +       int cs_change;
>> +       int curr_cs;
>> +       int bspi_maj_rev;
>> +       int bspi_min_rev;
>> +       int bspi_enabled;
>> +       int bspi_cs_bmap;
>> +       struct spi_transfer *bspi_xfer;
>> +       u32 bspi_xfer_idx;
>> +       u32 bspi_xfer_len;
>> +       u32 bspi_xfer_status;
>> +       u32 actual_length;
>> +       struct bcm_xfer_mode xfer_mode;
>> +       u32 s3_intr2_mask;
>> +       u32 s3_strap_override_ctrl;
>> +       bool hif_spi_mode;
>> +       bool bspi_mode;
>> +       int num_irqs;
>> +       struct bcm_qspi_dev_id *dev_ids;
>> +       struct completion mspi_done;
>> +       struct completion bspi_done;
>> +};
>> +
>> +static inline bool has_bspi(struct bcm_qspi *qspi)
>> +{
>> +       return qspi->bspi_mode;
>> +}
>> +
>> +/* Read qspi controller register*/
>> +static inline u32 bcm_qspi_read(struct bcm_qspi *qspi, enum base_type
>> type,
>> +                                  unsigned int offset)
>> +{
>> +       if (!qspi->base[type])
>> +               return 0;
>> +
>> +       /*
>> +        * MIPS endianness is configured by boot strap, which also
>> reverses all
>> +        * bus endianness (i.e., big-endian CPU + big endian bus ==>
>> native
>> +        * endian I/O).
>> +        *
>> +        * Other architectures (e.g., ARM) either do not support big
>> endian, or
>> +        * else leave I/O in little endian mode.
>> +        */
>> +       if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>> +               return __raw_readl(qspi->base[type] + offset);
>> +       else
>> +               return readl_relaxed(qspi->base[type] + offset);
>> +
>> +}
>> +
>> +/* Write qspi controller register*/
>> +static inline void bcm_qspi_write(struct bcm_qspi *qspi, enum base_type
>> type,
>> +                        unsigned int offset, unsigned int data)
>> +{
>> +       if (!qspi->base[type])
>> +               return;
>> +
>> +       /* See brcm_mspi_readl() comments */
>> +       if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>> +               __raw_writel(data, (qspi->base[type] + offset));
>> +       else
>> +               writel_relaxed(data, (qspi->base[type] + offset));
>> +}
>> +
>> +static void bcm_qspi_enable_interrupt(struct bcm_qspi *qspi, u32 mask)
>> +{
>> +       unsigned int val;
>> +
>> +       if (!qspi->base[INTR])
>> +               return;
>> +
>> +       if (qspi->hif_spi_mode)
>> +               bcm_qspi_write(qspi, INTR, HIF_SPI_INTR2_CPU_MASK_CLEAR,
>> mask);
>> +       else {
>> +               val = bcm_qspi_read(qspi, INTR, 0);
>> +               val = val | (mask << INTR_BASE_BIT_SHIFT);
>> +               bcm_qspi_write(qspi, INTR, 0, val);
>> +       }
>> +}
>> +
>> +static void bcm_qspi_disable_interrupt(struct bcm_qspi *qspi, u32 mask)
>> +{
>> +       unsigned int val;
>> +
>> +       if (!qspi->base[INTR])
>> +               return;
>> +
>> +       if (qspi->hif_spi_mode)
>> +               bcm_qspi_write(qspi, INTR, HIF_SPI_INTR2_CPU_MASK_SET,
>> mask);
>> +       else {
>> +               val = bcm_qspi_read(qspi, INTR, 0);
>> +               val = val & ~(mask << INTR_BASE_BIT_SHIFT);
>> +               bcm_qspi_write(qspi, INTR, 0, val);
>> +       }
>> +}
>> +
>> +static void bcm_qspi_clear_interrupt(struct bcm_qspi *qspi, u32 mask)
>> +{
>> +       unsigned int val;
>> +
>> +       if (!qspi->base[INTR_STATUS])
>> +               return;
>> +
>> +       if (qspi->hif_spi_mode)
>> +               bcm_qspi_write(qspi, INTR_STATUS,
>> +                              HIF_SPI_INTR2_CPU_CLEAR, mask);
>> +       else {
>> +               for (val = 0; val < INTR_COUNT; val++) {
>> +                       if (mask & (1UL << val))
>> +                               bcm_qspi_write(qspi, INTR_STATUS,
>> +                                                       (val * 4), 1);
>> +               }
>> +       }
>> +}
>> +
>> +static u32 bcm_qspi_read_l2int_status(struct bcm_qspi *qspi)
>> +{
>> +       unsigned int val = 0;
>> +       unsigned int i = 0;
>> +
>> +       BUG_ON(!qspi->base[INTR_STATUS]);
>> +
>> +       if (qspi->hif_spi_mode)
>> +               val = bcm_qspi_read(qspi, INTR_STATUS,
>> +                                   HIF_SPI_INTR2_CPU_STATUS);
>> +       else {
>> +               for (i = 0; i < INTR_COUNT; i++) {
>> +                       if (bcm_qspi_read(qspi, INTR_STATUS, (i * 4)))
>> +                               val |= 1UL << i;
>> +               }
>> +       }
>> +       return val;
>> +}
>> +
>> +static int bcm_qspi_bspi_busy_poll(struct bcm_qspi *qspi)
>> +{
>> +       int i;
>> +
>> +       /* this should normally finish within 10us */
>> +       for (i = 0; i < 1000; i++) {
>> +               if (!(bcm_qspi_read(qspi, BSPI, BSPI_BUSY_STATUS) & 1))
>> +                       return 0;
>> +               udelay(1);
>> +       }
>> +       dev_warn(&qspi->pdev->dev, "timeout waiting for !busy_status\n");
>> +       return -EIO;
>> +}
>> +
>> +static inline bool bcm_qspi_bspi_ver_three(struct bcm_qspi *qspi)
>> +{
>> +       if (qspi->bspi_maj_rev < 4)
>> +               return true;
>> +       return false;
>> +}
>> +
>> +static void bcm_qspi_flush_prefetch_buffers(struct bcm_qspi *qspi)
>> +{
>> +       bcm_qspi_bspi_busy_poll(qspi);
>> +       /* Force rising edge for the b0/b1 'flush' field */
>> +       bcm_qspi_write(qspi, BSPI, BSPI_B0_CTRL, 1);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_B1_CTRL, 1);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_B0_CTRL, 0);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_B1_CTRL, 0);
>> +}
>> +
>> +static int bcm_qspi_lr_is_fifo_empty(struct bcm_qspi *qspi)
>> +{
>> +       return (bcm_qspi_read(qspi, BSPI, BSPI_RAF_STATUS) &
>> +                               BSPI_RAF_STATUS_FIFO_EMPTY_MASK);
>> +}
>> +
>> +static inline u32 bcm_qspi_lr_read_fifo(struct bcm_qspi *qspi)
>> +{
>> +       u32 data = bcm_qspi_read(qspi, BSPI, BSPI_RAF_READ_DATA);
>> +
>> +       /* BSPI v3 LR is LE only, convert data to host endianness */
>> +       if (bcm_qspi_bspi_ver_three(qspi))
>> +               data = le32_to_cpu(data);
>> +
>> +       return data;
>> +}
>> +
>> +static inline void bcm_qspi_lr_start(struct bcm_qspi *qspi)
>> +{
>> +       bcm_qspi_bspi_busy_poll(qspi);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_RAF_CTRL,
>> +                               BSPI_RAF_CTRL_START_MASK);
>> +}
>> +
>> +static inline void bcm_qspi_lr_clear(struct bcm_qspi *qspi)
>> +{
>> +       bcm_qspi_write(qspi, BSPI, BSPI_RAF_CTRL,
>> +                               BSPI_RAF_CTRL_CLEAR_MASK);
>> +       bcm_qspi_flush_prefetch_buffers(qspi);
>> +}
>> +
>> +static void bcm_qspi_bspi_lr_data_read(struct bcm_qspi *qspi)
>> +{
>> +       u32 *buf = (u32 *)qspi->bspi_xfer->rx_buf;
>> +       u32 data = 0;
>> +
>> +       DBG("xfer %p rx %p rxlen %d\n",
>> +           qspi->bspi_xfer, qspi->bspi_xfer->rx_buf,
>> qspi->bspi_xfer_len);
>> +       while (!bcm_qspi_lr_is_fifo_empty(qspi)) {
>> +               data = bcm_qspi_lr_read_fifo(qspi);
>> +               if (likely(qspi->bspi_xfer_len >= 4) &&
>> +                   likely(DWORD_ALIGNED(buf))) {
>> +                       buf[qspi->bspi_xfer_idx++] = data;
>> +                       qspi->bspi_xfer_len -= 4;
>> +               } else {
>> +                       /* Read out remaining bytes, make sure*/
>> +                       u8 *cbuf = (u8 *)&buf[qspi->bspi_xfer_idx];
>> +
>> +                       data = cpu_to_le32(data);
>> +                       while (qspi->bspi_xfer_len) {
>> +                               *cbuf++ = (u8)data;
>> +                               data >>= 8;
>> +                               qspi->bspi_xfer_len--;
>> +                       }
>> +               }
>> +       }
>> +}
>> +
>> +static inline int bcm_qspi_is_4_byte_mode(struct bcm_qspi *qspi)
>> +{
>> +       return qspi->xfer_mode.addrlen == BSPI_ADDRLEN_4BYTES;
>> +}
>> +
>> +static void bcm_qspi_bspi_set_xfer_params(struct bcm_qspi *qspi, u8
>> cmd_byte,
>> +                                         int bpp, int bpc, int flex_mode)
>> +{
>> +       bcm_qspi_write(qspi, BSPI, BSPI_FLEX_MODE_ENABLE, 0);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_BITS_PER_CYCLE, bpc);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_BITS_PER_PHASE, bpp);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_CMD_AND_MODE_BYTE, cmd_byte);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_FLEX_MODE_ENABLE, flex_mode);
>> +}
>> +
>> +static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi, int width,
>> +                                      int addrlen, int hp)
>> +{
>> +       int bpc = 0, bpp = 0;
>> +       u8 command = SPINOR_OP_READ_FAST;
>> +       int flex_mode = 1, rv = 0;
>> +       bool spans_4byte = false;
>> +
>> +       DBG("set flex mode w %x addrlen %x hp %d\n", width, addrlen, hp);
>> +
>> +       if (addrlen == BSPI_ADDRLEN_4BYTES) {
>> +               bpp = BSPI_BPP_ADDR_SELECT_MASK;
>> +               spans_4byte = true;
>> +       }
>> +
>> +       bpp |= 8; /* dummy cycles */
>> +
>> +       switch (width) {
>> +       case SPI_NBITS_SINGLE:
>> +               if (addrlen == BSPI_ADDRLEN_3BYTES)
>> +                       /* default mode, does not need flex_cmd */
>> +                       flex_mode = 0;
>> +               else
>> +                       command = SPINOR_OP_READ4_FAST;
>> +               break;
>> +       case SPI_NBITS_DUAL:
>> +               bpc = 0x00000001;
>> +               if (hp) {
>> +                       bpc |= 0x00010100; /* address and mode are 2-bit
>> */
>> +                       bpp = BSPI_BPP_MODE_SELECT_MASK;
>> +                       command = OPCODE_DIOR;
>> +                       if (spans_4byte == true)
>> +                               command = OPCODE_DIOR_4B;
>> +               } else {
>> +                       command = SPINOR_OP_READ_1_1_2;
>> +                       if (spans_4byte == true)
>> +                               command = SPINOR_OP_READ4_1_1_2;
>> +               }
>> +               break;
>> +       case SPI_NBITS_QUAD:
>> +               bpc = 0x00000002;
>> +               if (hp) {
>> +                       bpc |= 0x00020200; /* address and mode are 4-bit
>> */
>> +                       bpp = 4; /* dummy cycles */
>> +                       bpp |= BSPI_BPP_ADDR_SELECT_MASK;
>> +                       command = OPCODE_QIOR;
>> +                       if (spans_4byte == true)
>> +                               command = OPCODE_QIOR_4B;
>> +               } else {
>> +                       command = SPINOR_OP_READ_1_1_4;
>> +                       if (spans_4byte == true)
>> +                               command = SPINOR_OP_READ4_1_1_4;
>> +               }
>> +               break;
>> +       default:
>> +               rv = -1;
>> +               break;
>> +       }
>> +
>> +       if (!rv)
>> +               bcm_qspi_bspi_set_xfer_params(qspi, command, bpp, bpc,
>> +                                             flex_mode);
>> +
>> +       return rv;
>> +}
>> +
>> +static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi, int width,
>> +                                     int addrlen, int hp)
>> +{
>> +       u32 data = bcm_qspi_read(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL);
>> +
>> +       DBG("set override mode w %x addrlen %x hp %d\n", width, addrlen,
>> hp);
>> +
>> +       switch (width) {
>> +       case SPI_NBITS_QUAD:
>> +               /* clear dual mode and set quad mode */
>> +               data &= ~BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL;
>> +               data |= BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD;
>> +               break;
>> +       case SPI_NBITS_DUAL:
>> +               /* clear quad mode set dual mode */
>> +               data &= ~BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD;
>> +               data |= BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL;
>> +               break;
>> +       case SPI_NBITS_SINGLE:
>> +               /* clear quad/dual mode */
>> +               data &= ~(BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD |
>> +                         BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL);
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       if (addrlen == BSPI_ADDRLEN_4BYTES)
>> +               /* set 4byte mode*/
>> +               data |= BSPI_STRAP_OVERRIDE_CTRL_ADDR_4BYTE;
>> +       else
>> +               /* clear 4 byte mode */
>> +               data &= ~BSPI_STRAP_OVERRIDE_CTRL_ADDR_4BYTE;
>> +
>> +       /* set the override mode */
>> +       data |= BSPI_STRAP_OVERRIDE_CTRL_OVERRIDE;
>> +       bcm_qspi_write(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL, data);
>> +       bcm_qspi_bspi_set_xfer_params(qspi, SPINOR_OP_READ_FAST, 0, 0, 0);
>> +
>> +       return 0;
>> +}
>> +
>> +static void bcm_qspi_bspi_set_mode(struct bcm_qspi *qspi,
>> +                                  int width, int addrlen, int hp)
>> +{
>> +       int error = 0;
>> +
>> +       if (width == -1)
>> +               width = qspi->xfer_mode.width;
>> +       if (addrlen == -1)
>> +               addrlen = qspi->xfer_mode.addrlen;
>> +       if (hp == -1)
>> +               hp = qspi->xfer_mode.hp;
>> +
>> +       /* default mode */
>> +       qspi->xfer_mode.flex_mode = true;
>> +
>> +       if (!bcm_qspi_bspi_ver_three(qspi)) {
>> +               u32 val, mask;
>> +
>> +               val = bcm_qspi_read(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL);
>> +               mask = BSPI_STRAP_OVERRIDE_CTRL_OVERRIDE;
>> +               if (val & mask || qspi->s3_strap_override_ctrl & mask) {
>> +                       qspi->xfer_mode.flex_mode = false;
>> +                       bcm_qspi_write(qspi, BSPI, BSPI_FLEX_MODE_ENABLE,
>> +                                      0);
>> +
>> +                       if ((val | qspi->s3_strap_override_ctrl) &
>> +                           BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL)
>> +                               width = SPI_NBITS_DUAL;
>> +                       else if ((val |  qspi->s3_strap_override_ctrl) &
>> +                                BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD)
>> +                               width = SPI_NBITS_QUAD;
>> +
>> +                       error = bcm_qspi_bspi_set_override(qspi, width,
>> addrlen,
>> +                                                          hp);
>> +               }
>> +       }
>> +
>> +       if (qspi->xfer_mode.flex_mode)
>> +               error = bcm_qspi_bspi_set_flex_mode(qspi, width, addrlen,
>> hp);
>> +
>> +       if (!error) {
>> +               qspi->xfer_mode.width = width;
>> +               qspi->xfer_mode.addrlen = addrlen;
>> +               qspi->xfer_mode.hp = hp;
>> +               dev_info(&qspi->pdev->dev,
>> +                       "%d-lane output, %d-byte address%s\n",
>> +                       qspi->xfer_mode.width,
>> +                       qspi->xfer_mode.addrlen,
>> +                       qspi->xfer_mode.hp ? ", high-performance mode" :
>> "");
>> +       } else
>> +               dev_warn(&qspi->pdev->dev,
>> +                       "INVALID COMBINATION: width=%d addrlen=%d
>> hp=%d\n",
>> +                       width, addrlen, hp);
>> +}
>> +
>> +static void bcm_qspi_chip_select(struct bcm_qspi *qspi, int cs)
>> +{
>> +       u32 data = 0;
>> +
>> +       if (qspi->curr_cs == cs)
>> +               return;
>> +       if (qspi->base[CHIP_SELECT]) {
>> +               data = bcm_qspi_read(qspi, CHIP_SELECT, 0);
>> +               data = (data & ~0xff) | (1 << cs);
>> +               bcm_qspi_write(qspi, CHIP_SELECT, 0, data);
>> +               udelay(10);
>> +       }
>> +       qspi->curr_cs = cs;
>> +}
>> +
>> +static inline int bcm_qspi_bspi_cs(struct bcm_qspi *qspi, u8 cs)
>> +{
>> +       return qspi->bspi_cs_bmap & (1 << cs);
>> +}
>> +
>> +static void bcm_qspi_enable_bspi(struct bcm_qspi *qspi)
>> +{
>> +
>> +       if ((!qspi->base[BSPI]) || (qspi->bspi_enabled))
>> +               return;
>> +
>> +       qspi->bspi_enabled = 1;
>> +       if ((bcm_qspi_read(qspi, BSPI, BSPI_MAST_N_BOOT_CTRL) & 1) == 0)
>> +               return;
>> +
>> +       bcm_qspi_flush_prefetch_buffers(qspi);
>> +       udelay(1);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_MAST_N_BOOT_CTRL, 0);
>> +       udelay(1);
>> +}
>> +
>> +static void bcm_qspi_disable_bspi(struct bcm_qspi *qspi)
>> +{
>> +       if ((!qspi->base[BSPI]) || (!qspi->bspi_enabled))
>> +               return;
>> +
>> +       qspi->bspi_enabled = 0;
>> +       if ((bcm_qspi_read(qspi, BSPI, BSPI_MAST_N_BOOT_CTRL) & 1))
>> +               return;
>> +
>> +       bcm_qspi_bspi_busy_poll(qspi);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_MAST_N_BOOT_CTRL, 1);
>> +       udelay(1);
>> +}
>> +
>> +static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
>> +                                 const struct bcm_qspi_parms *xp)
>> +{
>> +       u32 spcr, spbr = 0;
>> +
>> +       if (xp->speed_hz)
>> +               spbr = qspi->base_clk / (2 * xp->speed_hz);
>> +
>> +       spcr = clamp_val(spbr, QSPI_SPBR_MIN, QSPI_SPBR_MAX);
>> +       bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_LSB, spcr);
>> +
>> +       spcr = MSPI_MASTER_BIT;
>> +       /* for 16 bit the data should be zero */
>> +       if (xp->bits_per_word != 16)
>> +               spcr |= xp->bits_per_word << 2;
>> +       spcr |= xp->mode & 3;
>> +       bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_MSB, spcr);
>> +
>> +       qspi->last_parms = *xp;
>> +}
>> +
>> +static int bcm_qspi_update_parms(struct bcm_qspi *qspi,
>> +                                struct spi_device *spidev,
>> +                                struct spi_transfer *trans, int override)
>> +{
>> +       struct bcm_qspi_parms xp;
>> +
>> +       xp.speed_hz = min(trans->speed_hz ? trans->speed_hz :
>> +                       (spidev->max_speed_hz ? spidev->max_speed_hz :
>> +                       qspi->max_speed_hz), qspi->max_speed_hz);
>> +       xp.chip_select = spidev->chip_select;
>> +       xp.mode = spidev->mode;
>> +       xp.bits_per_word = trans->bits_per_word ? trans->bits_per_word :
>> +               (spidev->bits_per_word ? spidev->bits_per_word : 8);
>> +
>> +       if ((override == PARMS_OVERRIDE) ||
>> +               ((xp.speed_hz == qspi->last_parms.speed_hz) &&
>> +                (xp.chip_select == qspi->last_parms.chip_select) &&
>> +                (xp.mode == qspi->last_parms.mode) &&
>> +                (xp.bits_per_word == qspi->last_parms.bits_per_word))) {
>> +               bcm_qspi_hw_set_parms(qspi, &xp);
>> +               return 0;
>> +       }
>> +       /* no override, and parms do not match */
>> +       return 1;
>> +}
>> +
>> +static int bcm_qspi_setup(struct spi_device *spi)
>> +{
>> +       struct bcm_qspi_parms *xp;
>> +
>> +       if (spi->bits_per_word > 16)
>> +               return -EINVAL;
>> +
>> +       xp = spi_get_ctldata(spi);
>> +       if (!xp) {
>> +               xp = kzalloc(sizeof(struct bcm_qspi_parms), GFP_KERNEL);
>> +               if (!xp)
>> +                       return -ENOMEM;
>> +               spi_set_ctldata(spi, xp);
>> +       }
>> +       xp->speed_hz = spi->max_speed_hz;
>> +       xp->chip_select = spi->chip_select;
>> +       xp->mode = spi->mode;
>> +       xp->bits_per_word = spi->bits_per_word ? spi->bits_per_word : 8;
>> +
>> +       return 0;
>> +}
>> +
>> +/* MSPI helpers */
>> +
>> +/* stop at end of transfer, no other reason */
>> +#define FNB_BREAK_NONE                 0
>> +/* stop at end of spi_message */
>> +#define FNB_BREAK_EOM                  1
>> +/* stop at end of spi_transfer if delay */
>> +#define FNB_BREAK_DELAY                        2
>> +/* stop at end of spi_transfer if cs_change */
>> +#define FNB_BREAK_CS_CHANGE            4
>> +/* stop if we run out of bytes */
>> +#define FNB_BREAK_NO_BYTES             8
>> +
>> +/* events that make us stop filling TX slots */
>> +#define FNB_BREAK_TX                   (FNB_BREAK_EOM | FNB_BREAK_DELAY |
>> \
>> +                                        FNB_BREAK_CS_CHANGE)
>> +
>> +/* events that make us deassert CS */
>> +#define FNB_BREAK_DESELECT             (FNB_BREAK_EOM |
>> FNB_BREAK_CS_CHANGE)
>> +
>> +static int find_next_byte(struct bcm_qspi *qspi, struct position *p,
>> +                         int flags)
>> +{
>> +       int ret = FNB_BREAK_NONE;
>> +
>> +       if (p->trans->bits_per_word <= 8)
>> +               p->byte++;
>> +       else
>> +               p->byte += 2;
>> +
>> +       if (p->byte >= p->trans->len) {
>> +               /* we're at the end of the spi_transfer */
>> +
>> +               /* in TX mode, need to pause for a delay or CS change */
>> +               if (p->trans->delay_usecs && (flags & FNB_BREAK_DELAY))
>> +                       ret |= FNB_BREAK_DELAY;
>> +               if (p->trans->cs_change && (flags & FNB_BREAK_CS_CHANGE))
>> +                       ret |= FNB_BREAK_CS_CHANGE;
>> +               if (ret)
>> +                       goto done;
>> +
>> +               DBG("find_next_byte: advance msg exit\n");
>> +               if (spi_transfer_is_last(qspi->master, p->trans))
>> +                       ret = FNB_BREAK_EOM;
>> +               else
>> +                       ret = FNB_BREAK_NO_BYTES;
>> +
>> +               p->trans = NULL;
>> +       }
>> +
>> +done:
>> +       DBG("find_next_byte: trans %p len %d byte %d ret %x\n",
>> +               p->trans, p->trans ? p->trans->len : 0, p->byte, ret);
>> +       return ret;
>> +}
>> +
>> +static inline u8 read_rxram_slot_u8(struct bcm_qspi *qspi, int slot)
>> +{
>> +       u32 slot_offset = MSPI_RXRAM + (slot << 3) + 0x4;
>> +
>> +       /* mask out reserved bits */
>> +       return bcm_qspi_read(qspi, MSPI, slot_offset) & 0xff;
>> +}
>> +
>> +static inline u16 read_rxram_slot_u16(struct bcm_qspi *qspi, int slot)
>> +{
>> +       u32 reg_offset = MSPI_RXRAM;
>> +       u32 lsb_offset = reg_offset + (slot << 3) + 0x4;
>> +       u32 msb_offset = reg_offset + (slot << 3);
>> +
>> +       return (bcm_qspi_read(qspi, MSPI, lsb_offset) & 0xff) |
>> +               ((bcm_qspi_read(qspi, MSPI, msb_offset) & 0xff) << 8);
>> +}
>> +
>> +static void read_from_hw(struct bcm_qspi *qspi, int slots)
>> +{
>> +       struct position p;
>> +       int slot;
>> +
>> +       bcm_qspi_disable_bspi(qspi);
>> +
>> +       if (slots > MSPI_NUM_CDRAM) {
>> +               /* should never happen */
>> +               dev_err(&qspi->pdev->dev, "%s: too many slots!\n",
>> __func__);
>> +               return;
>> +       }
>> +
>> +       p = qspi->pos;
>> +
>> +       for (slot = 0; slot < slots; slot++) {
>> +               if (p.trans->bits_per_word <= 8) {
>> +                       u8 *buf = p.trans->rx_buf;
>> +
>> +                       if (buf)
>> +                               buf[p.byte] = read_rxram_slot_u8(qspi,
>> slot);
>> +                       DBG("RD %02x\n", buf ? buf[p.byte] : 0xff);
>> +               } else {
>> +                       u16 *buf = p.trans->rx_buf;
>> +
>> +                       if (buf)
>> +                               buf[p.byte / 2] =
>> read_rxram_slot_u16(qspi,
>> +
>> slot);
>> +                       DBG("RD %04x\n", buf ? buf[p.byte] : 0xffff);
>> +               }
>> +
>> +               find_next_byte(qspi, &p, FNB_BREAK_NONE);
>> +       }
>> +
>> +       qspi->pos = p;
>> +}
>> +
>> +static inline void write_txram_slot_u8(struct bcm_qspi *qspi, int slot,
>> +               u8 val)
>> +{
>> +       u32 reg_offset = MSPI_TXRAM + (slot << 3);
>> +
>> +       /* mask out reserved bits */
>> +       bcm_qspi_write(qspi, MSPI, reg_offset, val);
>> +}
>> +
>> +static inline void write_txram_slot_u16(struct bcm_qspi *qspi, int slot,
>> +               u16 val)
>> +{
>> +       u32 reg_offset = MSPI_TXRAM;
>> +       u32 msb_offset = reg_offset + (slot << 3);
>> +       u32 lsb_offset = reg_offset + (slot << 3) + 0x4;
>> +
>> +       bcm_qspi_write(qspi, MSPI, msb_offset, (val >> 8));
>> +       bcm_qspi_write(qspi, MSPI, lsb_offset, (val & 0xff));
>> +}
>> +
>> +static inline u32 read_cdram_slot(struct bcm_qspi *qspi, int slot)
>> +{
>> +       return bcm_qspi_read(qspi, MSPI, MSPI_CDRAM + (slot << 2));
>> +}
>> +
>> +static inline void write_cdram_slot(struct bcm_qspi *qspi, int slot, u32
>> val)
>> +{
>> +       bcm_qspi_write(qspi, MSPI, (MSPI_CDRAM + (slot << 2)), val);
>> +}
>> +
>> +/* Return number of slots written */
>> +static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spidev)
>> +{
>> +       struct position p;
>> +       int slot = 0, fnb = 0;
>> +       u32 mspi_cdram = 0;
>> +
>> +       bcm_qspi_disable_bspi(qspi);
>> +       p = qspi->pos;
>> +       bcm_qspi_update_parms(qspi, spidev, p.trans, PARMS_OVERRIDE);
>> +
>> +       /* Run until end of transfer or reached the max data */
>> +       while (!fnb && slot < MSPI_NUM_CDRAM) {
>> +               if (p.trans->bits_per_word <= 8) {
>> +                       const u8 *buf = p.trans->tx_buf;
>> +                       u8 val = buf ? buf[p.byte] : 0xff;
>> +
>> +                       write_txram_slot_u8(qspi, slot, val);
>> +                       DBG("WR %02x\n", val);
>> +               } else {
>> +                       const u16 *buf = p.trans->tx_buf;
>> +                       u16 val = buf ? buf[p.byte / 2] : 0xffff;
>> +
>> +                       write_txram_slot_u16(qspi, slot, val);
>> +                       DBG("WR %04x\n", val);
>> +               }
>> +               mspi_cdram = MSPI_CDRAM_CONT_BIT;
>> +               mspi_cdram |= (~(1 << spidev->chip_select) &
>> +                              MSPI_CDRAM_PCS);
>> +               mspi_cdram |= ((p.trans->bits_per_word <= 8) ? 0 :
>> +                               MSPI_CDRAM_BITSE_BIT);
>> +
>> +               write_cdram_slot(qspi, slot, mspi_cdram);
>> +
>> +               /* NOTE: This can update p.trans */
>> +               fnb = find_next_byte(qspi, &p, FNB_BREAK_TX);
>> +               slot++;
>> +       }
>> +       if (!slot) {
>> +               dev_err(&qspi->pdev->dev, "%s: no data to send?",
>> __func__);
>> +               goto done;
>> +       }
>> +
>> +       /* in TX mode, need to pause for a delay or CS change */
>> +       if (fnb & FNB_BREAK_CS_CHANGE)
>> +               qspi->cs_change = 1;
>> +       if (fnb & FNB_BREAK_DELAY)
>> +               qspi->next_udelay = p.trans->delay_usecs;
>> +
>> +       DBG("submitting %d slots\n", slot);
>> +       bcm_qspi_write(qspi, MSPI, MSPI_NEWQP, 0);
>> +       bcm_qspi_write(qspi, MSPI, MSPI_ENDQP, slot - 1);
>> +
>> +       /* deassert CS on the final byte */
>> +       if (fnb & FNB_BREAK_DESELECT) {
>> +               mspi_cdram = read_cdram_slot(qspi, slot - 1) &
>> +                       ~MSPI_CDRAM_CONT_BIT;
>> +               write_cdram_slot(qspi, slot - 1, mspi_cdram);
>> +       }
>> +
>> +       if (has_bspi(qspi))
>> +               bcm_qspi_write(qspi, MSPI, MSPI_WRITE_LOCK, 1);
>> +
>> +       /* Must flush previous writes before starting MSPI operation */
>> +       mb();
>> +       /* Set cont | spe | spifie */
>> +       bcm_qspi_write(qspi, MSPI, MSPI_SPCR2, 0xe0);
>> +       qspi->state = STATE_RUNNING;
>> +
>> +done:
>> +       return slot;
>> +}
>> +
>> +static void hw_stop(struct bcm_qspi *qspi)
>> +{
>> +       if (has_bspi(qspi))
>> +               bcm_qspi_write(qspi, MSPI, MSPI_WRITE_LOCK, 0);
>> +       qspi->state = STATE_IDLE;
>> +}
>> +
>> +/* BSPI helpers */
>> +static int bcm_qspi_emulate_flash_read(struct bcm_qspi *qspi,
>> +                              struct spi_device *spi, struct spi_transfer
>> *t)
>> +{
>> +       u32 addr, len, len_words;
>> +       u8 *buf;
>> +       int idx;
>> +       struct spi_transfer *trans;
>> +       int ret = 0;
>> +       int retry = 3;
>> +       unsigned long timeo = msecs_to_jiffies(100);
>> +
>> +       if (bcm_qspi_bspi_ver_three(qspi))
>> +               if (bcm_qspi_is_4_byte_mode(qspi))
>> +                       return -1;
>> +
>> +       bcm_qspi_chip_select(qspi, spi->chip_select);
>> +       /* first transfer - OPCODE_READ + {3,4}-byte address */
>> +       trans = t;
>> +       buf = (void *)trans->tx_buf;
>> +
>> +       if (!buf) {
>> +               ret = -EIO;
>> +               goto out;
>> +       }
>> +
>> +       idx = 1;
>> +       if (bcm_qspi_bspi_ver_three(qspi) == false) {
>> +               if (bcm_qspi_is_4_byte_mode(qspi))
>> +                       addr = buf[idx++] << 24;
>> +               else
>> +                       addr = 0;
>> +               bcm_qspi_write(qspi, BSPI,
>> +                              BSPI_BSPI_FLASH_UPPER_ADDR_BYTE, addr);
>> +       }
>> +
>> +       addr = (buf[idx] << 16) | (buf[idx+1] << 8) | buf[idx+2];
>> +
>> +       /*
>> +        * when using override mode we need to send
>> +        * the upper address byte to mspi
>> +        */
>> +       if (qspi->xfer_mode.flex_mode == false)
>> +               addr |= bcm_qspi_read(qspi, BSPI,
>> +                                     BSPI_BSPI_FLASH_UPPER_ADDR_BYTE);
>> +
>> +       /* second transfer - read result into buffer */
>> +       trans = list_entry(t->transfer_list.next, struct spi_transfer,
>> +               transfer_list);
>> +       buf = (void *)trans->rx_buf;
>> +
>> +       if (!buf)  {
>> +               ret = -EIO;
>> +               goto out;
>> +       }
>> +
>> +       len = trans->len;
>> +       if (bcm_qspi_bspi_ver_three(qspi) == true) {
>> +               /*
>> +                * The address coming into this function is a raw flash
>> offset.
>> +                * But for BSPI <= V3, we need to convert it to a remapped
>> BSPI
>> +                * address. If it crosses a 4MB boundary, just revert back
>> to
>> +                * using MSPI.
>> +                */
>> +               addr = (addr + 0xc00000) & 0xffffff;
>> +
>> +               if (ADDR_TO_4MBYTE_SEGMENT(addr) ^
>> +                   ADDR_TO_4MBYTE_SEGMENT(addr + len - 1)) {
>> +                       ret = -1;
>> +                       goto out;
>> +               }
>> +       }
>> +
>> +       /* non-aligned and very short transfers are handled by MSPI */
>> +       if (unlikely(!DWORD_ALIGNED(addr) ||
>> +                    !DWORD_ALIGNED(buf) ||
>> +                    len < sizeof(u32))) {
>> +               ret = -1;
>> +               goto out;
>> +       }
>> +
>> +retry:
>> +       reinit_completion(&qspi->bspi_done);
>> +       bcm_qspi_enable_bspi(qspi);
>> +       len_words = (len + 3) >> 2;
>> +       qspi->bspi_xfer_status = 0;
>> +       qspi->bspi_xfer = trans;
>> +       qspi->bspi_xfer_idx = 0;
>> +       qspi->bspi_xfer_len = len;
>> +       qspi->actual_length = idx + 4 + trans->len;
>> +       DBG("bspi xfr addr 0x%x len 0x%x", addr, len);
>> +
>> +       bcm_qspi_write(qspi, BSPI, BSPI_RAF_START_ADDR, addr);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_RAF_NUM_WORDS, len_words);
>> +       bcm_qspi_write(qspi, BSPI, BSPI_RAF_WATERMARK, 0);
>> +       bcm_qspi_clear_interrupt(qspi, QSPI_INTERRUPTS_ALL);
>> +       bcm_qspi_enable_interrupt(qspi, BSPI_LR_INTERRUPTS_ALL);
>> +       bcm_qspi_lr_start(qspi);
>> +       /* Must flush previous writes before starting BSPI operation */
>> +       mb();
>> +
>> +       if (!wait_for_completion_timeout(&qspi->bspi_done, timeo)) {
>> +               if (retry--)
>> +                       goto retry;
>> +
>> +               dev_err(&qspi->pdev->dev, "timeout waiting for BSPI\n");
>> +               ret = -ETIMEDOUT;
>> +       }
>> +
>> +out:
>> +       return ret;
>> +}
>> +
>> +static bool bcm_qspi_bspi_read(struct bcm_qspi *qspi, struct spi_device
>> *spidev,
>> +                              struct spi_transfer *trans)
>> +{
>> +       bool ret = false;
>> +       u32 nbits = SPI_NBITS_SINGLE;
>> +
>> +       if (trans && trans->len && trans->tx_buf) {
>> +               u8 command = ((u8 *)trans->tx_buf)[0];
>> +
>> +               if (trans->rx_nbits)
>> +                       nbits = trans->rx_nbits;
>> +
>> +               switch (command) {
>> +               case SPINOR_OP_READ4_FAST:
>> +                       if (!bcm_qspi_is_4_byte_mode(qspi))
>> +                               bcm_qspi_bspi_set_mode(qspi, nbits,
>> +                                              BSPI_ADDRLEN_4BYTES, -1);
>> +                               /* fall through */
>> +               case SPINOR_OP_READ_FAST:
>> +                       if (!bcm_qspi_emulate_flash_read(qspi, spidev,
>> trans))
>> +                               ret = true;
>> +                       break;
>> +               case OPCODE_QIOR_4B:
>> +               case SPINOR_OP_READ_1_1_4:
>> +               case SPINOR_OP_READ4_1_1_4:
>> +                       if (!bcm_qspi_emulate_flash_read(qspi, spidev,
>> trans))
>> +                               ret = true;
>> +                       break;
>> +               default:
>> +                       break;
>> +
>> +               }
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static void bcm_qspi_set_read_mode(struct bcm_qspi *qspi,
>> +                                  struct spi_device *spidev,
>> +                                  struct spi_transfer *trans)
>> +{
>> +       u32 nbits = SPI_NBITS_SINGLE;
>> +
>> +       if (trans && trans->len && trans->tx_buf) {
>> +               u8 command = ((u8 *)trans->tx_buf)[0];
>> +
>> +               if (trans->rx_nbits)
>> +                       nbits = trans->rx_nbits;
>> +
>> +               switch (command) {
>> +               case SPINOR_OP_EN4B:
>> +                       DBG("EN4B MODE\n");
>> +                       bcm_qspi_bspi_set_mode(qspi, nbits,
>> +                                       BSPI_ADDRLEN_4BYTES, -1);
>> +                       break;
>> +               case SPINOR_OP_EX4B:
>> +                       DBG("EX4B MODE\n");
>> +                       bcm_qspi_bspi_set_mode(qspi, nbits,
>> +                                       BSPI_ADDRLEN_3BYTES, -1);
>> +                       break;
>> +               case SPINOR_OP_BRWR:
>> +                       {
>> +                               u8 enable = ((u8 *)trans->tx_buf)[1];
>> +
>> +                               DBG(" %s 4-BYTE MODE\n",
>> +                                       enable ? "ENABLE" : "DISABLE");
>> +                               bcm_qspi_bspi_set_mode(qspi, nbits,
>> +                                       enable ? BSPI_ADDRLEN_4BYTES :
>> +                                       BSPI_ADDRLEN_3BYTES, -1);
>> +                       }
>> +                       break;
>> +               default:
>> +                       break;
>> +               }
>> +       }
>> +}
>> +
>> +static int bcm_qspi_transfer_one(struct spi_master *master,
>> +                  struct spi_device *spidev, struct spi_transfer *trans)
>> +{
>> +       struct bcm_qspi *qspi = spi_master_get_devdata(master);
>> +       int slots;
>> +       unsigned long timeo = msecs_to_jiffies(100);
>> +
>> +       qspi->pos.trans = trans;
>> +       qspi->pos.byte = 0;
>> +
>> +       while (qspi->pos.byte < trans->len) {
>> +               reinit_completion(&qspi->mspi_done);
>> +
>> +               slots = write_to_hw(qspi, spidev);
>> +               if (!wait_for_completion_timeout(&qspi->mspi_done, timeo))
>> {
>> +                       dev_err(&qspi->pdev->dev, "timeout waiting for
>> MSPI\n");
>> +                       return -ETIMEDOUT;
>> +               }
>> +
>> +               if (qspi->next_udelay) {
>> +                       udelay(qspi->next_udelay);
>> +                       qspi->next_udelay = 0;
>> +               }
>> +
>> +               read_from_hw(qspi, slots);
>> +               if (qspi->cs_change) {
>> +                       udelay(10);
>> +                       qspi->cs_change = 0;
>> +               }
>> +       }
>> +
>> +       if (spi_transfer_is_last(master, trans))
>> +               hw_stop(qspi);
>> +
>> +       return 0;
>> +}
>> +
>> +static int bcm_qspi_mspi_transfer(struct spi_master *master,
>> +                                 struct spi_message *msg)
>> +{
>> +       struct spi_transfer *t;
>> +       int ret = 0;
>> +
>> +       list_for_each_entry(t, &msg->transfers, transfer_list) {
>> +               ret = bcm_qspi_transfer_one(master, msg->spi, t);
>> +               if (ret < 0)
>> +                       break;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static int bcm_qspi_transfer_one_message(struct spi_master *master,
>> +                struct spi_message *msg)
>> +{
>> +       struct bcm_qspi *qspi = spi_master_get_devdata(master);
>> +       struct spi_transfer *t, *first = NULL;
>> +       int ret = 0, cs = 0;
>> +       struct spi_device *spidev = msg->spi;
>> +       bool try_bspi = false;
>> +       unsigned int n_transfers = 0, total_len = 0;
>> +
>> +       msg->status = 0;
>> +       msg->actual_length = 0;
>> +
>> +       list_for_each_entry(t, &msg->transfers, transfer_list) {
>> +               if (!first)
>> +                       first = t;
>> +
>> +               n_transfers++;
>> +               total_len += t->len;
>> +
>> +               if (n_transfers == 2 && !first->rx_buf && !t->tx_buf)
>> +                       try_bspi = true;
>> +
>> +               if (t->cs_change ||
>> +                   list_is_last(&t->transfer_list, &msg->transfers)) {
>> +#ifdef CONFIG_BRCM_MSPI_ONLY
>> +                       try_bspi = false;
>> +#endif
>> +                       cs = bcm_qspi_bspi_cs(qspi, spidev->chip_select);
>> +                       bcm_qspi_set_read_mode(qspi, spidev, first);
>> +
>> +                       /* if this is a data read try to use bspi transfer
>> */
>> +                       if (try_bspi && cs)
>> +                               try_bspi = bcm_qspi_bspi_read(qspi,
>> spidev,
>> +                                                             first);
>> +                       else
>> +                               try_bspi = false;
>> +
>> +                       DBG("num transfers %d try_bspi %s\n", n_transfers,
>> +                           try_bspi ? "true" : "false");
>> +
>> +                       if (try_bspi == false)
>> +                               /* this is mspi transfer */
>> +                               ret = bcm_qspi_mspi_transfer(master, msg);
>> +
>> +                       if (ret < 0)
>> +                               goto exit;
>> +
>> +                       if (try_bspi)
>> +                               msg->actual_length = qspi->actual_length;
>> +                       else
>> +                               msg->actual_length += total_len;
>> +
>> +                       first = NULL;
>> +                       n_transfers = 0;
>> +                       total_len = 0;
>> +                       try_bspi = false;
>> +               }
>> +       }
>> +
>> +exit:
>> +       msg->status = ret;
>> +       spi_finalize_current_message(master);
>> +       return ret;
>> +}
>> +
>> +static void bcm_qspi_cleanup(struct spi_device *spi)
>> +{
>> +       struct bcm_qspi_parms *xp = spi_get_ctldata(spi);
>> +
>> +       kfree(xp);
>> +}
>> +
>> +static irqreturn_t bcm_qspi_mspi_l2_isr(int irq, void *dev_id)
>> +{
>> +       struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
>> +       struct bcm_qspi *qspi = qspi_dev_id->dev;
>> +       u32 status = bcm_qspi_read(qspi, MSPI, MSPI_MSPI_STATUS);
>> +
>> +       if (status & MSPI_MSPI_STATUS_SPIF) {
>> +               /* clear interrupt */
>> +               status &= ~MSPI_MSPI_STATUS_SPIF;
>> +               bcm_qspi_write(qspi, INTR, MSPI_MSPI_STATUS, status);
>> +               bcm_qspi_clear_interrupt(qspi, INTR_MSPI_DONE_MASK);
>> +               complete(&qspi->mspi_done);
>> +               return IRQ_HANDLED;
>> +       } else
>> +               return IRQ_NONE;
>> +}
>> +
>> +static irqreturn_t bcm_qspi_bspi_lr_l2_isr(int irq, void *dev_id)
>> +{
>> +       struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
>> +       struct bcm_qspi *qspi = qspi_dev_id->dev;
>> +
>> +       if (qspi->bspi_enabled && qspi->bspi_xfer) {
>> +               bcm_qspi_bspi_lr_data_read(qspi);
>> +               if (qspi->bspi_xfer_len == 0) {
>> +                       qspi->bspi_xfer = NULL;
>> +                       bcm_qspi_disable_interrupt(qspi,
>> +
>> BSPI_LR_INTERRUPTS_ALL);
>> +                       if (qspi->bspi_xfer_status)
>> +                               bcm_qspi_lr_clear(qspi);
>> +                       else
>> +                               bcm_qspi_flush_prefetch_buffers(qspi);
>> +
>> +                       complete(&qspi->bspi_done);
>> +               }
>> +               bcm_qspi_clear_interrupt(qspi, BSPI_LR_INTERRUPTS_ALL);
>> +               return IRQ_HANDLED;
>> +       }
>> +
>> +       return IRQ_NONE;
>> +}
>> +
>> +static irqreturn_t bcm_qspi_bspi_lr_err_l2_isr(int irq, void *dev_id)
>> +{
>> +       struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
>> +       struct bcm_qspi *qspi = qspi_dev_id->dev;
>> +
>> +       if (qspi_dev_id->irqp->mask & BSPI_LR_INTERRUPTS_ERROR) {
>> +               dev_err(&qspi->pdev->dev, "INT error\n");
>> +               qspi->bspi_xfer_status = -EIO;
>> +               bcm_qspi_clear_interrupt(qspi, BSPI_LR_INTERRUPTS_ERROR);
>> +               complete(&qspi->bspi_done);
>> +               return IRQ_HANDLED;
>> +       }
>> +
>> +       return IRQ_NONE;
>> +}
>> +
>> +static irqreturn_t bcm_qspi_l1_isr(int irq, void *dev_id)
>> +{
>> +       struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
>> +       struct bcm_qspi *qspi = qspi_dev_id->dev;
>> +       u32 status = bcm_qspi_read_l2int_status(qspi);
>> +       irqreturn_t ret = IRQ_NONE;
>> +
>> +       if (status & MSPI_INTERRUPTS_ALL)
>> +               ret = bcm_qspi_mspi_l2_isr(irq, dev_id);
>> +       else if (status & BSPI_LR_INTERRUPTS_DATA)
>> +               ret = bcm_qspi_bspi_lr_l2_isr(irq, dev_id);
>> +       else if (status & BSPI_LR_INTERRUPTS_ERROR)
>> +               ret = bcm_qspi_bspi_lr_err_l2_isr(irq, dev_id);
>> +
>> +       return ret;
>> +}
>> +
>> +static const struct bcm_qspi_irq qspi_irq_tab[] = {
>> +       {
>> +               .irq_name = "spi_lr_fullness_reached",
>> +               .irq_handler = bcm_qspi_bspi_lr_l2_isr,
>> +               .mask = INTR_BSPI_LR_FULLNESS_REACHED_MASK,
>> +       },
>> +       {
>> +               .irq_name = "spi_lr_session_aborted",
>> +               .irq_handler = bcm_qspi_bspi_lr_err_l2_isr,
>> +               .mask = INTR_BSPI_LR_SESSION_ABORTED_MASK,
>> +       },
>> +       {
>> +               .irq_name = "spi_lr_impatient",
>> +               .irq_handler = bcm_qspi_bspi_lr_err_l2_isr,
>> +               .mask = INTR_BSPI_LR_IMPATIENT_MASK,
>> +       },
>> +       {
>> +               .irq_name = "spi_lr_session_done",
>> +               .irq_handler = bcm_qspi_bspi_lr_l2_isr,
>> +               .mask = INTR_BSPI_LR_SESSION_DONE_MASK,
>> +       },
>> +       {
>> +               .irq_name = "spi_lr_overread",
>> +               .irq_handler = bcm_qspi_bspi_lr_err_l2_isr,
>> +               .mask = INTR_BSPI_LR_OVERREAD_MASK,
>> +       },
>> +       {
>> +               .irq_name = "mspi_done",
>> +               .irq_handler = bcm_qspi_mspi_l2_isr,
>> +               .mask = INTR_MSPI_DONE_MASK,
>> +       },
>> +       {
>> +               .irq_name = "mspi_halted",
>> +               .irq_handler = bcm_qspi_mspi_l2_isr,
>> +               .mask = INTR_MSPI_HALTED_MASK,
>> +       },
>> +       {
>> +               /* single muxed L1 interrupt source */
>> +               .irq_name = "spi_l1_intr",
>> +               .irq_handler = bcm_qspi_l1_isr,
>> +               .mask = QSPI_INTERRUPTS_ALL,
>> +       },
>> +};
>> +
>> +static int bcm_qspi_simple_transaction(struct bcm_qspi *qspi,
>> +       const void *tx_buf, int tx_len, void *rx_buf, int rx_len)
>> +{
>> +
>> +       struct bcm_qspi_parms *xp = &qspi->last_parms;
>> +       struct spi_message m;
>> +       struct spi_transfer t_tx, t_rx;
>> +       struct spi_device spi;
>> +       int ret;
>> +
>> +       memset(&spi, 0, sizeof(spi));
>> +       spi.max_speed_hz = xp->speed_hz;
>> +       spi.chip_select = xp->chip_select;
>> +       spi.mode = xp->mode;
>> +       spi.bits_per_word = xp->bits_per_word;
>> +       spi.master = qspi->master;
>> +
>> +       spi_message_init(&m);
>> +       m.spi = &spi;
>> +
>> +       memset(&t_tx, 0, sizeof(t_tx));
>> +       memset(&t_rx, 0, sizeof(t_rx));
>> +       t_tx.tx_buf = tx_buf;
>> +       t_tx.len = tx_len;
>> +       t_rx.rx_buf = rx_buf;
>> +       t_rx.len = rx_len;
>> +
>> +       ret = bcm_qspi_mspi_transfer(spi.master, &m);
>> +
>> +       return ret;
>> +}
>> +
>> +static void bcm_qspi_hw_init(struct bcm_qspi *qspi)
>> +{
>> +       u32 val = 0;
>> +       struct bcm_qspi_parms default_parms;
>> +
>> +       bcm_qspi_write(qspi, MSPI, MSPI_SPCR1_LSB, 0);
>> +       bcm_qspi_write(qspi, MSPI, MSPI_SPCR1_MSB, 0);
>> +       bcm_qspi_write(qspi, MSPI, MSPI_NEWQP, 0);
>> +       bcm_qspi_write(qspi, MSPI, MSPI_ENDQP, 0);
>> +       bcm_qspi_write(qspi, MSPI, MSPI_SPCR2, 0x20);
>> +
>> +       default_parms.chip_select = 0;
>> +       default_parms.mode = SPI_MODE_3;
>> +       default_parms.bits_per_word = 8;
>> +       of_property_read_u32(qspi->pdev->dev.of_node, "clock-frequency",
>> &val);
>> +       if (val > 0) {
>> +               default_parms.speed_hz = val;
>> +               bcm_qspi_hw_set_parms(qspi, &default_parms);
>> +       } else {
>> +               bcm_qspi_hw_set_parms(qspi, &bcm_qspi_default_parms_cs0);
>> +       }
>> +
>> +       if (!qspi->base[BSPI])
>> +               return;



-- 
Kamal Dasu
Principal Engineer | Broadcom Ltd. 200 Brickstone Sq Andover | 978-719-1405
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
