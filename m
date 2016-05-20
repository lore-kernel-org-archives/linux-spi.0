From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v2 10/12] spi: add driver for J-Core SPI controller
Date: Fri, 20 May 2016 19:24:14 -0400
Message-ID: <20160520232414.GY21636@brightrain.aerifal.cx>
References: <cover.1463708766.git.dalias@libc.org>
 <2e287ca758002621ef8eed3db9df37678e26af5e.1463708766.git.dalias@libc.org>
 <20160520102317.GH8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160520102317.GH8206@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 20, 2016 at 11:23:17AM +0100, Mark Brown wrote:
> On Fri, May 20, 2016 at 02:53:04AM +0000, Rich Felker wrote:
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > ---
> > My previous post of the patch series accidentally omitted omitted
> > Cc'ing of subsystem maintainers for the necessary clocksource,
> > irqchip, and spi drivers. Please ack if this looks ok because I want
> > to get it merged as part of the arch/sh pull request for 4.7.
> 
> This is *extremely* late for a first posting of a driver for v4.7 (you
> missed the list as well as the maintainers).

I'm sorry for the mix-up. The kernel workflow is still fairly new to
me and I've been fighting with git format-patch/send-email and
get_maintainer.pl to get big patch series prepared the way I want and
sent to the right people/lists. I think I've got it right now though.

> > +static void jcore_spi_chipsel(struct spi_device *spi, bool value)
> > +{
> > +	struct jcore_spi *hw = spi_master_get_devdata(spi->master);
> > +
> > +	pr_debug("%s: CS=%d\n", __func__, value);
> 
> dev_dbg()

OK.

> > +	hw->csReg = ( JCORE_SPI_CTRL_ACS | JCORE_SPI_CTRL_CCS | JCORE_SPI_CTRL_DCS )
> > +		^ (!value << 2*spi->chip_select);
> 
> Why the xor here and not an or?  The coding style is also weird, a mix
> of extra spaces around the () and missing ones around *.  I'm finding
> the intent of the code confusing here.

The intent is to set all chipselect bits (the 3 macro values) high
except possibly spi->chip_select. The xor is to turn off a bit, not
turn it on. &~ would also have worked; would that be more idiomatic?

Since the individual CS bits and their names in the hardware aren't
actually relevant to the driver, I'm replacing them with a single:

#define JCORE_SPI_CTRL_CS_BITS          0x15

so I can just write:

hw->csReg = JCORE_SPI_CTRL_CS_BITS ^ (!value << 2*spi->chip_select);

Does that look better, or should I opt for &~?

> > +static int jcore_spi_txrx(struct spi_master *master, struct spi_device *spi, struct spi_transfer *t)
> 
> Coding style, please keep lines under 80 columns unless there's a good
> reason.

OK.

> > +#if !USE_MESSAGE_MODE
> > +	spi_finalize_current_transfer(master);
> > +#endif
> 
> I'm not sure what the if is about but it doesn't belong upstream, you
> shouldn't be open coding bits of the framework.

I can explain the motivation and see what you think is best to do. I'd
like to be able to provide just the transfer_one operation, and use
the generic transfer_one_message. However, at 50 MHz cpu clock, the
stats collection and other overhead in spi.c's generic
spi_transfer_one_message takes up so much time between the end of one
SD card transfer and the beginning of the next that the overall
transfer rate is something like 15-20% higher with my version.

Another consideration is that DMA support is being added to the
hardware right now, and I think we're going to want to be able to
queue up whole messages for DMA rather than just individual transfers;
in that case, spi_transfer_one_message is probably not suitable
anyway. So we'll probably have to end up having our own
transfer_one_message function anyway.

If that's not actually needed, a possible alternative for fixing the
performance problem might be adding a Kconfig option to turn off all
the unnecessary overhead (stats, etc.) in spi_transfer_one_message. I
could work on that instead (or in addition), and I wouldn't consider
it critical to get in for this merge window.

> > +	/* register our spi controller */
> > +	err = spi_register_master(master);
> 
> devm_
> 
> > +static int jcore_spi_remove(struct platform_device *dev)
> > +{
> > +	struct jcore_spi *hw = platform_get_drvdata(dev);
> > +	struct spi_master *master = hw->master;
> > +
> > +	platform_set_drvdata(dev, NULL);
> > +	spi_master_put(master);
> > +	return 0;
> > +}
> 
> This can be removed entirely.

OK. Does using the devm register function cause removal to be handled
generically, or is there another reason it's not needed?

> > +static const struct of_device_id jcore_spi_of_match[] = {
> > +	{ .compatible = "jcore,spi2" },
> > +	{},
> > +};
> 
> This is adding a DT binding with no binding document.  All new DT
> bindings need to be documented.

The DT binding was in patch 05/12. Should linux-spi have been added to
the Cc list for it? get_maintainer.pl didn't include it.

> > +		.owner = THIS_MODULE,
> > +		.pm = NULL,
> 
> No need to set either of these.

OK.

Rich
