From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 04/10] spi: Extend the core to ease integration of
 SPI memory controllers
Date: Wed, 18 Apr 2018 16:23:23 +0200
Message-ID: <20180418162323.0db577a3@bbrezillon>
References: <20180410224439.9260-1-boris.brezillon@bootlin.com>
 <20180410224439.9260-5-boris.brezillon@bootlin.com>
 <31229922-5bc4-99ce-5373-452d27a20ade@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-spi@vger.kernel.org,
 Peter Pan <peterpansjtu@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Sourav Poddar <sourav.poddar@ti.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <31229922-5bc4-99ce-5373-452d27a20ade@exceet.de>
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

Hi Frieder,

On Mon, 16 Apr 2018 12:33:54 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
 
> > +
> > +/**
> > + * spi_mem_supports_op() - Check if a memory device and the controller it is
> > + *			   connected to support a specific memory operation
> > + * @mem: the SPI memory
> > + * @op: the memory operation to check
> > + *
> > + * Some controllers are only supporting Single or Dual IOs, others might only
> > + * support specific opcodes, or it can even be that the controller and device
> > + * both support Quad IOs but the hardware prevents you from using it because
> > + * only 2 IO lines are connected.
> > + *
> > + * This function checks whether a specific operation is supported.
> > + *
> > + * Return: true if @op is supported, false otherwise.
> > + */
> > +bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
> > +{
> > +	struct spi_controller *ctlr = mem->spi->controller;
> > +
> > +	if (ctlr->mem_ops->supports_op)  
> 
> this misses a null check for mem_ops:
> 	if (ctlr->mem_ops && ctlr->mem_ops->supports_op)

Yep. I'll fix that in v3.

Thanks,

Boris


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
