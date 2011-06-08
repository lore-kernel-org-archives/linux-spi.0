From: Grant Likely <grant.likely@secretlab.ca>
Subject: [GIT PULL] spi bug fixes for v3.0
Date: Wed, 8 Jun 2011 14:38:26 -0600
Message-ID: <BANLkTikmjG6oXHRMe=oZx3i6RhXdupBpLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The following changes since commit 59c5f46fbe01a00eedf54a23789634438bb80603:

  Linux 3.0-rc2 (2011-06-06 18:06:33 +0900)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 spi/merge

Geert Uytterhoeven (1):
      spi/rtc-m41t93: Use spi_get_drvdata() for SPI devices

Govindraj.R (1):
      spi/omap2: fix uninitialized variable

 drivers/rtc/rtc-m41t93.c  |    2 +-
 drivers/spi/omap2_mcspi.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
