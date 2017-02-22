From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v5 0/2] Added support for spi-nor device pm in m25p80
Date: Wed, 22 Feb 2017 14:19:31 -0500
Message-ID: <1487791173-22159-1-git-send-email-kdasu.kdev@gmail.com>
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

Changes since v4 based on review comments:

spi-nor.c
- Added comments to make it clear that spi_nor_init() sends all spi-nor
  flash configuration commands based on nor stucture settings for read
  in the refactored code

m25p80.c:
- fix typos
- Updated description

The V4 changes below implements power management support in m25p80 driver.
m25p80 pm resume() calls newly a implemented spi_nor_init() function
that sets up the spi-nor flash to its pre-suspend state. This is needed on
platfroms that turn off power to the spi-nor flash on pm suspend.
The code has been rebased to git://github.com/spi-nor/linux.git next
branch.

Kamal Dasu (2):
  mtd: spi-nor: Added spi-nor init function
  mtd: m25p80: Added pm ops support

 drivers/mtd/devices/m25p80.c  | 11 +++++++
 drivers/mtd/spi-nor/spi-nor.c | 77 ++++++++++++++++++++++++++++---------------
 include/linux/mtd/spi-nor.h   | 18 +++++++++-
 3 files changed, 78 insertions(+), 28 deletions(-)

-- 
1.9.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
