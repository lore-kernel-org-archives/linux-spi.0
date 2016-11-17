From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH 0/4] Fixes for Vybrid SPI DMA implementation
Date: Thu, 17 Nov 2016 17:46:47 +0530
Message-ID: <cover.1479384571.git.maitysanchayan@gmail.com>
References: <20161111122036.fubv7b4jc5vkdxhc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sanchayan Maity <maitysanchayan@gmail.com>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stefan@agner.ch,
 linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111122036.fubv7b4jc5vkdxhc@sirena.org.uk>
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

Hello,

The following set of patches have fixes for Vybrid SPI DMA
implementation along with some minor clean ups requested
at time when v3 version of SPI DMA support patch was accepted. 

This series of patches is based on top of branch topic/fsl-dspi.
http://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/log/?h=topic/fsl-dspi

The patches have been tested on a Toradex Colibri Vybrid VF61 module.

Thanks & Regards,
Sanchayan.

Sanchayan Maity (4):
  spi: spi-fsl-dspi: Fix SPI transfer issue when using multiple SPI_IOC_MESSAGE
  spi: spi-fsl-dspi: Fix incorrect DMA setup
  spi: spi-fsl-dspi: Fix continuous selection format
  spi: spi-fsl-dspi: Minor code cleanup and error path fixes

 drivers/spi/spi-fsl-dspi.c | 69 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 18 deletions(-)

-- 
2.10.2
