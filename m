From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v2 10/12] spi: add driver for J-Core SPI controller
Date: Mon, 23 May 2016 16:29:38 -0400
Message-ID: <20160523202938.GD21636@brightrain.aerifal.cx>
References: <cover.1463708766.git.dalias@libc.org>
 <2e287ca758002621ef8eed3db9df37678e26af5e.1463708766.git.dalias@libc.org>
 <20160520102317.GH8206@sirena.org.uk>
 <20160520232414.GY21636@brightrain.aerifal.cx>
 <20160523153037.GV8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160523153037.GV8206@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 23, 2016 at 04:30:37PM +0100, Mark Brown wrote:
> On Fri, May 20, 2016 at 07:24:14PM -0400, Rich Felker wrote:
> > On Fri, May 20, 2016 at 11:23:17AM +0100, Mark Brown wrote:
> 
> > > This is *extremely* late for a first posting of a driver for v4.7 (you
> > > missed the list as well as the maintainers).
> 
> > I'm sorry for the mix-up. The kernel workflow is still fairly new to
> > me and I've been fighting with git format-patch/send-email and
> > get_maintainer.pl to get big patch series prepared the way I want and
> > sent to the right people/lists. I think I've got it right now though.
> 
> One question here is why this is even part of a series - it's adding a
> new controller driver which wouldn't normally have any sort of direct
> build or other dependency on anything else or have other things
> depending on it.  Unless there are dependencies it is generally best to
> send separate changes separately as far as possible so that there is no
> need to worry about issues with one part of the series slowing down
> other parts of the series.

I grouped the patches as a series because they make up support for a
complete SoC. While some of the peripheral drivers may well be useful
for non-J2 systems in the future (the cores are all open source, BSD
licensed), there's no short-term benefit to having these drivers
without the main J2 support.

In terms of hard dependencies, the mimas_v2 dts file depends on the
jcore,spi binding, but nothing depends on the driver. Still it's
important to have for the sake of actually making use of it all.

> > > > +	hw->csReg = ( JCORE_SPI_CTRL_ACS | JCORE_SPI_CTRL_CCS | JCORE_SPI_CTRL_DCS )
> > > > +		^ (!value << 2*spi->chip_select);
> 
> > > Why the xor here and not an or?  The coding style is also weird, a mix
> > > of extra spaces around the () and missing ones around *.  I'm finding
> > > the intent of the code confusing here.
> 
> > The intent is to set all chipselect bits (the 3 macro values) high
> > except possibly spi->chip_select. The xor is to turn off a bit, not
> > turn it on. &~ would also have worked; would that be more idiomatic?
> 
> No, the reader has to be able to tell what the code is doing.  If this
> made sense the thing to do would be to write out the logic operations
> explicitly to make it clear that every step is deliberate.  However in
> this case it sounds like the code is just plain buggy, though - the
> driver is being asked to set a specific chip select to a specific value
> but instead of just doing that it is also trying to also change some
> other settings.

It may be redundant, if the general SPI framework handles mutual
exclusion of chipselects, but it's not buggy. Only a single chipselect
can be active (low) at once; with multiple chips selected very bad
things will happen. I don't see any documentation of the high-level
SPI framework in Linux and what (if anything) it does to ensure that
all other chipselects are disabled before enabling one, which I why I
wrote the code so that the other chipselects are explicitly disabled.

> Don't do that, just have the function do what it was
> asked.  If the calling code has problems it'll need fixing anyway and if
> some feature you hadn't anticipated ends up meaning the combination of
> operations makes sense then things will just work.

Setting just a single bit seems more complicated and error-prone to
me; explicit effort has to be made to ensure that the hardware state
remains in sync with the driver's view of it. As written now, the
whole register (with all the cs/speed/etc. bits) is just written every
time.

> > > > +#if !USE_MESSAGE_MODE
> > > > +	spi_finalize_current_transfer(master);
> > > > +#endif
> 
> > > I'm not sure what the if is about but it doesn't belong upstream, you
> > > shouldn't be open coding bits of the framework.
> 
> > I can explain the motivation and see what you think is best to do. I'd
> > like to be able to provide just the transfer_one operation, and use
> > the generic transfer_one_message. However, at 50 MHz cpu clock, the
> > stats collection and other overhead in spi.c's generic
> > spi_transfer_one_message takes up so much time between the end of one
> > SD card transfer and the beginning of the next that the overall
> > transfer rate is something like 15-20% higher with my version.
> 
> No, this is just not a good approach.  If the generic code isn't working
> for you improve the generic code, don't just copy it and open code the
> bits you like.  The reason Linux has all these great framework is that
> people collaborate to make the generic code as good and fully featured
> as they can rather than open coding everything in drivers.  Doing things
> in drivers results in lots of code duplication which increases the cost
> of maintaining things and requires that everyone waste time copying code
> in order to keep the feature set consistent between drivers.

I totally agree with this principle, and I'm fine with dropping the
offending code. I may maintain it out-of-tree as a performance patch
for a while, but DMA and other improvements will hopefully make it
unnecessary.

> > Another consideration is that DMA support is being added to the
> > hardware right now, and I think we're going to want to be able to
> > queue up whole messages for DMA rather than just individual transfers;
> > in that case, spi_transfer_one_message is probably not suitable
> > anyway. So we'll probably have to end up having our own
> > transfer_one_message function anyway.
> 
> This is again a simple generic optimisation which would be best
> implemented in generic code - it's not just this device which would
> benefit from the ability to coalesce compatible transfers.  There is no
> reason for individual drivers to even think about such an optimisation,
> the core should just be handling them a transfer with a coalesced DMA
> transfer in it.  We're not doing it at present because someone needs to
> take the time to write the code that figures out if adjacent transfers
> are compatible and merges them if they are.

OK, then let's go with that approach. As long as there's a viable way
forward for doing it in a way that benefits all devices/drivers, I
prefer it anyway. I just didn't want to hit a situation where I later
propose that and a mainainer (you or someone else) tells me it's not
possible or not necessary.

Rich
