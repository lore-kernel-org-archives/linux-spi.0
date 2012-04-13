From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [GIT PULL] SPI bug fixes needed on v3.4-rc2
Date: Fri, 13 Apr 2012 12:16:26 -0600
Message-ID: <CACxGe6t-YGz==WE3-0Kf3=6jjc6BSMN-8wepOBwJ2S0j5N0=xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Linus

Simple set of bug fixes.  Please pull

g.

The following changes since commit f52b69f86e27903d6896ed5fa7cd280fec8de532:

  Merge tag 'sh-for-linus' of git://github.com/pmundt/linux-sh
(2012-03-30 00:09:17 -0700)

are available in the git repository at:


  git://git.secretlab.ca/git/linux-2.6 tags/spi-for-linus

for you to fetch changes up to 39ec0d38141b198f94fd19c2bb10fd7c616510d2:

  spi/imx: prevent NULL pointer dereference in spi_imx_probe()
(2012-04-10 22:17:15 -0600)

----------------------------------------------------------------
SPI bug fixes on top of v3.4-rc2

Miscellaneous driver bug fixes.  No major changes in this branch.

----------------------------------------------------------------
Kenth Eriksson (1):
      spi/mpc83xx: fix NULL pdata dereference bug

Lothar Wa=DFmann (1):
      spi/imx: prevent NULL pointer dereference in spi_imx_probe()

Shubhrajyoti D (1):
      spi/davinci: Fix DMA API usage in davinci

Uwe Kleine-K=F6nig (1):
      spi/imx: mark base member in spi_imx_data as __iomem

Viresh Kumar (1):
      spi/pL022: include types.h to remove compilation warnings

 drivers/spi/spi-davinci.c  |    6 +++---
 drivers/spi/spi-fsl-spi.c  |    4 +++-
 drivers/spi/spi-imx.c      |   12 ++++++++----
 include/linux/amba/pl022.h |    2 ++
 4 files changed, 16 insertions(+), 8 deletions(-)


-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
