From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [RFC PATCH 1/6] spi: Extend the core to ease integration of SPI
 memory controllers
Date: Mon, 5 Mar 2018 10:00:25 +0100
Message-ID: <20180305100025.3b25ae3d@bbrezillon>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
 <20180205232120.5851-2-boris.brezillon@bootlin.com>
 <c45b9709-be32-d864-c8b2-0e33d7da28b2@wedev4u.fr>
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
In-Reply-To: <c45b9709-be32-d864-c8b2-0e33d7da28b2@wedev4u.fr>
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

Hello Cyrille,

On Sun, 4 Mar 2018 22:15:20 +0100
Cyrille Pitchen <cyrille.pitchen@wedev4u.fr> wrote:

> > +
> > +static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
> > +{
> > +	u32 mode = mem->spi->mode;
> > +
> > +	switch (buswidth) {
> > +	case 1:
> > +		return 0;
> > +
> > +	case 2:
> > +		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
> > +		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))  
> 
> Some SPI (flash) controller may support Quad protocols but no Duals
> protocols at all. Hence you should only test SPI_{R,T]X_DUAL.

Hm, I'd rather not change that, since it's what have been used so far.
Note that a controller that wants to put more constraints can still
implement the ->supports_op() hook.

> 
> Anyway, I think the function should completely be removed because
> SPI_{R,T}X_{DUAL,QUAD} flags should be deprecated.
> 
> They were fine when introduced long time ago when Quad SPI flashes only
> supported Fast Read 1-1-4 and maybe few of them Page Program 1-1-4.
> 
> However for many years now, Quad SPI flashes support far much SPI protocols
> and commands. For instance:
> Fast Read 1-1-4
> Fast Read 1-4-4
> (Fast Read 4-4-4)
> Page Program 1-1-4
> Page Program 1-4-4
> Page Program 4-4-4
> 
> Fast Read x-y-z means that:
> - the op code is transfered (tx) on x I/O line(s)
> - the address, mode and dummies are transfered (tx) on y I/O line(s)
> - the data are received (rx) on z I/O line(s)
> 
> Page Program x-y-z stands for:
> - the op code being transfered (tx) on x I/O line(s)
> - the address is transfered (tx) on y I/O line(s)
> the data are transfered (tx) on z I/O line(s)
> 
> Then some SPI flash controllers and/or memories may support Fast Read 1-4-4
> but not Page Program 1-1-4 whereas others may support Page Program 1-1-4
> but not Fast Read 1-4-4.
> 
> So using only SPI_{R,T}X_{DUAL,QUAD} flags, how do we make the difference
> between support of Fast Read 1-4-4 and Page Program 1-1-4 or between
> Fast Read 1-1-4 and Fast Read 1-4-4 ?

I think you're mixing 2 different things:

1/ The RX/TX buswidth capabilities for generic SPI/DualSPI/QuadSPI
   transfers, which is, I guess, what these flags have been created for

2/ The buswidth of each instruction of a memory-like operation (by
   instruction I mean, CMD, ADDR, DATA cycles)

There is no reason for a generic SPI controller to specify things for
#2, because it doesn't know anything about this spi-mem protocol, all
it can do is send/recv data using a specific bus width.

> Indeed some latest (Cypress) memories only support Fast Read 1-4-4 but no
> longer Fast Read 1-1-4.

And here you're going to specific. This framework is not here to fully
handle SPI NOR devices, it's here to abstract things enough to make SPI
controllers compatible with various SPI memories or devices that want
to use a similar protocol (FPGAs?).

> 
> I guess we'd rather use something close to the SNOR_HWCAPS_* macros as
> defined in include/linux/mtd/spi-nor.h

->supports_op() should be enough to check such constraints, I don't see
a need for yet another set of macros.

> 
> SPI_{R,T}X_{DUAL,QUAD} flags are no longer suited to SPI flash memories for
> a long time now.

See my explanation above. I don't think SPI_{R,T}X_{DUAL,QUAD} have
been created to handle SPI memories, it's just a way to specify the
supported buswidth for a SPI transfer, that's all. And we still need
them for regular SPI transfers.

