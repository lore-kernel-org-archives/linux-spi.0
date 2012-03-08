From: Grant Likely <grant.likely@secretlab.ca>
Subject: [git pull] spi section mismatch bug fix
Date: Thu, 8 Mar 2012 11:31:48 -0700
Message-ID: <CACxGe6tUg9ahP=9XE3KJQA-UJtfyT3a_Gb3fU-2mC53DJe1KAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

Here's one more bug fix for spi.

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 spi-for-linus

for you to fetch changes up to a5ab6291b1fc73e0dc71caf2eaa0de1de7b11aaa:

  Fix section mismatch in spi-pl022.c (2012-02-13 11:57:58 -0700)

----------------------------------------------------------------
SPI section mismatch bug fix for v3.3-rc3

Russell King (1):
      Fix section mismatch in spi-pl022.c

Minor fix for pl022_dma_probe() function which was put in the wrong section.

----------------------------------------------------------------
Russell King (1):
      Fix section mismatch in spi-pl022.c

 drivers/spi/spi-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
