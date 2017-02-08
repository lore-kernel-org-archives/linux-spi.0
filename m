From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 0/2] Added support for spi-nor device pm in m25p80
Date: Wed,  8 Feb 2017 11:52:59 -0500
Message-ID: <1486572781-28808-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
 linux-mtd@lists.infradead.org, Kamal Dasu <kdasu.kdev@gmail.com>
To: linux-spi@vger.kernel.org, cyrille.pitchen@atmel.com, marex@denx.de,
 broonie@kernel.org
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

The changes below implements power management support in m25p80 driver.
m25p80 pm resume() calls newly a implemented spi_nor_reset() function
that sets up the spi-nor flash to its probed state. This is needed on
platfroms that turn off power to the spi-nor flash on pm suspend. 

Kamal Dasu (2):
  mtd: spi-nor: Added spi-nor reset function
  mtd: m25p80: Added pm ops support

 drivers/mtd/devices/m25p80.c  | 16 +++++++++++
 drivers/mtd/spi-nor/spi-nor.c | 62 ++++++++++++++++++++++++++++---------------
 include/linux/mtd/spi-nor.h   | 21 ++++++++++++++-
 3 files changed, 77 insertions(+), 22 deletions(-)

-- 
1.9.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
