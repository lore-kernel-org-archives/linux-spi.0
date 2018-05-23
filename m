From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v4 6/7] mtd: spi-nor: Use the spi_mem_xx() API
Date: Wed, 23 May 2018 20:06:11 +0200
Message-ID: <20180523200611.77cab6e5@bbrezillon>
References: <20180426161820.2852-1-boris.brezillon@bootlin.com>
 <20180426161820.2852-7-boris.brezillon@bootlin.com>
 <6a39f071-186e-7009-994d-af845ce3f75d@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-spi@vger.kernel.org,
 Peter Pan <peterpansjtu@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <6a39f071-186e-7009-994d-af845ce3f75d@microchip.com>
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

Hi Cyrille,

On Wed, 23 May 2018 17:44:32 +0200
Cyrille Pitchen <cyrille.pitchen@microchip.com> wrote:

> > +					  SPI_MEM_OP_DATA_OUT(len, buf, 1));
> >  
> > -	return spi_write(spi, flash->command, len + 1);
> > +	return spi_mem_exec_op(flash->spimem, &op);
> >  }
> >  
> >  static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
> >  			    const u_char *buf)
> >  {
> >  	struct m25p *flash = nor->priv;
> > -	struct spi_device *spi = flash->spi;
> > -	unsigned int inst_nbits, addr_nbits, data_nbits, data_idx;
> > -	struct spi_transfer t[3] = {};
> > -	struct spi_message m;
> > -	int cmd_sz = m25p_cmdsz(nor);
> > -	ssize_t ret;
> > +	struct spi_mem_op op =
> > +			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
> > +				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
> > +				   SPI_MEM_OP_DUMMY(0, 1),  
> 
> Why do you use SPI_MEM_OP_DUMMY(0, 1) here instead of SPI_MEM_OP_NO_DUMMY() ?

I guess I just copied the definition from m25p80_read() and modified
the definition without noticing this one could be replaced by
SPI_MEM_OP_NO_DUMMY. Not a big deal though, since SPI_MEM_OP_DUMMY(0,
1) still means "no dummy cycles".

Do you plan to send a patch to change that, or should I?

Regards,

Boris

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
