From: Grant Likely <grant.likely@secretlab.ca>
Subject: [git pull] last device tree and spi changes for 2.6.39 merge window
Date: Wed, 23 Mar 2011 23:54:36 -0600
Message-ID: <AANLkTi=_o_WPfvH7jh9zr87+JXT4wRsVEzUzMvrgOrgf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andres Salomon <dilinger@queued.net>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

A few last patches for .39.  It's such a small set that I put them all
into one branch.  Please pull!

Thanks,
g.

The following changes since commit 4bbba111d94781d34081c37856bbc5eb33f6c72a:

  Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
(2011-03-23 07:58:09 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 devicetree/merge

Andres Salomon (1):
      of/flattree: minor cleanups

Grant Likely (3):
      dt: Refactor of_platform_bus_probe()
      dt: protect against NULL matches passed to of_match_node()
      dt: eliminate OF_NO_DEEP_PROBE and test for NULL match table

Jarkko Nikula (1):
      spi/omap_mcspi: Fix broken last word xfer

Philippe Langlais (1):
      spi/pl022: Add loopback support for the SPI on 5500

 drivers/of/base.c           |    3 ++
 drivers/of/fdt.c            |    6 ++-
 drivers/of/platform.c       |   72 ++++++++++++++-----------------------------
 drivers/spi/amba-pl022.c    |   20 +++++++++++-
 drivers/spi/omap2_mcspi.c   |    6 ++--
 include/linux/of_platform.h |    3 --
 6 files changed, 52 insertions(+), 58 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
