From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/2] spi: Fix make htmldocs issues
Date: Thu, 10 Mar 2016 15:01:12 -0300
Message-ID: <1457632874-11250-1-git-send-email-javier@osg.samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

The make htmldocs target is broken in today's next (next-20160310) and
this is caused by an error in the SPI kernel-doc.

This small series fix that SPI kernel-doc error and also a warning that
I noticed when the docs were finally built.

Best regards,
Javier


Javier Martinez Canillas (2):
  spi: Fix htmldocs build error due struct spi_replaced_transfers
  spi: Add gfp parameter to kernel-doc to fix build warning

 drivers/spi/spi.c       | 1 +
 include/linux/spi/spi.h | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.5.0
