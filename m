From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 04/10] spi: Extend the core to ease integration of
 SPI memory controllers
Date: Thu, 12 Apr 2018 21:59:51 +0200
Message-ID: <20180412215951.751bf889@bbrezillon>
References: <20180410224439.9260-1-boris.brezillon@bootlin.com>
 <20180410224439.9260-5-boris.brezillon@bootlin.com>
 <60f3d53a-9668-9e1c-9f29-45aaf4004630@ti.com>
 <20180412171005.5cfaba58@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Kamal Dasu <kdasu.kdev@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, linux-spi@vger.kernel.org,
 Peter Pan <peterpansjtu@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Vignesh R <vigneshr@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180412171005.5cfaba58@bbrezillon>
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

On Thu, 12 Apr 2018 17:10:05 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Thu, 12 Apr 2018 20:08:28 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
> > Hi,
> > 
> > - Sourav Poddar <sourav.poddar@ti.com> mail ID no longer valid.
> > 
> > On Wednesday 11 April 2018 04:14 AM, Boris Brezillon wrote:  
> > > Some controllers are exposing high-level interfaces to access various
> > > kind of SPI memories. Unfortunately they do not fit in the current
> > > spi_controller model and usually have drivers placed in
> > > drivers/mtd/spi-nor which are only supporting SPI NORs and not SPI
> > > memories in general.
> > > 
> > > This is an attempt at defining a SPI memory interface which works for
> > > all kinds of SPI memories (NORs, NANDs, SRAMs).
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > ---    
> > 
> > [...]
> >   
> > > +/**
> > > + * struct spi_mem_op - describes a SPI memory operation
> > > + * @cmd.buswidth: number of IO lines used to transmit the command
> > > + * @cmd.opcode: operation opcode
> > > + * @addr.nbytes: number of address bytes to send. Can be zero if the operation
> > > + *		 does not need to send an address
> > > + * @addr.buswidth: number of IO lines used to transmit the address cycles
> > > + * @addr.val: address value. This value is always sent MSB first on the bus.
> > > + *	      Note that only @addr.nbytes are taken into account in this
> > > + *	      address value, so users should make sure the value fits in the
> > > + *	      assigned number of bytes.
> > > + * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
> > > + *		  be zero if the operation does not require dummy bytes
> > > + * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
> > > + * @data.buswidth: number of IO lanes used to send/receive the data
> > > + * @data.dir: direction of the transfer
> > > + * @data.buf.in: input buffer
> > > + * @data.buf.out: output buffer
> > > + */
> > > +struct spi_mem_op {
> > > +	struct {
> > > +		u8 buswidth;
> > > +		u8 opcode;
> > > +	} cmd;
> > > +
> > > +	struct {
> > > +		u8 nbytes;
> > > +		u8 buswidth;
> > > +		u64 val;    
> > 
> > You could consider using loff_t here and be consistent with
> > spi_nor_read/write() API as well as mtd->_read().  
> 
> Hm, I always have a hard time using types which does not clearly say
> how large they are, but okay.

BTW, loff_t is signed, which doesn't really make sense here, so I'd
like to keep an u64 unless you have a strong reason not to.

> 
> >   
> > > +	} addr;
> > > +
> > > +	struct {
> > > +		u8 nbytes;
> > > +		u8 buswidth;
> > > +	} dummy;
> > > +
> > > +	struct {
> > > +		u8 buswidth;
> > > +		enum spi_mem_data_dir dir;
> > > +		unsigned int nbytes;
> > > +		/* buf.{in,out} must be DMA-able. */
> > > +		union {
> > > +			void *in;
> > > +			const void *out;
> > > +		} buf;
> > > +	} data;
> > > +};
> > > +    
> > 
> > Some flash devices support Dual/Quad DDR (Double Data Rate) mode and the
> > SPI controller driver would need to know this information. We will need
> > to add a field for that.  
> 
> Well, let's wait until we actually need that.
> 
> > 
> > Currently, there are drivers under mtd/spi-nor/ that need to know
> > page/sector/total size of flash memory(info available in
> > -`struct spi_nor). We would need a way to provide this info to spi_mem
> > drivers, if we ever plan to move drivers under mtd/spi-nor to spi/  
> 
> Again, we'll see when we'll try to move them, but I hope still we won't
> need that. Looks like the kind of information I'd like to keep away
> from spi controller drivers.

Let me clarify this part. I already thought a bit about this problem,
and that's the very reason we have an intermediate layer with a spi_mem
struct pointing to the real spi_device object. The idea is to add new
fields to spi_mem object if/when we really have to. We'd also have to
add ->attach/detach() methods to spi_mem_ops so that SPI mem controller
can know when a new device is about to be accessed by a spi-mem
driver, can parse the information provided in spi_mem and configure the
controller accordingly.

Now, even if that's something I considered when designing the spi-mem
interface, I'd like to stay away from this sort of specialization as
long as possible. Why? Simply because dealing with memory specificities
like "is it a NOR, a NAND or an SRAM? Should I erase blocks before
writing data? What's the page size, sector size, eraseblock size? ..."
is not something that belongs in the SPI framework. IMHO, it should
stay in SPI mem drivers (the SPI NOR or SPI NAND framework are such SPI
mem drivers).

This being said, I see a real need for advanced features. One example I
have in mind is a "direct-mapping API", where a spi_mem user could ask
for a specific region of the memory to be directly mapped (if the
feature is supported by the controller of course). And that's something
I think we can make generic enough to consider adding it to the
spi_mem_ops interface. All we'll need is a way to say "I want to map
this portion of the memory in R, W or RW and when you need to
read/write use this spi_mem_op and patch the address based on the
actual memory address that is being accessed".

Maybe I'm wrong and some controllers actually need to know which type
of device they are dealing with, but in that case, I'm not so sure they
belong in the SPI framework at all, unless they provide a dummy mode in
which they can act as a regular SPI/SPI mem controller (i.e. send SPI
mem operations without trying to be smart and do things behind our
back).


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
