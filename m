From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v3 5/9] spi: bcm-qspi: Implement the spi_mem interface
Date: Tue, 24 Apr 2018 11:19:24 -0400
Message-ID: <CAC=U0a0+=rmG49B5w-EobDvc1UF5-M5FDP+NcssKgHOTiE7TtA@mail.gmail.com>
References: <20180422183522.11118-1-boris.brezillon@bootlin.com>
 <20180422183522.11118-6-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-spi <linux-spi@vger.kernel.org>, Peter Pan <peterpansjtu@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180422183522.11118-6-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Sun, Apr 22, 2018 at 2:35 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> The spi_mem interface is meant to replace the ->spi_flash_read() one.
> Implement the ->exec_op() method to ease removal of the old interface.
>
> Not that ->spi_flash_read() is now implemented as a wrapper around the
> new bcm_qspi_exec_mem_op() function so that we can easily get rid of
> it when ->spi_flash_read() is removed.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
Tested-by: Kamal Dasu <kdasu.kdev@gmail.com>

> ---
> Changes in v3:
> - none
>
> Changes in v2:
> - include spi-mem.h
> - treat op->addr.val differently since it's now an u64
> ---
>  drivers/spi/spi-bcm-qspi.c | 190 ++++++++++++++++++++++++++-------------------
>  1 file changed, 111 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
> index 1596d35498c5..9f94268a68b5 100644
> --- a/drivers/spi/spi-bcm-qspi.c
> +++ b/drivers/spi/spi-bcm-qspi.c
> @@ -30,6 +30,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
>  #include "spi-bcm-qspi.h"
> @@ -215,10 +216,10 @@ struct bcm_qspi {
>         int bspi_maj_rev;
>         int bspi_min_rev;
>         int bspi_enabled;
> -       struct spi_flash_read_message *bspi_rf_msg;
> -       u32 bspi_rf_msg_idx;
> -       u32 bspi_rf_msg_len;
> -       u32 bspi_rf_msg_status;
> +       const struct spi_mem_op *bspi_rf_op;
> +       u32 bspi_rf_op_idx;
> +       u32 bspi_rf_op_len;
> +       u32 bspi_rf_op_status;
>         struct bcm_xfer_mode xfer_mode;
>         u32 s3_strap_override_ctrl;
>         bool bspi_mode;
> @@ -313,26 +314,26 @@ static inline void bcm_qspi_bspi_lr_clear(struct bcm_qspi *qspi)
>
>  static void bcm_qspi_bspi_lr_data_read(struct bcm_qspi *qspi)
>  {
> -       u32 *buf = (u32 *)qspi->bspi_rf_msg->buf;
> +       u32 *buf = (u32 *)qspi->bspi_rf_op->data.buf.in;
>         u32 data = 0;
>
> -       dev_dbg(&qspi->pdev->dev, "xfer %p rx %p rxlen %d\n", qspi->bspi_rf_msg,
> -               qspi->bspi_rf_msg->buf, qspi->bspi_rf_msg_len);
> +       dev_dbg(&qspi->pdev->dev, "xfer %p rx %p rxlen %d\n", qspi->bspi_rf_op,
> +               qspi->bspi_rf_op->data.buf.in, qspi->bspi_rf_op_len);
>         while (!bcm_qspi_bspi_lr_is_fifo_empty(qspi)) {
>                 data = bcm_qspi_bspi_lr_read_fifo(qspi);
> -               if (likely(qspi->bspi_rf_msg_len >= 4) &&
> +               if (likely(qspi->bspi_rf_op_len >= 4) &&
>                     IS_ALIGNED((uintptr_t)buf, 4)) {
> -                       buf[qspi->bspi_rf_msg_idx++] = data;
> -                       qspi->bspi_rf_msg_len -= 4;
> +                       buf[qspi->bspi_rf_op_idx++] = data;
> +                       qspi->bspi_rf_op_len -= 4;
>                 } else {
>                         /* Read out remaining bytes, make sure*/
> -                       u8 *cbuf = (u8 *)&buf[qspi->bspi_rf_msg_idx];
> +                       u8 *cbuf = (u8 *)&buf[qspi->bspi_rf_op_idx];
>
>                         data = cpu_to_le32(data);
> -                       while (qspi->bspi_rf_msg_len) {
> +                       while (qspi->bspi_rf_op_len) {
>                                 *cbuf++ = (u8)data;
>                                 data >>= 8;
> -                               qspi->bspi_rf_msg_len--;
> +                               qspi->bspi_rf_op_len--;
>                         }
>                 }
>         }
> @@ -349,14 +350,12 @@ static void bcm_qspi_bspi_set_xfer_params(struct bcm_qspi *qspi, u8 cmd_byte,
>  }
>
>  static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi,
> -                                      struct spi_flash_read_message *msg,
> -                                      int hp)
> +                                      const struct spi_mem_op *op, int hp)
>  {
>         int bpc = 0, bpp = 0;
> -       u8 command = msg->read_opcode;
> -       int width  = msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;
> -       int addrlen = msg->addr_width;
> -       int addr_nbits = msg->addr_nbits ? msg->addr_nbits : SPI_NBITS_SINGLE;
> +       u8 command = op->cmd.opcode;
> +       int width  = op->cmd.buswidth ? op->cmd.buswidth : SPI_NBITS_SINGLE;
> +       int addrlen = op->addr.nbytes * 8;
>         int flex_mode = 1;
>
>         dev_dbg(&qspi->pdev->dev, "set flex mode w %x addrlen %x hp %d\n",
> @@ -365,7 +364,7 @@ static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi,
>         if (addrlen == BSPI_ADDRLEN_4BYTES)
>                 bpp = BSPI_BPP_ADDR_SELECT_MASK;
>
> -       bpp |= msg->dummy_bytes * (8/addr_nbits);
> +       bpp |= (op->dummy.nbytes * 8) / op->dummy.buswidth;
>
>         switch (width) {
>         case SPI_NBITS_SINGLE:
> @@ -397,11 +396,10 @@ static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi,
>  }
>
>  static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi,
> -                                     struct spi_flash_read_message *msg,
> -                                     int hp)
> +                                     const struct spi_mem_op *op, int hp)
>  {
> -       int width = msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;
> -       int addrlen = msg->addr_width;
> +       int width = op->data.buswidth ? op->data.buswidth : SPI_NBITS_SINGLE;
> +       int addrlen = op->addr.nbytes;
>         u32 data = bcm_qspi_read(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL);
>
>         dev_dbg(&qspi->pdev->dev, "set override mode w %x addrlen %x hp %d\n",
> @@ -437,17 +435,17 @@ static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi,
>         /* set the override mode */
>         data |= BSPI_STRAP_OVERRIDE_CTRL_OVERRIDE;
>         bcm_qspi_write(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL, data);
> -       bcm_qspi_bspi_set_xfer_params(qspi, msg->read_opcode, 0, 0, 0);
> +       bcm_qspi_bspi_set_xfer_params(qspi, op->cmd.opcode, 0, 0, 0);
>
>         return 0;
>  }
>
>  static int bcm_qspi_bspi_set_mode(struct bcm_qspi *qspi,
> -                                 struct spi_flash_read_message *msg, int hp)
> +                                 const struct spi_mem_op *op, int hp)
>  {
>         int error = 0;
> -       int width = msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;
> -       int addrlen = msg->addr_width;
> +       int width = op->data.buswidth ? op->data.buswidth : SPI_NBITS_SINGLE;
> +       int addrlen = op->addr.nbytes;
>
>         /* default mode */
>         qspi->xfer_mode.flex_mode = true;
> @@ -460,12 +458,12 @@ static int bcm_qspi_bspi_set_mode(struct bcm_qspi *qspi,
>                 if (val & mask || qspi->s3_strap_override_ctrl & mask) {
>                         qspi->xfer_mode.flex_mode = false;
>                         bcm_qspi_write(qspi, BSPI, BSPI_FLEX_MODE_ENABLE, 0);
> -                       error = bcm_qspi_bspi_set_override(qspi, msg, hp);
> +                       error = bcm_qspi_bspi_set_override(qspi, op, hp);
>                 }
>         }
>
>         if (qspi->xfer_mode.flex_mode)
> -               error = bcm_qspi_bspi_set_flex_mode(qspi, msg, hp);
> +               error = bcm_qspi_bspi_set_flex_mode(qspi, op, hp);
>
>         if (error) {
>                 dev_warn(&qspi->pdev->dev,
> @@ -794,19 +792,20 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
>         return slot;
>  }
>
> -static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
> -                                   struct spi_flash_read_message *msg)
> +static int bcm_qspi_bspi_exec_mem_op(struct spi_device *spi,
> +                                    const struct spi_mem_op *op)
>  {
>         struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
> -       u32 addr = 0, len, rdlen, len_words;
> +       u32 addr = 0, len, rdlen, len_words, from = 0;
>         int ret = 0;
>         unsigned long timeo = msecs_to_jiffies(100);
>         struct bcm_qspi_soc_intc *soc_intc = qspi->soc_intc;
>
>         if (bcm_qspi_bspi_ver_three(qspi))
> -               if (msg->addr_width == BSPI_ADDRLEN_4BYTES)
> +               if (op->addr.nbytes == BSPI_ADDRLEN_4BYTES)
>                         return -EIO;
>
> +       from = op->addr.val;
>         bcm_qspi_chip_select(qspi, spi->chip_select);
>         bcm_qspi_write(qspi, MSPI, MSPI_WRITE_LOCK, 0);
>
> @@ -815,15 +814,15 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
>          * the upper address byte to bspi
>          */
>         if (bcm_qspi_bspi_ver_three(qspi) == false) {
> -               addr = msg->from & 0xff000000;
> +               addr = from & 0xff000000;
>                 bcm_qspi_write(qspi, BSPI,
>                                BSPI_BSPI_FLASH_UPPER_ADDR_BYTE, addr);
>         }
>
>         if (!qspi->xfer_mode.flex_mode)
> -               addr = msg->from;
> +               addr = from;
>         else
> -               addr = msg->from & 0x00ffffff;
> +               addr = from & 0x00ffffff;
>
>         if (bcm_qspi_bspi_ver_three(qspi) == true)
>                 addr = (addr + 0xc00000) & 0xffffff;
> @@ -832,8 +831,8 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
>          * read into the entire buffer by breaking the reads
>          * into RAF buffer read lengths
>          */
> -       len = msg->len;
> -       qspi->bspi_rf_msg_idx = 0;
> +       len = op->data.nbytes;
> +       qspi->bspi_rf_op_idx = 0;
>
>         do {
>                 if (len > BSPI_READ_LENGTH)
> @@ -844,9 +843,9 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
>                 reinit_completion(&qspi->bspi_done);
>                 bcm_qspi_enable_bspi(qspi);
>                 len_words = (rdlen + 3) >> 2;
> -               qspi->bspi_rf_msg = msg;
> -               qspi->bspi_rf_msg_status = 0;
> -               qspi->bspi_rf_msg_len = rdlen;
> +               qspi->bspi_rf_op = op;
> +               qspi->bspi_rf_op_status = 0;
> +               qspi->bspi_rf_op_len = rdlen;
>                 dev_dbg(&qspi->pdev->dev,
>                         "bspi xfr addr 0x%x len 0x%x", addr, rdlen);
>                 bcm_qspi_write(qspi, BSPI, BSPI_RAF_START_ADDR, addr);
> @@ -871,7 +870,6 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
>                 }
>
>                 /* set msg return length */
> -               msg->retlen += rdlen;
>                 addr += rdlen;
>                 len -= rdlen;
>         } while (len);
> @@ -906,61 +904,62 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
>         return 0;
>  }
>
> -static int bcm_qspi_mspi_flash_read(struct spi_device *spi,
> -                                   struct spi_flash_read_message *msg)
> +static int bcm_qspi_mspi_exec_mem_op(struct spi_device *spi,
> +                                    const struct spi_mem_op *op)
>  {
> -       struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
> +       struct spi_master *master = spi->master;
> +       struct bcm_qspi *qspi = spi_master_get_devdata(master);
>         struct spi_transfer t[2];
> -       u8 cmd[6];
> -       int ret;
> +       u8 cmd[6] = { };
> +       int ret, i;
>
>         memset(cmd, 0, sizeof(cmd));
>         memset(t, 0, sizeof(t));
>
>         /* tx */
>         /* opcode is in cmd[0] */
> -       cmd[0] = msg->read_opcode;
> -       cmd[1] = msg->from >> (msg->addr_width * 8 -  8);
> -       cmd[2] = msg->from >> (msg->addr_width * 8 - 16);
> -       cmd[3] = msg->from >> (msg->addr_width * 8 - 24);
> -       cmd[4] = msg->from >> (msg->addr_width * 8 - 32);
> +       cmd[0] = op->cmd.opcode;
> +       for (i = 0; i < op->addr.nbytes; i++)
> +               cmd[1 + i] = op->addr.val >> (8 * (op->addr.nbytes - i - 1));
> +
>         t[0].tx_buf = cmd;
> -       t[0].len = msg->addr_width + msg->dummy_bytes + 1;
> +       t[0].len = op->addr.nbytes + op->dummy.nbytes + 1;
>         t[0].bits_per_word = spi->bits_per_word;
> -       t[0].tx_nbits = msg->opcode_nbits;
> +       t[0].tx_nbits = op->cmd.buswidth;
>         /* lets mspi know that this is not last transfer */
>         qspi->trans_pos.mspi_last_trans = false;
> -       ret = bcm_qspi_transfer_one(spi->master, spi, &t[0]);
> +       ret = bcm_qspi_transfer_one(master, spi, &t[0]);
>
>         /* rx */
>         qspi->trans_pos.mspi_last_trans = true;
>         if (!ret) {
>                 /* rx */
> -               t[1].rx_buf = msg->buf;
> -               t[1].len = msg->len;
> -               t[1].rx_nbits =  msg->data_nbits;
> +               t[1].rx_buf = op->data.buf.in;
> +               t[1].len = op->data.nbytes;
> +               t[1].rx_nbits =  op->data.buswidth;
>                 t[1].bits_per_word = spi->bits_per_word;
> -               ret = bcm_qspi_transfer_one(spi->master, spi, &t[1]);
> +               ret = bcm_qspi_transfer_one(master, spi, &t[1]);
>         }
>
> -       if (!ret)
> -               msg->retlen = msg->len;
> -
>         return ret;
>  }
>
> -static int bcm_qspi_flash_read(struct spi_device *spi,
> -                              struct spi_flash_read_message *msg)
> +static int bcm_qspi_exec_mem_op(struct spi_device *spi,
> +                               const struct spi_mem_op *op)
>  {
>         struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
>         int ret = 0;
>         bool mspi_read = false;
> -       u32 addr, len;
> +       u32 addr = 0, len;
>         u_char *buf;
>
> -       buf = msg->buf;
> -       addr = msg->from;
> -       len = msg->len;
> +       if (!op->data.nbytes || !op->addr.nbytes || op->addr.nbytes > 4 ||
> +           op->data.dir != SPI_MEM_DATA_IN)
> +               return -ENOTSUPP;
> +
> +       buf = op->data.buf.in;
> +       addr = op->addr.val;
> +       len = op->data.nbytes;
>
>         if (bcm_qspi_bspi_ver_three(qspi) == true) {
>                 /*
> @@ -982,12 +981,40 @@ static int bcm_qspi_flash_read(struct spi_device *spi,
>                 mspi_read = true;
>
>         if (mspi_read)
> -               return bcm_qspi_mspi_flash_read(spi, msg);
> +               return bcm_qspi_mspi_exec_mem_op(spi, op);
>
> -       ret = bcm_qspi_bspi_set_mode(qspi, msg, -1);
> +       ret = bcm_qspi_bspi_set_mode(qspi, op, -1);
>
>         if (!ret)
> -               ret = bcm_qspi_bspi_flash_read(spi, msg);
> +               ret = bcm_qspi_bspi_exec_mem_op(spi, op);
> +
> +       return ret;
> +}
> +
> +static int bcm_qspi_exec_mem_op_wrapper(struct spi_mem *mem,
> +                                       const struct spi_mem_op *op)
> +{
> +       return bcm_qspi_exec_mem_op(mem->spi, op);
> +}
> +
> +static int bcm_qspi_flash_read_wrapper(struct spi_device *spi,
> +                                      struct spi_flash_read_message *msg)
> +{
> +       int ret;
> +       struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(msg->read_opcode, 1),
> +                                         SPI_MEM_OP_ADDR(msg->addr_width,
> +                                                         msg->from,
> +                                                         msg->addr_nbits),
> +                                         SPI_MEM_OP_DUMMY(msg->dummy_bytes,
> +                                                          msg->addr_nbits),
> +                                         SPI_MEM_OP_DATA_IN(msg->len,
> +                                                            msg->buf,
> +                                                            msg->data_nbits));
> +
> +       msg->retlen = 0;
> +       ret = bcm_qspi_exec_mem_op(spi, &op);
> +       if (!ret)
> +               msg->retlen = msg->len;
>
>         return ret;
>  }
> @@ -1026,10 +1053,10 @@ static irqreturn_t bcm_qspi_bspi_lr_l2_isr(int irq, void *dev_id)
>         struct bcm_qspi_soc_intc *soc_intc = qspi->soc_intc;
>         u32 status = qspi_dev_id->irqp->mask;
>
> -       if (qspi->bspi_enabled && qspi->bspi_rf_msg) {
> +       if (qspi->bspi_enabled && qspi->bspi_rf_op) {
>                 bcm_qspi_bspi_lr_data_read(qspi);
> -               if (qspi->bspi_rf_msg_len == 0) {
> -                       qspi->bspi_rf_msg = NULL;
> +               if (qspi->bspi_rf_op_len == 0) {
> +                       qspi->bspi_rf_op = NULL;
>                         if (qspi->soc_intc) {
>                                 /* disable soc BSPI interrupt */
>                                 soc_intc->bcm_qspi_int_set(soc_intc, BSPI_DONE,
> @@ -1038,7 +1065,7 @@ static irqreturn_t bcm_qspi_bspi_lr_l2_isr(int irq, void *dev_id)
>                                 status = INTR_BSPI_LR_SESSION_DONE_MASK;
>                         }
>
> -                       if (qspi->bspi_rf_msg_status)
> +                       if (qspi->bspi_rf_op_status)
>                                 bcm_qspi_bspi_lr_clear(qspi);
>                         else
>                                 bcm_qspi_bspi_flush_prefetch_buffers(qspi);
> @@ -1050,7 +1077,7 @@ static irqreturn_t bcm_qspi_bspi_lr_l2_isr(int irq, void *dev_id)
>         }
>
>         status &= INTR_BSPI_LR_SESSION_DONE_MASK;
> -       if (qspi->bspi_enabled && status && qspi->bspi_rf_msg_len == 0)
> +       if (qspi->bspi_enabled && status && qspi->bspi_rf_op_len == 0)
>                 complete(&qspi->bspi_done);
>
>         return IRQ_HANDLED;
> @@ -1063,7 +1090,7 @@ static irqreturn_t bcm_qspi_bspi_lr_err_l2_isr(int irq, void *dev_id)
>         struct bcm_qspi_soc_intc *soc_intc = qspi->soc_intc;
>
>         dev_err(&qspi->pdev->dev, "BSPI INT error\n");
> -       qspi->bspi_rf_msg_status = -EIO;
> +       qspi->bspi_rf_op_status = -EIO;
>         if (qspi->soc_intc)
>                 /* clear soc interrupt */
>                 soc_intc->bcm_qspi_int_ack(soc_intc, BSPI_ERR);
> @@ -1186,6 +1213,10 @@ static void bcm_qspi_hw_uninit(struct bcm_qspi *qspi)
>
>  }
>
> +static const struct spi_controller_mem_ops bcm_qspi_mem_ops = {
> +       .exec_op = bcm_qspi_exec_mem_op_wrapper,
> +};
> +
>  static const struct of_device_id bcm_qspi_of_match[] = {
>         { .compatible = "brcm,spi-bcm-qspi" },
>         {},
> @@ -1228,7 +1259,8 @@ int bcm_qspi_probe(struct platform_device *pdev,
>         master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_RX_DUAL | SPI_RX_QUAD;
>         master->setup = bcm_qspi_setup;
>         master->transfer_one = bcm_qspi_transfer_one;
> -       master->spi_flash_read = bcm_qspi_flash_read;
> +       master->spi_flash_read = bcm_qspi_flash_read_wrapper;
> +       master->mem_ops = &bcm_qspi_mem_ops;
>         master->cleanup = bcm_qspi_cleanup;
>         master->dev.of_node = dev->of_node;
>         master->num_chipselect = NUM_CHIPSELECT;
> --
> 2.14.1
>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
