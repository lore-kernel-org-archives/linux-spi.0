From: Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH 0/4] spi: a3700: Add improvements and full-duplex transfers
Date: Wed, 17 Jan 2018 17:15:24 +0100
Message-ID: <1516205728-3256-1-git-send-email-maxime.chevallier@smile.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: gregory.clement@free-electrons.com,
 Maxime Chevallier <maxime.chevallier@smile.fr>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: broonie@kernel.org
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

This patchset adds some improvements on the existing Armada 3700 SPI
driver, the biggest being adding support for full-duplex transfers.

The first patch fixes an undocumented (to my knowledge, I might have
missed something) behaviour where some of the content of the last
write transfer is shifted out during a read half-duplex operation.

The second one sets the correct limits on the SPI max and min
frequencies, based on the source clock rate.

The last 2 patches enable full-duplex transfers. On this controller,
full-duplex transfers cannot use the hardware FIFOs and have to be
performed either 1 or 4 bytes at a time. Because this is more
CPU intensive, and a bit slower than FIFO mode, we only use the
full-duplex way of transferring data when necessary.

Maxime Chevallier (4):
  spi: a3700: Clear DATA_OUT when performing a read
  spi: a3700: Set frequency limits at startup
  spi: a3700: Allow to enable or disable FIFO mode
  spi: a3700: Add full-duplex support

 drivers/spi/spi-armada-3700.c | 106 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 15 deletions(-)

-- 
2.1.4
