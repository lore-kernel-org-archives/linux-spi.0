From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] spi: intel_mid_ssp_spi: new SPI driver for intel
 Medfield platform
Date: Wed, 2 Feb 2011 22:26:52 +0000
Message-ID: <20110202222652.6b811f56@lxorguk.ukuu.org.uk>
References: <[PATCH 0/1] Adding intel_mid_ssp_spi driver : 01/27/2011>
	<1296680512-2758-2-git-send-email-russ.gorby@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net> (maintainer:SPI
	SUBSYSTEM),
	Grant Likely <grant.likely@secretlab.ca> (maintainer:SPI SUBSYSTEM),
	spi-devel-general@lists.sourceforge.net (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
To: Russ Gorby <russ.gorby@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296680512-2758-2-git-send-email-russ.gorby@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed,  2 Feb 2011 13:01:52 -0800
Russ Gorby <russ.gorby@intel.com> wrote:

> SPI master controller driver for the Intel MID platform Medfield
> This driver uses the Penwell SSP controller and configures it to
> be a SPI device (spibus 3). This bus supports a single device -
> the 3G SPI modem that can operate up to 25Mhz.

NAK this.

We have an existing development driver that covers 0x0815, 0x0816, 0x0825,
0x0832 in a single driver which needs tidying up and double checking on
all the relevant Medfield and Moorestown devices and is based on work done
by Mathieu Soulard.

All these devices can be handled by a single driver, and should be.

Alan
