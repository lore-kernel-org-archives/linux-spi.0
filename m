From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] spi: intel_mid_ssp_spi: new SPI driver for intel
	Medfield platform
Date: Wed, 2 Feb 2011 21:03:39 +0000
Message-ID: <20110202210339.GJ9810@sirena.org.uk>
References: <1296680512-2758-2-git-send-email-russ.gorby@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	"open list:SPI SUBSYSTEM" <spi-devel-general@lists.sourceforge.net>,
	open list <linux-kernel@vger.kernel.org>
To: Russ Gorby <russ.gorby@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1296680512-2758-2-git-send-email-russ.gorby@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 02, 2011 at 01:01:52PM -0800, Russ Gorby wrote:
> SPI master controller driver for the Intel MID platform Medfield
> This driver uses the Penwell SSP controller and configures it to
> be a SPI device (spibus 3). This bus supports a single device -
> the 3G SPI modem that can operate up to 25Mhz.

The same hardware is also used for audio I believe - how do the two
drivers share the hardware?

> +#define SSCR0_DSS   (0x0000000f)     /* Data Size Select (mask) */
> +#define SSCR0_DataSize(x)  ((x) - 1)	/* Data Size Select [4..16] */
> +#define SSCR0_FRF   (0x00000030)     /* FRame Format (mask) */
> +#define SSCR0_Motorola	      (0x0 << 4)	 /* Motorola's SPI mode */
> +#define SSCR0_ECS   (1 << 6) /* External clock select */
> +#define SSCR0_SSE   (1 << 7) /* Synchronous Serial Port Enable */

There certainly looks to be overlap with the register definitions.
