From: Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH 0/6] spi: Add support for DMA transfers in sun4i SPI driver
Date: Thu, 29 Mar 2018 21:59:01 +0300
Message-ID: <20180329185907.27281-1-ssuloev@orpaltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sergey Suloev <ssuloev@orpaltech.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>
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

The following patchset provides corrections for PIO-mode
and support for DMA transfers in sun4i SPI driver.

Sergey Suloev (6):
  spi: core: handle timeout error from transfer_one()
  spi: sun4i: restrict transfer length in PIO-mode
  spi: sun4i: coding style/readability improvements
  spi: sun4i: use completion provided by SPI core driver
  spi: sun4i: introduce register set/unset helpers
  spi: sun4i: add DMA transfers support

 drivers/spi/spi-sun4i.c | 443 ++++++++++++++++++++++++++++++++++++------------
 drivers/spi/spi.c       |   5 +-
 2 files changed, 341 insertions(+), 107 deletions(-)

-- 
2.16.2
