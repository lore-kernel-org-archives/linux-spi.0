From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 0/3] spi: meson-axg: add few enhanced features
Date: Thu, 3 May 2018 21:36:41 +0000
Message-ID: <20180503213645.20694-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Sunny Luo <sunny.luo@amlogic.com>, <linux-spi@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

  Add a few enhanced features for the SPICC controller of Meson-AXG SoC.

  These patches are actually quite independent from each other, I send them
together in case to avoid the file conflicts.

Sunny Luo (3):
  spi: meson-axg: support MAX 80M clock
  spi: meson-axg: enhance output enable feature
  spi: meson-axg: add a linear clock divider support

 drivers/spi/spi-meson-spicc.c | 270 ++++++++++++++++++++++++++++------
 1 file changed, 222 insertions(+), 48 deletions(-)

-- 
2.17.0
