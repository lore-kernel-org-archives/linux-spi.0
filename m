From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
Date: Thu,  8 Sep 2016 09:53:24 +0200
Message-ID: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, carlo@caione.org, khilman@baylibre.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patchset adds a specific compatible string in the Meson SPIFC driver for
the Amlogic Meson GXBB SoC.

This patchset is SPI-only respin from Jerome Brunet patchset at [1].

[1] http://lkml.kernel.org/r/1473261223-15412-1-git-send-email-jbrunet@baylibre.com

Neil Armstrong (2):
  dt-bindings: spi-meson: Add GXBB Compatible string
  spi: meson: Add GXBB compatible

 Documentation/devicetree/bindings/spi/spi-meson.txt | 2 +-
 drivers/spi/spi-meson-spifc.c                       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.9.1
