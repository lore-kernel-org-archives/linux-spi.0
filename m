From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/4] spi: npcm-pspi: improve preformance modify reset and fix issue
Date: Wed, 15 Jan 2020 18:22:57 +0200
Message-ID: <20200115162301.235926-1-tmaimon77@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch set modify Perphiral SPI NPCM driver as follow:
	
	- Improve transfer performance.
	- Fix 16 bit send and receive support.
	- Modify dt-binding documentation to support reset controller driver.
	- Modify reset support to use reset controller driver
	  NPCM reset driver: https://lkml.org/lkml/2019/11/7/429.

Tomer Maimon (4):
  spi: npcm-pspi: fix 16 bit send and receive support
  spi: npcm-pspi: improve spi transfer performance
  dt-binding: spi: add NPCM PSPI reset binding
  spi: npcm-pspi: modify reset support

 .../bindings/spi/nuvoton,npcm-pspi.txt        | 12 +---
 drivers/spi/spi-npcm-pspi.c                   | 57 +++++++++----------
 2 files changed, 29 insertions(+), 40 deletions(-)

-- 
2.22.0
