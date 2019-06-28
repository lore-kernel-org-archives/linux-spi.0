From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH 0/2] spi: atmel-quadspi: fix resume call
Date: Fri, 28 Jun 2019 15:30:30 +0000
Message-ID: <20190628153009.7571-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alexandre.belloni@bootlin.com, Tudor.Ambarus@microchip.com,
 linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com,
 Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
To: <broonie@kernel.org>, <mdeneen@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
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

From: Tudor Ambarus <tudor.ambarus@microchip.com>

When waking up from the Suspend-to-RAM state, the following error
was seen:

m25p80 spi2.0: flash operation timed out

The flash remained in an undefined state, returning 0xFFs.
Fix it by setting the Serial Clock Baud Rate, as it was set
before the conversion to SPIMEM.

Tested with sama5d2_xplained and mx25l25673g spi-nor in
Backup + Self-Refresh and Suspend modes.

Tudor Ambarus (2):
  spi: atmel-quadspi: void return type for atmel_qspi_init()
  spi: atmel-quadspi: fix resume call

 drivers/spi/atmel-quadspi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.9.5
