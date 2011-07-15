From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] pxa2xx_spi: fix memory corruption
Date: Fri, 15 Jul 2011 21:24:21 +0100
Message-ID: <20110715202421.GE24628@n2100.arm.linux.org.uk>
References: <201107101609.31405.anarsoul@gmail.com>
	<1310311099-24638-1-git-send-email-anarsoul@gmail.com>
	<20110715025331.GL2927@ponder.secretlab.ca>
	<20110715081242.GM23270@n2100.arm.linux.org.uk>
	<20110715195003.GG2833@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Eric Miao <eric.y.miao@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110715195003.GG2833@ponder.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 15, 2011 at 01:50:03PM -0600, Grant Likely wrote:
> On Fri, Jul 15, 2011 at 09:12:42AM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 14, 2011 at 08:53:31PM -0600, Grant Likely wrote:
> > > > +	u8 null_dma_buf_unaligned[16];
> > > 
> > > Don't dma buffers need to be cache-line aligned?  How large is the
> > > actual transfer?  Using the __aligned() or __cacheline_aligned
> > > attribute is the correct way to make sure you've got a data buffer
> > > that can be used for DMA mixed with other stuff.  Then you don't need
> > > to fool around with PTR_ALIGN or anything.
> > 
> > Err, did you not read the whole patch?
> > 
> > > > +	drv_data->null_dma_buf =
> > > > +		(u32 *)PTR_ALIGN(&drv_data->null_dma_buf_unaligned, 8);
> 
> I read a lot of patches yesterday.  I may very well have missed
> something.  I still don't see what you're referring to though.  If
> the __aligned() was used inside the structure definition, then there
> would be no need to have both the null_dma_buf pointer and the
> null_dma_buf_unaligned buffer.  It would just be a correctly aligned
> null_dma_buf.

That depends on the alignment guarantees from kmalloc, which may not be
8 bytes - we have this:

#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5)
#define ARCH_SLAB_MINALIGN 8
#endif

so presumably on !AEABI or arches < ARMv5, kmalloc _can_ return less than
8 byte alignments.  Which makes using __aligned() in the definition useless.

> Plus, I was asking about whether it was valid to use the structure as
> allocated in DMA operations since it may very well end up in the same
> cache line as the allocated structure.  Firstly, that could mean DMA
> and the cache referencing the same memory which could cause
> corruption, and secondly on ARM isn't it a problem to have DMA buffers
> in memory that is also cache mapped?

For the second point, that depends on whether you're talking about the
coherent stuff or the streaming stuff.

The coherent DMA API has entirely different semantics to streaming DMA API.
The coherent DMA API allows for simultaneous access to the buffer by both
the DMA device and the host CPU.

The streaming DMA API only allows exclusive access by either the DMA device
or the host CPU.

Therefore, with the streaming DMA API, the only thing that's required is
to ensure that data is visible in some manner to the DMA device.  If the
DMA device can read from the CPU cache, then probably nothing's required.
If not, then the data must be evicted from as many levels of cache that
are necessary to make it visible.  Conversely, for DMA writes, what
matters is the visibility of the data to the host CPU.

That approach does not work with the coherent DMA API.  Take a network
driver TX ring.  Consider the effect of the following series of actions
to see why it won't work:

- host CPU reads a word from the DMA buffer.  This brings in a whole
  cache line.
- network device writes to the previous descriptor (which overlaps the
  just read cache line) to change its status
- host CPU updates the next descriptor and writes the cache line back
  XXX overwriting the network device's write to the previous descriptor.

So, coherent DMA is special because there's no exclusiveness there.
