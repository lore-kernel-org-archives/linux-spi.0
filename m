From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [RFC PATCH 1/6] spi: Extend the core to ease integration of SPI
 memory controllers
Date: Thu, 8 Mar 2018 15:07:01 +0100
Message-ID: <20180308150701.60435d9c@bbrezillon>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
 <20180205232120.5851-2-boris.brezillon@bootlin.com>
 <c45b9709-be32-d864-c8b2-0e33d7da28b2@wedev4u.fr>
 <20180305100025.3b25ae3d@bbrezillon>
 <7314a397-2821-ceb8-a9ff-f14d0dd2a176@wedev4u.fr>
 <20180305144702.0afd663e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
 Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-spi@vger.kernel.org, Peter Pan <peterpansjtu@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Sourav Poddar <sourav.poddar@ti.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180305144702.0afd663e@bbrezillon>
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

On Mon, 5 Mar 2018 14:47:02 +0100
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> > >     
> > >>> +
> > >>> +/**
> > >>> + * struct spi_mem_op - describes a SPI memory operation
> > >>> + * @cmd.buswidth: number of IO lines used to transmit the command
> > >>> + * @cmd.opcode: operation opcode
> > >>> + * @addr.nbytes: number of address bytes to send. Can be zero if the operation
> > >>> + *		 does not need to send an address
> > >>> + * @addr.buswidth: number of IO lines used to transmit the address cycles
> > >>> + * @addr.buf: buffer storing the address bytes
> > >>> + * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
> > >>> + *		  be zero if the operation does not require dummy bytes
> > >>> + * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
> > >>> + * @data.buswidth: number of IO lanes used to send/receive the data
> > >>> + * @data.dir: direction of the transfer
> > >>> + * @data.buf.in: input buffer
> > >>> + * @data.buf.out: output buffer
> > >>> + */
> > >>> +struct spi_mem_op {
> > >>> +	struct {
> > >>> +		u8 buswidth;
> > >>> +		u8 opcode;
> > >>> +	} cmd;
> > >>> +
> > >>> +	struct {
> > >>> +		u8 nbytes;
> > >>> +		u8 buswidth;
> > >>> +		const u8 *buf;      
> > >>
> > >> For the address value, I would rather use some loff_t type, instead of
> > >> const u8 *. 
> > >> Actually, most (if not all) SPI flash controllers have some hardware
> > >> register to set the address value of the SPI flash command to be
> > >> sent. Hence having this value directly in the right format would avoid to
> > >> convert.    
> > > 
> > > What is the appropriate format? An address encoded in a 64-bit integer
> > > does not give any information on how these bytes should be transmitted
> > > on the bus. SPI NOR is passing the address in big endian, SPI NAND seems
> > > to do the same, but we're not sure this will be the case for all kind of
> > > memories or devices using this spi-mem protocol.
> > > 
> > > Also, by passing it through an integer we limit ourselves to 8 bytes.
> > > That should be enough, but who knows :-).
> > > 
> > > If we go for this loff_t field, we'll have to add an endianness field
> > > here and force all drivers to check it.
> > >    
> > 
> > I don't think we need any endianness field. We already use loff_t only,
> > without additional endianness paramater, in spi-nor but also in the above
> > MTD layer (see 'struct mtd_info') and till now it has just worked fine.  
> 
> It's not about the MTD layer. Can you predict that all devices will
> transmit the address in big-endian? I can't.

If you really want an loff_t (or u64) field here I'll change it (even
if I'm not convinced this is a good idea). In this case we'll just
assume that all devices expect addresses to be sent in big-endian on
the wire (MSB first).


> 
> >    
> > >> AFAIK, only m25p80 needs to convert from loff_t to u8 * and only
> > >> when using the regular SPI API, ie spi_sync(), as the 'struct
> > >> spi_flash_read_messag' already uses some integral type too.    
> > > 
> > > And I'm not sure this was a good idea.
> > >     
> > >>
> > >>    
> > >>> +	} addr;
> > >>> +
> > >>> +	struct {
> > >>> +		u8 nbytes;
> > >>> +		u8 buswidth;
> > >>> +	} dummy;
> > >>> +
> > >>> +	struct {
> > >>> +		u8 buswidth;
> > >>> +		enum spi_mem_data_dir dir;
> > >>> +		unsigned int nbytes;
> > >>> +		/* buf.{in,out} must be DMA-able. */
> > >>> +		union {
> > >>> +			void *in;
> > >>> +			const void *out;
> > >>> +		} buf;
> > >>> +	} data;      
> > >>
> > >> Also, you should add another member in this structure to set the 'type' of
> > >> operation for the SPI flash command:
> > >> - register read
> > >> - register write
> > >> - memory read
> > >> - memory write
> > >> - memory erase
> > >> [- SFDP read ? ]
> > >> [- OTP read/write ? ]    
> > > 
> > > No, really, that's not belonging here. It's entirely SPI NOR specific.
> > >     
> > 
> > I disagree with you on that. Except for SFDP of course, this will also apply to
> > SPI NAND as well. And this information should be passed down to the SPI (flash)
> > controller driver, instead of being lost at the SPI NAND/NOR levels,  
> 
> I'm not saying we should keep these information at the spi-nor/nand
> level, just saying we should find a way to make it look like a generic
> solution so that SPI controllers don't have to guess what they should
> do based on the memory operation type.
> 
> Typically, why should a SPI controller care about whether the operation
> is an erase, a reg read or a reg write. From the controller PoV, it's
> just an spi-mem operation.
> The use cases you want to optimize are read/write user-data, and this
> can be done in different ways (direct memory mapping is one solution).
> 
> > so the SPI
> > controller driver could take the proper actions (data cache flush/invalidation
> > for memory operations,  
> 
> This one has to do with direct mapping, so an API to allow direct
> mapping should help address that.

> 
> > enabling/disabling on-the-fly data scrambling,  
> 
> And what's the problem with passing the scramble information on a
> per-operation basis and letting the upper layer decide when it's a good
> idea to use it or not?
> 
> > and other
> > controller specific constraints).  
> 

Can we leave those additional improvements for later? I mean, we'd
better start passing extra information in the spi_mem_op struct when we
actually know what's needed instead of speculating on what the drivers
will need before having tried to convert them to the new approach.
Actually, I exercised the new interface by converting the fsl-qspi
driver and I didn't need the access-type information you're mentioning
here even though I'm using direct AHB accesses for the read path. I'm
not saying 'never', but 'let's wait until we have a real user'.

If you don't mind, I'd like to send a new version addressing all the
comments I received so far.

Regards,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
