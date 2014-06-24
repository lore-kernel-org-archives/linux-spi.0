From: addy ke <addy.ke@rock-chips.com>
Subject: [PATCH 0/2] add rockchip spi drive
Date: Tue, 24 Jun 2014 11:58:42 +0800
Message-ID: <1403582324-9485-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org,
 addy ke <addy.ke@rock-chips.com>, yzq@rock-chips.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 kever.yang@rock-chips.com, zyw@rock-chips.com, xjq@rock-chips.com,
 zhenfu.fang@rock-chips.com, olof@lixom.net, cf@rock-chips.com,
 hj@rock-chips.com, linux-arm-kernel@lists.infradead.org
To: broonie@kernel.org, heiko@sntech.de, grant.likely@linaro.org,
 robh+dt@kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Patch 1 add rockchip spi documentation
Patch 2 add driver for Rockchip RK3XXX SoCs integrated SPI.

Tested on rk3288 sdk board with polling mode and DMA mode.

addy ke (2):
  documentation: add rockchip spi documentation
  spi: add driver for Rockchip RK3xxx SoCs integrated SPI

 .../devicetree/bindings/spi/spi-rockchip.txt       |  51 ++
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-rockchip.c                         | 894 +++++++++++++++++++++
 4 files changed, 957 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.txt
 create mode 100644 drivers/spi/spi-rockchip.c

-- 
1.8.3.2
