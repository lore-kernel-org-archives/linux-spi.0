From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH 0/1] Fix shared IRQ behavior in spi-fsl-dspi
Date: Fri, 23 Aug 2019 00:24:49 +0300
Message-ID: <20190822212450.21420-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch is taken out of the "Poll mode for NXP DSPI driver" series
and respun against the "for-4.20" branch.
$(git describe --tags 13aed2392741) shows:
v4.20-rc1-18-g13aed2392741

Vladimir Oltean (1):
  spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not ours

 drivers/spi/spi-fsl-dspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1
