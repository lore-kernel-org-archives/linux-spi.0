From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 0/3] Fix baud rate for Armada SoCs
Date: Tue, 26 May 2015 11:44:41 +0200
Message-ID: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Boris BREZILLON <boris.brezillon@free-electrons.com>,
 Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory CLEMENT <gregory.clement@free-electrons.com>
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

Hi,

The commit df59fa7f4bca "spi: orion: support armada extended baud
rates" was too optimistic for the maximum baud rate that the Armada
SoCs can support. Fixing it is the purpose of the 1st patch.

Actually the Armada SoCs do not have the same constraints, some of
them have maximum absolute values whereas for the other it is linked
to the TCLK value. The second patch takes care of managing all these
cases.

Then the third patch updates the dtsi in order to use the accurate
value.

Only the first patch fixes a bug observed on the board by using a too
high frequency on the SPI bus. The other ones allow using the best
maximum frequency available.

Thanks,

Gregory


Gregory CLEMENT (3):
  spi: orion: Fix maximum baud rates for Armada 370/XP
  spi: orion: Fix extended baud rates for each Armada SoCs
  ARM: mvebu: use improved armada spi device tree compatible name for
    each SoC

 .../devicetree/bindings/spi/spi-orion.txt          |  8 ++-
 arch/arm/boot/dts/armada-370-xp.dtsi               |  2 -
 arch/arm/boot/dts/armada-370.dtsi                  |  4 ++
 arch/arm/boot/dts/armada-375.dtsi                  |  6 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |  6 +-
 arch/arm/boot/dts/armada-39x.dtsi                  |  6 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |  8 +++
 drivers/spi/spi-orion.c                            | 70 ++++++++++++++++++++--
 8 files changed, 96 insertions(+), 14 deletions(-)

-- 
2.1.0
