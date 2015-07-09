From: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in Zynq
 MPSoC GQSPI controller
Date: Thu,  9 Jul 2015 18:14:53 +0530
Message-ID: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: harinik@xilinx.com, Ranjit Waghmode <ranjit.waghmode@xilinx.com>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, punnaia@xilinx.com, ran27jit@gmail.com,
 linux-arm-kernel@lists.infradead.org
To: broonie@kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
 dwmw2@infradead.org, computersforpeace@gmail.com, zajec5@gmail.com,
 marex@denx.de, shijie.huang@intel.com, juhosg@openwrt.org,
 ben@decadent.org.uk
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

This series of patches is to add dual parallel and stacked mode support for
Zynq Ultrascale+ MPSoC GQSPI controller driver.

These are all very high level changes and expected to make an idea clear.
Comments and suggestions are welcomed.

What is dual parallel mode?
---------------------------
ZynqMP GQSPI controller supports Dual Parallel mode with following functionalities:
1) Supporting two SPI flash memories operating in parallel. 8 I/O lines.
2) Chip selects and clock are shared to both the flash devices
3) This mode is targeted for faster read/write speed and also doubles the size
4) Commands/data can be transmitted/received from both the devices(mirror),
   or only upper or only lower flash memory devices.
5) Data arrangement:
   With stripe enabled,
   Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
   Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.

What is stacked mode?
---------------------
ZynqMP GQSPI controller supports stacked mode with following functionalities:
1) The Generic Quad-SPI controller also supports two SPI flash memories
   in a shared bus arrangement to reduce IO pin count.
2) Separate chip select lines
3) Shared I/O lines
4) This mode is targeted for increasing the flash memory and no performance
   improvement when compared with single.

Suggestions on MTD layer support
--------------------------------
In order to add above two specified modes, we may required to get some
support from MTD layer.

I'm trying to list the dependencies as follows:
1) Support for two flashes
2) Enable/Disable data stripe as and when required.
3) May need to update read_sr() to get status of both flashes
4) May also need to update read_fsr() to get status of both flashes
5) Adjustment of offset value based on the parallel/stacked mode configuration
6) Setting either parallel or stacked mode during the scan process.
7) In case of stacked mode, is there a MTD concatenation support?

Kindly suggest us the way by which we can proceed further for adding this
support.

Will plan to send RFC for MTD related changes, based on above dependencies.

Ranjit Waghmode (2):
  spi: zynqmp: gqspi: add support for dual parallel mode configuration
  spi: zynqmp: gqspi: add support for stacked mode configuration

 drivers/spi/spi-zynqmp-gqspi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

--
2.1.2
