From: masonccyang@mxic.com.tw
Subject: Re: [PATCH 3/4] mtd: spi-nor: Add Octal 8D-8D-8D mode support for
 Macronix mx25uw51245g
Date: Mon, 9 Dec 2019 14:38:25 +0800
Message-ID: <OF5C924A21.8A6464DD-ON482584CB.00232656-482584CB.002479DE@mxic.com.tw>
References: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
 <1573808288-19365-4-git-send-email-masonccyang@mxic.com.tw>
 <1f1a368a-e3d3-4e58-819e-b4dffc3212ef@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, juliensu@mxic.com.tw, richard@nod.at,
 tudor.ambarus@microchip.com, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 broonie@kernel.org, linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
 computersforpeace@gmail.com, dwmw2@infradead.org, marek.vasut@gmail.com
To: "Vignesh Raghavendra" <vigneshr@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1f1a368a-e3d3-4e58-819e-b4dffc3212ef@ti.com>
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


Hi Vignesh,

> > 
> >  /*
> > + * Read configuration register 2, returning its value in the
> > + * location. Return the configuration register 2 value.
> > + * Returns negative if error occurred.
> > + */
> > +static int read_cr2(struct spi_nor *nor, u32 addr)
> 
> Please prefix spi_nor_* for all new functions. 
> Also, include manf name if its vendor specific.

okay, will fix it.

> 
> > +{
> > +   int ret;
> > +
> > +   if (nor->spimem) {
> > +      struct spi_mem_op op =
> > +         SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR2, 1),
> > +               SPI_MEM_OP_ADDR(4, addr, 1),
> > +               SPI_MEM_OP_DUMMY(4, 1),
> > +               SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
> > +
> > +      if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
> > +         op.cmd.buswidth = 8;
> > +         op.addr.buswidth = 8;
> > +         op.dummy.buswidth = 8;
> > +         op.data.buswidth = 8;
> > +         op.cmd.nbytes = 2;
> > +
> > +         if (spi_nor_protocol_is_8D_8D_8D(nor->read_proto)) {
> > +            op.dummy.nbytes *= 2;
> > +            op.cmd.dtr = true;
> > +            op.addr.dtr = true;
> > +            op.dummy.dtr = true;
> > +            op.data.dtr = true;
> > +         }
> > +
> > +         if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
> > +            op.cmd.ext_opcode = ~SPINOR_OP_RDCR2;
> > +         else
> > +            op.cmd.ext_opcode = SPINOR_OP_RDCR2;
> > +      }
> > +
> > +      ret = spi_mem_exec_op(nor->spimem, &op);
> > +   } else {
> > +      ret = -ENOTSUPP;
> > +   }
> > +
> > +   if (ret < 0) {
> > +      dev_err(nor->dev, "error %d reading CR\n", ret);
> > +      return ret;
> > +   }
> > +
> > +   return nor->bouncebuf[0];
> > +}
> > +
> > +/*
> >   * Write configuration register 2 one byte
> >   * Returns negative if error occurred.
> >   */
> > @@ -2275,10 +2325,72 @@ static int spi_nor_spansion_clear_sr_bp(struct 
spi_nor *nor)
> >     return 0;
> >  }
> > 
> > +static void
> > +spi_nor_set_read_settings(struct spi_nor_read_command *read,
> > +           u8 num_mode_clocks,
> > +           u8 num_wait_states,
> > +           u8 opcode,
> > +           enum spi_nor_protocol proto);
> > +
> > +static void
> > +spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
> > +         u8 opcode,
> > +         enum spi_nor_protocol proto);
> > +
> > +static void
> > +mx25uw51245g_default_init(struct spi_nor *nor)
> > +{
> > +   struct spi_nor_flash_parameter *params = &nor->params;
> > +
> > +   if (!(nor->spimem->spi->mode & (SPI_RX_OCTAL | SPI_TX_OCTAL)))
> > +      return;
> > +
> > +   /* Octal 8S-8S-8S mode */
> > +   params->hwcaps.mask |= SNOR_HWCAPS_OPI_FULL_STR;
> > +   spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8],
> > +              0, 20, SPINOR_OP_READ_8_8_8,
> > +              SNOR_PROTO_8_8_8);
> > +
> > +   spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8],
> > +            SPINOR_OP_PP_8_8_8, SNOR_PROTO_8_8_8);
> > +
> > +   /* Octal 8D-8D-8D mode */
> > +   params->hwcaps.mask |= SNOR_HWCAPS_OPI_FULL_DTR;
> > +   spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8D_8D_8D],
> > +              0, 20, SPINOR_OP_READ_8D_8D_8D,
> > +              SNOR_PROTO_8_8_8_DTR);
> > +
> > + 
spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8D_8D_8D],
> > +            SPINOR_OP_PP_8D_8D_8D, SNOR_PROTO_8_8_8_DTR);
> > +
> > +   nor->ext_cmd_mode = EXT_CMD_IS_INVERSE;
> > +}
> 
> I don't see anything that is macronix specific here.. Can this be moved 
to
> generic code with information parsed from SFDP table?

This mx25uw51245g device support SFDP command but returns an empty SFDP 
page.

> 
> > +
> > +static void
> > +mx25uw51245g_post_sfdp_fixups(struct spi_nor *nor)
> > +{
> > +   struct spi_nor_flash_parameter *params = &nor->params;
> > +   u8 cr2;
> > +
> > +   cr2 = read_cr2(nor, CR2_REG0) & CR2_REG0_MODE_MASK;
> > +
> > +   if (params->hwcaps.mask & SNOR_HWCAPS_OPI_FULL_DTR)
> > +      cr2 |= CR2_REG0_MODE_OPI_DTR;
> > +   else if (params->hwcaps.mask & SNOR_HWCAPS_OPI_FULL_STR)
> > +      cr2 |= CR2_REG0_MODE_OPI_STR;
> > +
> > +   write_cr2(nor, CR2_REG0, cr2);
> > +}
> > +
> 
> I see this as a misuse of sfdp_fixups hook:
> 
>  * @post_sfdp: called after SFDP has been parsed (is also called for SPI 
NORs
>  *             that do not support RDSFDP). Typically used to tweak 
various
>  *             parameters that could not be extracted by other means 
(i.e.
>  *             when information provided by the SFDP/flash_info tables 
are
>  *             incomplete or wrong).
>  *
> 
> 
> This should only tweak options parsed by SFDP and not be used to
> configure flash to a different mode. Please add a separate function 
> to do so. See https://patchwork.kernel.org/patch/10638085/
> 

okay.
My idea is that device changed to 8D-8D-8D stateful mode after SFDP 
parsed. 
But if SFDP page table is broken in device and driver will just configure 
the device into 8D-8D-8D mode directly.


thanks for your time & comments.

Mason

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
