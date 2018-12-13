From: Sunny Luo <sunny.luo@amlogic.com>
Subject: [PATCH v2 0/3] spi: meson-axg: add few enhanced features
Date: Thu, 13 Dec 2018 16:39:11 +0800
Message-ID: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sunny Luo <sunny.luo@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

add a few enhanced features for the SPICC controller of Meson-AXG SoC.

These patches are actually quite independent from each other, I send them
together in case to avoid the file conflicts.

Changes since v1 at [1]
- Add OF and COMMON_CLK dependence for SPICC in Kconfig to avoid compiling
  error.

[1] https://lore.kernel.org/lkml/20180503213645.20694-1-yixun.lan@amlogic.com

Sunny Luo (3):
  spi: meson-axg: support MAX 80M clock
  spi: meson-axg: enhance output enable feature
  spi: meson-axg: add a linear clock divider support

 drivers/spi/Kconfig           |   2 +-
 drivers/spi/spi-meson-spicc.c | 270 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 223 insertions(+), 49 deletions(-)

-- 
2.7.4
