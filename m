From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 0/5] spi-imx: some updates
Date: Tue, 8 Dec 2009 15:32:39 -0800
Message-ID: <20091208153239.af0b5bb8.akpm@linux-foundation.org>
References: <20091208211258.GA13706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20091208211258.GA13706-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 8 Dec 2009 22:12:58 +0100
Uwe Kleine-K__nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:

> this series depends on "spi: drain MXC SPI transfer buffer when probing
> device" which is currently in -mm and also included in my spi-imx branch
> (see below).  IMHO at least my first patch should go into .33 as it
> fixes an oops.

I queued all five for 2.6.33.


Once I've merged up the current -mm patch queue:

atmel_spi-fix-dma-addr-calculation-for-len-buffer_size.patch
spi-controller-driver-for-designware-spi-core.patch
#
spi-add-pci-interface-driver-for-designware-spi-core.patch
spi-add-pci-interface-driver-for-designware-spi-core-fix.patch
spi-controller-driver-for-designware-spi-core-fix.patch
#
spidev-add-proper-section-markers.patch
spidev-use-declare_bitmap-instead-of-declaring-the-array.patch
spidev-use-declare_bitmap-instead-of-declaring-the-array-checkpatch-fixes.patch
spi-drain-mxc-spi-transfer-buffer-when-probing-device.patch
spi_s3c24xx-add-fiq-pseudo-dma-support.patch
spi-superh-msiof-spi-master-driver.patch
spi-superh-msiof-spi-master-driver-update.patch
spi-nuc900-add-arm-driver-support-for-nuc900.patch
spi-fix-spidev-compilation-failure-when-verbose-is-defined.patch
#
spi-imx-use-platform_driver_probe-as-probe-lives-in-inittext.patch
spi-imx-correct-check-for-platform_get_irq-failing.patch
spi-imx-use-positive-logic-to-distinguish-cpu-variants.patch
spi-imx-add-mx25-support.patch
spi-imx-dont-access-struct-device-directly-but-use-dev_get_platdata.patch


I shall stop sending SPI patches to Linus.  I'll send any which I
accumulate to Grant instead.



------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
