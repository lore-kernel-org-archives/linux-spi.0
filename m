From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [RFC 0/2] sysfs new_id file support for spidev
Date: Mon, 18 Apr 2016 16:48:26 +0530
Message-ID: <1460978308-8062-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <gregkh@linuxfoundation.org>, <stefan@agner.ch>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patchset adds support for loading spidev via sysfs new_id file.
Any comments/suggestions welcome!

Bhuvanchandra DV (2):
  spi: spidev: Use 'new_id' sysfs file for enabling spidev
  spi core: Add new sysfs 'num_chipselect' file

 Documentation/ABI/testing/sysfs-bus-spi-spidev |  8 +++
 Documentation/spi/spi-summary                  |  3 ++
 drivers/spi/spi.c                              | 23 ++++++++
 drivers/spi/spidev.c                           | 75 +++++++++++++++++++++++---
 4 files changed, 103 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-spi-spidev

-- 
2.7.3
