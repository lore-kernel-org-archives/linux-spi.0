From: Grant Likely <grant.likely@secretlab.ca>
Subject: [git pull] SPI changes for v3.3-rc2
Date: Sun, 5 Feb 2012 23:28:15 -0700
Message-ID: <CACxGe6uf6BpnHUFF7Svx_-C+ZGFop3T=TGGRi8kFQCgH56E4yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus

A couple of minor SPI fixes.  Description in signed tag.  Please pull.

g.

The following changes since commit 23783f817bceedd6d4e549385e3f400ea64059e5:

  Merge tag 'pm-fixes-for-3.3-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
(2012-02-04 15:21:39 -0800)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 spi-for-linus

Danny Kukawka (1):
      spi-topcliff-pch: rename pch_spi_pcidev to pch_spi_pcidev_driver

Sylwester Nawrocki (1):
      spi: Add spi-s3c64xx driver dependency on ARCH_EXYNOS4

 drivers/spi/Kconfig            |    2 +-
 drivers/spi/spi-topcliff-pch.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
