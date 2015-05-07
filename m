From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH v3] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Thu, 7 May 2015 14:20:19 -0500
Message-ID: <20150507192019.GA15112@deathray>
References: <1430955472-11409-1-git-send-email-mwelling@ieee.org>
 <20150507185831.GQ22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150507185831.GQ22845@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 07, 2015 at 07:58:31PM +0100, Mark Brown wrote:
> On Wed, May 06, 2015 at 06:37:52PM -0500, Michael Welling wrote:
> > This patch allows for GPIOs specified in the devicetree to be used as SPI
> > chipselects on TI OMAP2 SoCs.
> > 
> > Tested on the AM3354.
> > 
> > Signed-off-by: Michael Welling <mwelling@ieee.org>
> > ---
> > v3: Switches driver to use transfer_one instead of transfer_one_message
> > allowing the spi core to handle toggling GPIO chip selects if specified.
> 
> This is now two changes so it should be two patches, one converting to
> transfer_one() and another adding the GPIO chip select support.  This
> makes things easier to review and helps people trying to understand the
> git history in the future (right now there's not even a mention of the
> conversion to transfer_one() in the changelog).

Okay. I will break it down into a patch series.

Do you have any other suggestions or comments on the patch so that I
can incorporate those changes as well in the patch series?

I noticed a few oddities in the code when converting.

For instance:
http://lxr.free-electrons.com/source/drivers/spi/spi-omap2-mcspi.c#L1225

What is the point of trying to print tx or rx given the if statement
insures that rx_buff and tx_buff are NULL?
