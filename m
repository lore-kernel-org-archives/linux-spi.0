From: Grant Likely <grant.likely@secretlab.ca>
Subject: [git pull] one more spi bugfix for 2.6.37
Date: Wed, 29 Dec 2010 18:45:14 -0700
Message-ID: <AANLkTimc2U==zvuRU67Bohsb5uCNjD8fX-6s7EefY6EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

Here is one more spi bug fix for .37

The following changes since commit 387c31c7e5c9805b0aef8833d1731a5fe7bdea14:

  Linux 2.6.37-rc8 (2010-12-28 17:05:48 -0800)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 merge-spi

Gregory CLEMENT (1):
      spi/omap2_mcspi.c: Force CS to be in inactive state after
off-mode transition

 drivers/spi/omap2_mcspi.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
