From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 04/10] spi: Extend the core to ease integration of
 SPI memory controllers
Date: Thu, 12 Apr 2018 17:10:05 +0200
Message-ID: <20180412171005.5cfaba58@bbrezillon>
References: <20180410224439.9260-1-boris.brezillon@bootlin.com>
 <20180410224439.9260-5-boris.brezillon@bootlin.com>
 <60f3d53a-9668-9e1c-9f29-45aaf4004630@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Kamal Dasu <kdasu.kdev@gmail.com>,
 Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-spi@vger.kernel.org, Peter Pan <peterpansjtu@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Vignesh R <vigneshr@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <60f3d53a-9668-9e1c-9f29-45aaf4004630@ti.com>
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

On Thu, 12 Apr 2018 20:08:28 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Hi,
> 
> - Sourav Poddar <sourav.poddar@ti.com> mail ID no longer valid.
> 
> On Wednesday 11 April 2018 04:14 AM, Boris Brezillon wrote:
> > Some controllers are exposing high-level interfaces to access various
> > kind of SPI memories. Unfortunately they do not fit in the current
> > spi_controller model and usually have drivers placed in
> > drivers/mtd/spi-nor which are only supporting SPI NORs and not SPI
> > memories in general.
> > 
> > This is an attempt at defining a SPI memory interface which works for
> > all kinds of SPI memories (NORs, NANDs, SRAMs).
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---  
> 
> [...]
> 
> > +/**
> > + * struct spi_mem_op - describes a SPI memory operation
> > + * @cmd.buswidth: number of IO lines used to transmit the command
> > + * @cmd.opcode: operation opcode
> > + * @addr.nbytes: number of address bytes to send. Can be zero if the operation
> > + *		 does not need to send an address
> > + * @addr.buswidth: number of IO lines used to transmit the address cycles
> > + * @addr.val: address value. This value is always sent MSB first on the bus.
> > + *	      Note that only @addr.nbytes are taken into account in this
> > + *	      address value, so users should make sure the value fits in the
> > + *	      assigned number of bytes.
> > + * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
> > + *		  be zero if the operation does not require dummy bytes
> > + * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
> > + * @data.buswidth: number of IO lanes used to send/receive the data
> > + * @data.dir: direction of the transfer
> > + * @data.buf.in: input buffer
> > + * @data.buf.out: output buffer
> > + */
> > +struct spi_mem_op {
> > +	struct {
> > +		u8 buswidth;
> > +		u8 opcode;
> > +	} cmd;
> > +
> > +	struct {
> > +		u8 nbytes;
> > +		u8 buswidth;
> > +		u64 val;  
> 
> You could consider using loff_t here and be consistent with
> spi_nor_read/write() API as well as mtd->_read().

Hm, I always have a hard time using types which does not clearly say
how large they are, but okay.

> 
> > +	} addr;
> > +
> > +	struct {
> > +		u8 nbytes;
> > +		u8 buswidth;
> > +	} dummy;
> > +
> > +	struct {
> > +		u8 buswidth;
> > +		enum spi_mem_data_dir dir;
> > +		unsigned int nbytes;
> > +		/* buf.{in,out} must be DMA-able. */
> > +		union {
> > +			void *in;
> > +			const void *out;
> > +		} buf;
> > +	} data;
> > +};
> > +  
> 
> Some flash devices support Dual/Quad DDR (Double Data Rate) mode and the
> SPI controller driver would need to know this information. We will need
> to add a field for that.

Well, let's wait until we actually need that.

> 
> Currently, there are drivers under mtd/spi-nor/ that need to know
> page/sector/total size of flash memory(info available in
> -`struct spi_nor). We would need a way to provide this info to spi_mem
> drivers, if we ever plan to move drivers under mtd/spi-nor to spi/

Again, we'll see when we'll try to move them, but I hope still we won't
need that. Looks like the kind of information I'd like to keep away
from spi controller drivers.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
