From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 5/7] mtd: devices: m25p80: Use the spi-mem dirmap API
Date: Wed, 31 Oct 2018 11:49:51 +0100
Message-ID: <20181031114951.55f662cc@bbrezillon>
References: <20181030133638.3322-1-boris.brezillon@bootlin.com>
 <20181030133638.3322-6-boris.brezillon@bootlin.com>
 <VI1PR04MB57269B26A682B1FCFAC4E6F399CD0@VI1PR04MB5726.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <VI1PR04MB57269B26A682B1FCFAC4E6F399CD0@VI1PR04MB5726.eurprd04.prod.outlook.com>
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

On Wed, 31 Oct 2018 10:28:04 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:


> > +static int m25p_create_read_dirmap(struct m25p *flash) {
> > +	struct spi_nor *nor = &flash->spi_nor;
> > +	struct spi_mem_dirmap_info info = {
> > +		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor-  
> > >read_opcode, 1),  
> > +				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 1),
> > +				      SPI_MEM_OP_DUMMY(nor->read_dummy,
> > 1),
> > +				      SPI_MEM_OP_DATA_IN(0, NULL, 1)),
> > +		.offset = 0,
> > +		.length = flash->spi_nor.mtd.size,  
> 
> I want to understand the sequence of calling up of this routine from drivers/mtd/spi-nor/spi-nor.c file.
> Because till point of JedecID read and SFDP command read mtd.size is not being populated and having value as 0. This would make length as 0.

When the dirmap is created mtd->size has been initialized already. But
you're right, nor->read() might be called before the read dirmap has
been created (SFDP read), which will lead to a NULL pointer exception.

> 
> Did these read follow different path?

Nope.


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
