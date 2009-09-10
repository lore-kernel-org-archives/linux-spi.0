From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: i.MX SPI driver
Date: Fri, 11 Sep 2009 01:33:03 +0200
Message-ID: <20090910233303.GP9361@buzzloop.caiaq.de>
References: <1245235220-23816-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1245235220-23816-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 17, 2009 at 12:40:18PM +0200, Sascha Hauer wrote:
> The new i.MX SPI driver has been posted twice on the list, I received no
> objections from anyone, so please consider pulling the following branch

What happened to these patches, have they been picked up? I just tested
them on a Lilly1131 board and they seem to work fine.

Thanks,
Daniel

> The following changes since commit 65795efbd380a832ae508b04dba8f8e53f0b84d9:
>   Linus Torvalds (1):
>         Merge branch 'next-i2c' of git://aeryn.fluff.org.uk/bjdooks/linux
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/sha/linux-2.6.git for-david
> 
> Sascha Hauer (2):
>       remove i.MX SPI driver
>       SPI: Add SPI driver for most known i.MX SoCs
> 
>  arch/arm/plat-mxc/include/mach/spi.h |   27 +
>  drivers/spi/Kconfig                  |    7 +-
>  drivers/spi/Makefile                 |    2 +-
>  drivers/spi/mxc_spi.c                |  685 +++++++++++++
>  drivers/spi/spi_imx.c                | 1779 ----------------------------------
>  5 files changed, 717 insertions(+), 1783 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/spi.h
>  create mode 100644 drivers/spi/mxc_spi.c
>  delete mode 100644 drivers/spi/spi_imx.c

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
