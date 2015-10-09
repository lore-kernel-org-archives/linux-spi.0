From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: disable other channels CHCONF_FORCE
 in prepare_message
Date: Fri, 9 Oct 2015 10:45:25 -0500
Message-ID: <20151009154525.GB1114@deathstar>
References: <5617C57D.9080902@baylibre.com>
 <20151009152622.GA1114@deathstar>
 <5617DD56.1070608@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fionn Cleary <clearyf@tcd.ie>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5617DD56.1070608@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 09, 2015 at 05:29:26PM +0200, Neil Armstrong wrote:
> On 10/09/2015 05:26 PM, Michael Welling wrote:
> > On Fri, Oct 09, 2015 at 03:47:41PM +0200, Neil Armstrong wrote:
> >> Since the "Switch driver to use transfer_one" change, the cs_change
> >> behavior has changed and a channel chip select can still be
> >> asserted when changing channel from a previous last transfer in a
> >> message having the cs_change attribute.
> >>
> >> Since there is no sense having multiple chip select being asserted at the
> >> same time, disable all the remaining forced chip selects in a the
> >> prepare_message called right before a spi_transfer_one_message call.
> >> It ignores the current channel configuration in order to keep the
> >> possibility to leave the chip select asserted between messages.
> >>
> >> It fixes this bug on a DM8168 SoC ES2.1 Soc and an OMAP4 ES2.1 SoC.
> >> It was hanging all the other channels transfers when a CHCONF_FORCE
> >> is present on the wrong channel.
> >>
> >> Fixes: b28cb9414db9 ("spi: omap2-mcspi: Switch driver to use transfer_one")
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/spi/spi-omap2-mcspi.c | 28 ++++++++++++++++++++++++++++
> >>  1 file changed, 28 insertions(+)
> >>
> >> Test code can be found on :
> >> http://pastebin.com/0SrqbGP7
> >>
> >> Before patch :
> >> # ./test_spi
> >> cs_change_command() start
> >> spidev1.3 ioctl success
> >> no_dma_command() start
> >> [   59.790069] spidev spi1.1: TXS timed out
> >> spidev1.1 ioctl success
> >> cs_change_command() start
> >> [   60.798736] spidev spi1.3: RXS timed out
> >> spidev1.3 ioctl success
> >> no_dma_command() start
> >> [   61.802032] spidev spi1.1: TXS timed out
> >> spidev1.1 ioctl success
> >> cs_change_command() start
> >> [   62.807525] spidev spi1.3: RXS timed out
> >> spidev1.3 ioctl success
> >> no_dma_command() start
> >> [   63.812042] spidev spi1.1: TXS timed out
> >> spidev1.1 ioctl success
> >> ...
> >>
> >> After Patch :
> >> # ./test_spi
> >> cs_change_command() start
> >> spidev1.3 ioctl success
> >> no_dma_command() start
> >> spidev1.1 ioctl success
> >> cs_change_command() start
> >> spidev1.3 ioctl success
> >> no_dma_command() start
> >> spidev1.1 ioctl success
> >> cs_change_command() start
> >> spidev1.3 ioctl success
> >> ...
> >>
> >> v2: uses msg to leave asserted chip select for the current channel
> >>
> >> This is a patch RFC following the bug report :
> >> 'McSPI hangs with cs_change after "Switch driver to use transfer_one" change'
> >> http://permalink.gmane.org/gmane.linux.kernel/2056841
> >>
> >> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> >> index 3d09e0b..1f8903d 100644
> >> --- a/drivers/spi/spi-omap2-mcspi.c
> >> +++ b/drivers/spi/spi-omap2-mcspi.c
> >> @@ -1217,6 +1217,33 @@ out:
> >>  	return status;
> >>  }
> >>
> >> +static int omap2_mcspi_prepare_message(struct spi_master *master,
> >> +				       struct spi_message *msg)
> >> +{
> >> +	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
> >> +	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
> >> +	struct omap2_mcspi_cs	*cs;
> >> +
> > 
> > Do we need the pm_runtime_get_sync code here?
> > See previous commit.
> > 
> 
> I checked and prepare_message is only called after pm_rumtime_get_sync in __spi_pump_messages()

Okay, I see it now.

Reviewed-by: Michael Welling <mwelling@ieee.org>

> 
> Neil
