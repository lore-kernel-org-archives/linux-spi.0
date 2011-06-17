From: Grant Likely <grant.likely@secretlab.ca>
Subject: [GIT PULL] spi fixes for v3.0-rc3
Date: Fri, 17 Jun 2011 09:04:53 -0600
Message-ID: <BANLkTikTPiqJZe1WeToBckWTPf_YYqRbew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The following changes since commit 2c53b436a30867eb6b47dd7bab23ba638d1fb0d2:

  Linux 3.0-rc3 (2011-06-13 15:29:59 -0700)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 spi/merge

Mike Frysinger (1):
      spi/bfin_spi: fix handling of default bits per word setting

 drivers/spi/spi_bfin5xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
