From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/9] spi: Use dma_request_chan() instead
 dma_request_slave_channel()
Date: Thu, 12 Dec 2019 15:55:41 +0200
Message-ID: <20191212135550.4634-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, vkoul@kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
To: <broonie@kernel.org>, <nsaenzjulienne@suse.de>, <f.fainelli@gmail.com>,
 <rjui@broadcom.com>, <sbranden@broadcom.com>, <shawnguo@kernel.org>,
 <s.hauer@pengutronix.de>, <baohua@kernel.org>,
 <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
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

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

With dma_request_chan() drivers can receive the real error code and can support
deferred probing against DMA.

The series has been compile tested only (allyesconfig).

Regards,
Peter
---
Peter Ujfalusi (9):
  spi: atmel: Use dma_request_chan() instead dma_request_slave_channel()
  spi: bcm2835: Release the DMA channel if probe fails after dma_init
  spi: bcm2835: Use dma_request_chan() instead
    dma_request_slave_channel()
  spi: img-spfi: Use dma_request_chan() instead
    dma_request_slave_channel()
  spi: mxs: Use dma_request_chan() instead dma_request_slave_channel()
  spi: sirf: Use dma_request_chan() instead dma_request_slave_channel()
  spi: spi-fsl-dspi: Use dma_request_chan() instead
    dma_request_slave_channel()
  spi: stm32-qspi: Use dma_request_chan() instead
    dma_request_slave_channel()
  spi: stm32: Use dma_request_chan() instead dma_request_slave_channel()

 drivers/spi/spi-atmel.c      | 29 ++++++++++----------------
 drivers/spi/spi-bcm2835.c    | 40 +++++++++++++++++++++++++-----------
 drivers/spi/spi-fsl-dspi.c   | 12 +++++------
 drivers/spi/spi-img-spfi.c   | 18 ++++++++++++++--
 drivers/spi/spi-mxs.c        |  6 +++---
 drivers/spi/spi-sirf.c       | 12 +++++------
 drivers/spi/spi-stm32-qspi.c | 30 +++++++++++++++++++++------
 drivers/spi/spi-stm32.c      | 32 ++++++++++++++++++++---------
 8 files changed, 116 insertions(+), 63 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