> 
> 
> > +			return 0;
> > +
> > +		break;
> > +
> > +	case 4:
> > +		if ((tx && (mode & SPI_TX_QUAD)) ||
> > +		    (!tx && (mode & SPI_RX_QUAD)))
> > +			return 0;
> > +
> > +		break;
> > +
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return -ENOTSUPP;
> > +}
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
> > +	if (spi_check_buswidth_req(mem, op->cmd.buswidth, true))
> > +		return false;
> > +
> > +	if (op->addr.nbytes &&
> > +	    spi_check_buswidth_req(mem, op->addr.buswidth, true))
> > +		return false;
> > +
> > +	if (op->dummy.nbytes &&
> > +	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
> > +		return false;
> > +
> > +	if (op->data.nbytes &&
> > +	    spi_check_buswidth_req(mem, op->data.buswidth,
> > +				   op->data.dir == SPI_MEM_DATA_IN ?
> > +				   false : true))
> > +		return false;  
> 
> You should remove the 4 tests and calls of spi_check_buswidth_req() above.

Why?

> Based on spi_controller_check_ops(), when ctrl->mem_ops is not NULL,
> mem_ops->supports_op() must be provided, this hook is mandatory.

Well, this was a mistake on my side, see my reply to Vignesh.

> 
> So call this latest hook only, has done just below. You may want to keep the 4
> tests above and spi_check_buswidth_req() but then move them in a
> stand-alone function that could be used as a default implementation of
> mem_ops->supports_op() if you want to allow some SPI controller drivers not
> to implement ->supports_op() by their own.

Okay, that's an option: make ->supports_op() mandatory and then provide
an helper if the controller does not have any extra constraints. I see
one problem with this approach:

> 
> However it should be considered a transitionnal and at some point I think
> SPI_{R,T}X_{DUAL,QUAD} flags should just be removed because many
> developers submitting patches to spi-nor have often been confused by how
> properly use those flags in their drivers.

And here I disagree, again. SPI_{R,T}X_{DUAL,QUAD} are still useful for
regular SPI transfers. I guess not every Dual/Quad SPI device is using
the spi-mem protocol, so we need to support this case too.

> 
> Till then, if you removed the 4 tests above, at least new SPI flash
> controller drivers won't have to set some odd combination of flags in
> spi->mode to make their support of SPI flash memories work as they want.

Hm, I'm not sure about spi->mode. AFAICT, SPI_{R,T}X_{DUAL,QUAD}
flags are only encoding what the device supports, not the current mode.

But I guess you were talking about controller->mode_bits which encodes
the controller capabilities, and I think this one is still useful if
the controller is a generic SPI controller.

As a side note, I'll add that it's possible to have a device supporting
SPI+DualSPI+QuadSPI and still have this device partially connected to
the host controller (some pins left unconnected), hence the
spi-{tx,rx}-bus-width properties in DTs. So we really want to check
the device capabilities, the controller capabilities and the limitation
implied by the board design.

> > +
> > +/**
> > + * struct spi_mem_op - describes a SPI memory operation
> > + * @cmd.buswidth: number of IO lines used to transmit the command
> > + * @cmd.opcode: operation opcode
> > + * @addr.nbytes: number of address bytes to send. Can be zero if the operation
> > + *		 does not need to send an address
> > + * @addr.buswidth: number of IO lines used to transmit the address cycles
> > + * @addr.buf: buffer storing the address bytes
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
> > +		const u8 *buf;  
> 
> For the address value, I would rather use some loff_t type, instead of
> const u8 *. 
> Actually, most (if not all) SPI flash controllers have some hardware
> register to set the address value of the SPI flash command to be
> sent. Hence having this value directly in the right format would avoid to
> convert.

What is the appropriate format? An address encoded in a 64-bit integer
does not give any information on how these bytes should be transmitted
on the bus. SPI NOR is passing the address in big endian, SPI NAND seems
to do the same, but we're not sure this will be the case for all kind of
memories or devices using this spi-mem protocol.

Also, by passing it through an integer we limit ourselves to 8 bytes.
That should be enough, but who knows :-).

If we go for this loff_t field, we'll have to add an endianness field
here and force all drivers to check it.

> AFAIK, only m25p80 needs to convert from loff_t to u8 * and only
> when using the regular SPI API, ie spi_sync(), as the 'struct
> spi_flash_read_messag' already uses some integral type too.

And I'm not sure this was a good idea.

> 
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
> 
> Also, you should add another member in this structure to set the 'type' of
> operation for the SPI flash command:
> - register read
> - register write
> - memory read
> - memory write
> - memory erase
> [- SFDP read ? ]
> [- OTP read/write ? ]

No, really, that's not belonging here. It's entirely SPI NOR specific.

> 
> Indeed, some SPI flash controller drivers need this information.

Then they'll have to be converted/reworked to not depend on that. I did
it for the FSL QSPI controller, and it worked fine. I'm pretty sure
almost all controllers will fit well in the new framework. For those
controllers that really are only able to handle SPI NOR devices (I'm
thinking about the Intel one, but there may be others), then they should
not be converted to the spi_mem approach.

> 
> For instance the Atmel QSPI controller has some optional feature that allow
> to scramble data on the fly from/to the (Q)SPI memory. Hence the scrambling
> should be enabled for memory {read,write} (Fast Read, Page Programm)
> commands but disabled for register {read,write} commands (Read ID, Write
> Enable, Read/Write Status Register, ...).

If scrambling is really something that we need to support, then I think
adding a spi_mem_op->data.scramble boolean would be more appropriate.

> 
> SPI flash controller drivers *should not* have to check the SPI flash command
> instruction op code to guess what kind of operation is being performed.

I completely agree. Not only they shouldn't check the opcode to guess
what is being done, but, IMHO, they should also not try to determine
what kind of operation is being done, so your suggestion to add an
operation type information is not a good idea.

> 
> Another example:
> Some (Q)SPI flash controllers map the the SPI flash memory into the system
> address space then perform some "memcpy-like" operations to access this SPI
> flash memory whereas they rely on reguler register to handle SPI flash
> commands reading from or writing into the internal registers fo the SPI
> flash. So those controller too need to make the difference between register
> and memory operations.

I already thought about the direct mapping stuff, and I think this
should be supported through new hooks in spi_mem_ops (->map() +
->unmap()?).

Thanks for your review.

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
