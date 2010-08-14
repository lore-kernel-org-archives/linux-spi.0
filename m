From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [git pull] spi tree
Date: Sat, 14 Aug 2010 01:04:04 -0600
Message-ID: <AANLkTikg_wcz4OKZn14TwJh5qZiGZ_4sN-955fLgrRuz@mail.gmail.com>
References: <AANLkTimMR6_zuA8BRy+ZcDQS0o7N5h4u9PikoqAhxisO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>,
	Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimMR6_zuA8BRy+ZcDQS0o7N5h4u9PikoqAhxisO-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

I haven't heard anything either way on my spi branch, so I'm assuming
it just got lost in the shuffle.  Here is a resend of the spi tree
pull request.

Thanks,
g.


---------- Forwarded message ----------
From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Date: Tue, Aug 3, 2010 at 1:01 AM

Hi Linus,

Here are the spi driver changes queued up for 2.6.36.

Cheers,
g.

The following changes since commit 9fe6206f400646a2322096b56c59891d530e8d51:
=A0Linus Torvalds (1):
=A0 =A0 =A0 =A0Linux 2.6.35

are available in the git repository at:

=A0git://git.secretlab.ca/git/linux-2.6 next-spi

Anatolij Gustschin (1):
=A0 =A0 =A0spi/mpc5121: change annotations for probe and remove functions

Brian Niebuhr (1):
=A0 =A0 =A0spi/bitbang: reinitialize transfer parameters for every message

Cory Maccarrone (1):
=A0 =A0 =A0SPI100k: Fix 8-bit and RX-only transfers

Ernst Schwab (2):
=A0 =A0 =A0spi/mmc_spi: SPI bus locking API, using mutex
=A0 =A0 =A0spi/mmc_spi: mmc_spi adaptations for SPI bus locking API

Grant Likely (1):
=A0 =A0 =A0Merge commit 'v2.6.35-rc6' into spi/test

Kevin Wells (1):
=A0 =A0 =A0spi/amba_pl022: Fix probe and remove hook section annotations.

Marek Szyprowski (2):
=A0 =A0 =A0spi/bitbang: add support for SPI_MASTER_NO_{TX, RX} modes
=A0 =A0 =A0spi/spi-gpio: add support for controllers without MISO or MOSI p=
in

=A0drivers/mmc/host/mmc_spi.c =A0 =A0 | =A0 59 ++---------
=A0drivers/spi/amba-pl022.c =A0 =A0 =A0 | =A0 =A06 +-
=A0drivers/spi/mpc512x_psc_spi.c =A0| =A0 16 ++--
=A0drivers/spi/omap_spi_100k.c =A0 =A0| =A0 23 ++--
=A0drivers/spi/spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0225 ++++++++++++++++++=
++++++++++++++++------
=A0drivers/spi/spi_bitbang.c =A0 =A0 =A0| =A0 =A09 +-
=A0drivers/spi/spi_bitbang_txrx.h | =A0 16 ++-
=A0drivers/spi/spi_butterfly.c =A0 =A0| =A0 =A02 +-
=A0drivers/spi/spi_gpio.c =A0 =A0 =A0 =A0 | =A0109 +++++++++++++++----
=A0drivers/spi/spi_lm70llp.c =A0 =A0 =A0| =A0 =A02 +-
=A0drivers/spi/spi_s3c24xx_gpio.c | =A0 =A08 +-
=A0drivers/spi/spi_sh_sci.c =A0 =A0 =A0 | =A0 =A08 +-
=A0include/linux/spi/spi.h =A0 =A0 =A0 =A0| =A0 12 ++
=A0include/linux/spi/spi_gpio.h =A0 | =A0 =A05 +
=A014 files changed, 353 insertions(+), 147 deletions(-)


--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
