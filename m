From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH 0/2] spi: spidev: Fix messages in spidev
Date: Sat, 29 Feb 2020 18:18:39 +0200
Message-ID: <20200229161841.89144-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


- fix the values source for the xfer debug message.
- fix the "max speed setting" message showing.



Oleksandr Suvorov (2):
  spi: spidev: fix a debug message value
  spi: spidev: fix speed setting message

 drivers/spi/spidev.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.24.1
