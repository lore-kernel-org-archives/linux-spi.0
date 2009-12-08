From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 0/5] spi-imx: some updates
Date: Tue, 8 Dec 2009 22:12:58 +0100
Message-ID: <20091208211258.GA13706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

this series depends on "spi: drain MXC SPI transfer buffer when probing
device" which is currently in -mm and also included in my spi-imx branch
(see below).  IMHO at least my first patch should go into .33 as it
fixes an oops.

I'll post the patches for review as a reply to this mail.

Best regards
Uwe

The following changes since commit 6035ccd8e9e40bb654fbfdef325902ab531679a5:
  Linus Torvalds (1):
        Merge branch 'for-2.6.33' of git://git.kernel.dk/linux-2.6-block

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git spi-imx

Daniel Mack (1):
      spi: drain MXC SPI transfer buffer when probing device

Sascha Hauer (1):
      spi-imx: Add mx25 support

Uwe Kleine-K=F6nig (4):
      spi-imx: use platform_driver_probe as probe lives in .init.text
      spi-imx: correct check for platform_get_irq failing
      spi-imx: use positive logic to distinguish cpu variants
      spi-imx: don't access struct device directly but use dev_get_platdata

 drivers/spi/spi_imx.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)
-- =

Pengutronix e.K.                              | Uwe Kleine-K=F6nig         =
   |
Industrial Linux Solutions                    | http://www.pengutronix.de/ =
 |

---------------------------------------------------------------------------=
---
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
