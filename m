From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] spi: intel_mid_ssp_spi: new SPI driver for intel
 Medfield platform
Date: Thu, 3 Feb 2011 15:04:32 +0000
Message-ID: <20110203150432.40cd74c4@lxorguk.ukuu.org.uk>
References: <1296680512-2758-2-git-send-email-russ.gorby@intel.com>
	<20110202224054.7916e7af@lxorguk.ukuu.org.uk>
	<20110203132800.GA17825@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Russ Gorby <russ.gorby@intel.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	"open list:SPI SUBSYSTEM" <spi-devel-general@lists.sourceforge.net>,
	open list <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110203132800.GA17825@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 3 Feb 2011 13:28:00 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Feb 02, 2011 at 10:40:54PM +0000, Alan Cox wrote:
> 
> > And this is the unified one that handles all the devices, but I gather
> > may need some fixing/test work on Medfield.
> 
> I've got the same question here as I had with Russ' patch: it looks like
> there's some overlap with the SSP ports used for audio (it's just a
> generic programmable serial port so even if it's not normally used for
> audio that's a possiblity), how is that handled?

The SSP has PCI configuration indicating how it is being assigned, which
is in vendor capability byte 6. The low 3 bits indicte the mode, where
mode 1 is an SPI master/slave, and in that case bit 6 is set for a slave.

The SSP/SPI driver will only grab ports that have been assigned to that
purpose as part of the system design.

I'm just putting the other bits from the generic driver back into the
more featured/tested specific driver that Russ posted.

Alan
