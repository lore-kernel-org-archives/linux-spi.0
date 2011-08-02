From: Grant Likely <grant.likely@secretlab.ca>
Subject: [GIT PULL] an spi bug fix
Date: Tue, 2 Aug 2011 17:01:47 +0100
Message-ID: <CACxGe6scX-2jv9MuuNUMZZ1u_mOwe79FxFdm2BOt=V-GNhNs8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	Linus Walleij <linus.walleij@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The following changes since commit 5f66d2b58ca879e70740c82422354144845d6dd3:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6
(2011-08-01 06:14:25 -1000)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 spi/next

Linus Walleij (1):
      spi/pl022: remove function cannot exit

 drivers/spi/spi-pl022.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
