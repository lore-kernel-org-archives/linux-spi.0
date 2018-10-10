From: Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH 0/7] Enable spi dma on Rockchip RK3399
Date: Wed, 10 Oct 2018 11:00:31 +0200
Message-ID: <20181010090038.20834-1-kernel@esmil.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: linux-rockchip@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi all,

The first three patches in this series enable spi dma on rk3399,
while the remaining patches are meant to be decreasingly obvious
cleanups to the rockchip spi driver.

Unfortunately I only have rk3399-gru-kevin hardware to test
this on, so it would be nice if someone would test this on
other rockchips.

/Emil

Emil Renner Berthing (5):
  arm64: dts: rockchip: add rk3399 SPI DMAs
  spi: rockchip: remove unneeded dma_caps
  spi: rockchip: mark use_dma as bool
  spi: rockchip: directly use direction constants
  spi: rockchip: simplify spi enable logic

Huibin Hong (2):
  spi: rockchip: initialize dma_slave_config properly
  spi: rockchip: adjust dma watermark and burstlen

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++
 drivers/spi/spi-rockchip.c               | 62 +++++++++---------------
 2 files changed, 32 insertions(+), 40 deletions(-)

-- 
2.19.1
