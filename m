From: kernel@martin.sperl.org
Subject: [PATCH V2 0/6] spi: bcm2835: improvements
Date: Tue, 23 Apr 2019 20:15:07 +0000
Message-ID: <20190423201513.8073-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

From: Martin Sperl <kernel@martin.sperl.org>

Patchset that implements changes for the spi-bcm2835aux now
also for the spi-bcm2835

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            reorganized patchset
	    added extra rational, descriptions

Martin Sperl (6):
  spi: bcm2835: bcm2835_spi_transfer_one_poll remove unnecessary
    argument
  spi: bcm2835: Avoid 64-bit arithmetic in xfer len calc
  spi: bcm2835: added comment about different bus behaviour of DMA mode
  spi: bcm2835: make the polling duration limits configurable
  spi: bcm2835: make the lower limit for dma mode configurable
  spi: bcm2835: add driver stats to debugfs

 drivers/spi/spi-bcm2835.c | 128 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 21 deletions(-)

--
2.11.0
