From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v3 0/4] Add Macronix MX25F0A MFD driver for raw nand and spi
Date: Mon, 15 Apr 2019 17:23:50 +0800
Message-ID: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>,
 zhengxunli@mxic.com.tw
To: broonie@kernel.org, marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, bbrezillon@kernel.org, dwmw2@infradead.org,
 lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 computersforpeace@gmal.com, paul.burton@mips.com, stefan@agner.ch,
 christophe.kerello@st.com, liang.yang@amlogic.com,
 geert@linux-m68k.org, devicetree@vger.kernel.org,
 marcel.ziswiler@toradex.com, linux-mtd@lists.infradead.org,
 richard@nod.at, miquel.raynal@bootlin.com
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi,

v3 patch is to rename the title of SPI controller driver.
"Patch Macronix SPI controller driver according to MX25F0A MFD driver"

v2s patches is to support Macronix MX25F0A MFD driver 
for raw nand and spi controller which is separated 
form previous patchset:

https://patchwork.kernel.org/patch/10874679/

thanks for your review.

best regards,
Mason

Mason Yang (4):
  mfd: Add Macronix MX25F0A MFD controller driver
  mtd: rawnand: Add Macronix MX25F0A NAND controller
  spi: Patch Macronix SPI controller driver according to MX25F0A MFD
    driver
  dt-bindings: mfd: Document Macronix MX25F0A controller bindings

 .../devicetree/bindings/mfd/mxic-mx25f0a.txt       |  51 ++++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/mxic-mx25f0a.c                         |  84 ++++++
 drivers/mtd/nand/raw/Kconfig                       |   6 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/mxic_nand.c                   | 294 +++++++++++++++++++++
 drivers/spi/spi-mxic.c                             | 275 ++++---------------
 include/linux/mfd/mxic-mx25f0a.h                   | 175 ++++++++++++
 9 files changed, 670 insertions(+), 226 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
 create mode 100644 drivers/mfd/mxic-mx25f0a.c
 create mode 100644 drivers/mtd/nand/raw/mxic_nand.c
 create mode 100644 include/linux/mfd/mxic-mx25f0a.h

-- 
1.9.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
