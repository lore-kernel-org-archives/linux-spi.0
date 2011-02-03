From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] spi: intel_mid_ssp_spi: new SPI driver for intel
	Medfield platform
Date: Thu, 3 Feb 2011 13:28:00 +0000
Message-ID: <20110203132800.GA17825@sirena.org.uk>
References: <1296680512-2758-2-git-send-email-russ.gorby@intel.com> <20110202224054.7916e7af@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russ Gorby <russ.gorby@intel.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	"open list:SPI SUBSYSTEM" <spi-devel-general@lists.sourceforge.net>,
	open list <linux-kernel@vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110202224054.7916e7af@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 02, 2011 at 10:40:54PM +0000, Alan Cox wrote:

> And this is the unified one that handles all the devices, but I gather
> may need some fixing/test work on Medfield.

I've got the same question here as I had with Russ' patch: it looks like
there's some overlap with the SSP ports used for audio (it's just a
generic programmable serial port so even if it's not normally used for
audio that's a possiblity), how is that handled?
