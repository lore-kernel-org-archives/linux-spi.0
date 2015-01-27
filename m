From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH 0/7] Add SPI support for Colibri modules and DSPI driver fixes
Date: Tue, 27 Jan 2015 16:27:17 +0530
Message-ID: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, linux@arm.linux.org.uk, B44548@freescale.com,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Li.Xiubo@freescale.com,
 broonie@kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch,
 linux-spi@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org,
 shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org,
 Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
To: <mark.rutland@arm.com>
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

- Add second dspi instance.
- Enable MCP2515 CAN controller which is avaialble on
  Colibri evaluation board.

- Respin the stalled patches of dspi fixes.
  Previous discussion at:
  http://comments.gmane.org/gmane.linux.ports.arm.kernel/359542

Bhuvanchandra DV (4):
  ARM: vf610: add second DSPI instance
  ARM: vf-colibri: add SPI support and enable MCP2515 CAN
  spi: spi-fsl-dspi: Remove usage of devm_kalloc
  spi: spi-fsl-dspi: avoid preparing the clocks two times

Chao Fu (3):
  spi: spi-fsl-dspi: Remove spi-bitbang
  spi: spi-fsl-dspi: split the resuable code
  spi: spi-fsl-dspi: Add support for TCFQ transfer mode

 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |   2 +
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  31 ++
 arch/arm/boot/dts/vf-colibri.dtsi                  |  15 +
 arch/arm/boot/dts/vf500.dtsi                       |   4 +
 arch/arm/boot/dts/vfxxx.dtsi                       |  11 +
 drivers/spi/Kconfig                                |   1 -
 drivers/spi/spi-fsl-dspi.c                         | 314 +++++++++++++--------
 7 files changed, 254 insertions(+), 124 deletions(-)

-- 
2.2.2
