From: Grant Likely <grant.likely@secretlab.ca>
Subject: [git pull] spi bug fix for v3.3
Date: Fri, 13 Jan 2012 22:55:50 -0700
Message-ID: <CACxGe6s_2UUR575etRFp+R0_xx9Q1H8QMTSvbwp6YPYLvuSOoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	spi-devel-general@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

Here's a tiny tegra spi bug fix.  Please pull.

Thanks,
g.

The following changes since commit 2145199c4f0db7c517dd788abec301dc84b91bd0:

  Merge branch 'drm-fixes' of
git://people.freedesktop.org/~airlied/linux (2012-01-13 20:48:42
-0800)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 spi-for-linus

Olof Johansson (1):
      spi/tegra: depend instead of select TEGRA_SYSTEM_DMA

 drivers/spi/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
