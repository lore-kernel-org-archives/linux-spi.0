From: Grant Likely <grant.likely@secretlab.ca>
Subject: [GIT PULL] spi driver bug fixes
Date: Tue, 4 Oct 2011 10:14:41 -0600
Message-ID: <CACxGe6uPnXm4Ehk0Bwss_B48j3oUtE1L8SSTyCE6nC2b9K0hhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Tomoya MORINAGA <morinaga526@dsn.oki
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

Here are some bug fixes for the topcliff spi driver.

Tomoya, are these applicable for the stable tree?

The following changes since commit 0f86267b79bc6e357b8606077c7f70239045ea9c:

  Merge branch 'hwmon-for-linus' of git://github.com/groeck/linux
(2011-10-03 12:54:56 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 spi/merge

Tomoya MORINAGA (5):
      spi-topcliff-pch: add tx-memory clear after complete transmitting
      spi-topcliff-pch: Fix SSN Control issue
      spi-topcliff-pch: Fix CPU read complete condition issue
      spi-topcliff-pch: Add recovery processing in case FIFO overrun
error occurs
      spi-topcliff-pch: Fix overrun issue

 drivers/spi/spi-topcliff-pch.c |   93 ++++++++++++++++++++++++++++------------
 1 files changed, 66 insertions(+), 27 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
