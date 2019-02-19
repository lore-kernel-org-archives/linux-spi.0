From: Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/2] SPI support for HiFive Unleashed
Date: Tue, 19 Feb 2019 17:10:05 +0530
Message-ID: <1550576407-17778-1-git-send-email-yash.shah@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
 Yash Shah <yash.shah@sifive.com>, robh+dt@kernel.org, paul.walmsley@sifive.com
To: palmer@sifive.com, linux-spi@vger.kernel.org,
 linux-riscv@lists.infradead.org, broonie@kernel.org
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This patch series adds a SPI driver and DT documentation
for HiFive Unleashed board.

Yash Shah (2):
  spi: sifive: Add DT documentation for SiFive SPI controller
  spi: sifive: Add driver for the SiFive SPI controller

 .../devicetree/bindings/spi/spi-sifive.txt         |  37 ++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sifive.c                           | 450 +++++++++++++++++++++
 4 files changed, 494 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
 create mode 100644 drivers/spi/spi-sifive.c

-- 
1.9.1
