From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [RFC PATCH 5/6] mtd: spi-nor: Use the spi_mem_xx() API
Date: Mon, 11 Jun 2018 09:35:55 +0200
Message-ID: <20180611093555.50f8682d@bbrezillon>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
 <20180205232120.5851-6-boris.brezillon@bootlin.com>
 <DB6PR0402MB28380B10F866F08E0CDC6B6999780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
 Vignesh R <vigneshr@ti.com>, Kamal Dasu <kdasu.kdev@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Peter Pan <peterpansjtu@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Sourav Poddar <sourav.poddar@ti.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <DB6PR0402MB28380B10F866F08E0CDC6B6999780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
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

Hi Yogesh,

On Mon, 11 Jun 2018 06:25:02 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:


>  static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
>  			    const u_char *buf)
>  {
>  	struct m25p *flash = nor->priv;
> -	struct spi_device *spi = flash->spi;
> -	unsigned int inst_nbits, addr_nbits, data_nbits, data_idx;
> -	struct spi_transfer t[3] = {};
> -	struct spi_message m;
> -	int cmd_sz = m25p_cmdsz(nor);
> -	ssize_t ret;
> +	u8 addrs[4];
> +	struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
> +				   SPI_MEM_OP_ADDRS(nor->addr_width, addrs, 1),
> +				   SPI_MEM_OP_DUMMY(0, 1),
> +				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
> +	size_t remaining = len;
> +	int ret;
>  
>  	/* get transfer protocols. */
> -	inst_nbits = spi_nor_get_protocol_inst_nbits(nor->write_proto);
> -	addr_nbits = spi_nor_get_protocol_addr_nbits(nor->write_proto);
> -	data_nbits = spi_nor_get_protocol_data_nbits(nor->write_proto);
> -
> -	spi_message_init(&m);
> +	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
> +	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
> +	op.dummy.buswidth = op.addr.buswidth;
> +	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
>  
>  	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
> -		cmd_sz = 1;
> -
> -	flash->command[0] = nor->program_opcode;
> -	m25p_addr2cmd(nor, to, flash->command);
> +		op.addr.nbytes = 0;
>  
> -	t[0].tx_buf = flash->command;
> -	t[0].tx_nbits = inst_nbits;
> -	t[0].len = cmd_sz;
> -	spi_message_add_tail(&t[0], &m);
> +	while (remaining) {
> +		if (op.addr.nbytes)
> +			m25p_offs2addr(nor, to, addrs);
>  
> -	/* split the op code and address bytes into two transfers if needed. */
> -	data_idx = 1;
> -	if (addr_nbits != inst_nbits) {
> -		t[0].len = 1;
> +		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
> +		ret = spi_mem_adjust_op_size(flash->spimem, &op);
> +		if (ret)
> +			return ret;
>  
> -		t[1].tx_buf = &flash->command[1];
> -		t[1].tx_nbits = addr_nbits;
> -		t[1].len = cmd_sz - 1;
> -		spi_message_add_tail(&t[1], &m);
> +		ret = spi_mem_exec_op(flash->spimem, &op);
> +		if (ret)
> +			return ret;
>  
> -		data_idx = 2;
> +		to += op.data.nbytes;
> +		remaining -= op.data.nbytes;
> +		op.data.buf.out += op.data.nbytes;
> 
> For NOR flashes, WRITE command is being send in order as below
> Write Enable command
> Flash Write command
> Status Register command
> 
> But for case when Write data size is more than op.data.nbytes then for
> remaining data size chunk, we are just sending the FLASH WRITE Command
> and this is the reason I am seeing failure after 64 byte data size.
> 

Hm, I guess we'll have to revive this patch [1] (see below for a
modified version based on the spi-mem changes).

Regards,

Boris

[1]https://patchwork.ozlabs.org/patch/905507/

--->8---
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index e84563d2067f..f2403b36649c 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -84,22 +84,16 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
        if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
                op.addr.nbytes = 0;
 
-       while (remaining) {
-               op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
-               ret = spi_mem_adjust_op_size(flash->spimem, &op);
-               if (ret)
-                       return ret;
-
-               ret = spi_mem_exec_op(flash->spimem, &op);
-               if (ret)
-                       return ret;
+       op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
+       ret = spi_mem_adjust_op_size(flash->spimem, &op);
+       if (ret)
+               return ret;
 
-               op.addr.val += op.data.nbytes;
-               remaining -= op.data.nbytes;
-               op.data.buf.out += op.data.nbytes;
-       }
+       ret = spi_mem_exec_op(flash->spimem, &op);
+       if (ret)
+               return ret;
 
-       return len;
+       return op.data.nbytes;
 }
 
 /*
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5bfa36e95f35..3e635430bfde 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
                        goto write_err;
                *retlen += written;
                i += written;
-               if (written != page_remain) {
-                       dev_err(nor->dev,
-                               "While writing %zu bytes written %zd bytes\n",
-                               page_remain, written);
-                       ret = -EIO;
-                       goto write_err;
-               }
        }
 
 write_err:


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
