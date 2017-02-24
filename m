From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v6 0/3] Add spi-nor flash device pm support
Date: Fri, 24 Feb 2017 15:16:36 -0500
Message-ID: <1487967399-28967-1-git-send-email-kdasu.kdev@gmail.com>
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

Changes since v5 based on review comments:

spi-nor.h
- Added flash state field
- Added spin_lock for flash state change 
- Added wait queue for synchronization of spi-nor ops between 
  mtd and spi-nor driver

spi-nor.c
- Added spi_nor_get/release_device() flash state syncronization functions
- Added mtd suspend and resume handlers

rerverted m25p80.c changes 

The V5 changes below implements power management support using the mtd
handlers for resume and suspend in the spi-nor driver. Implemented flash
state synchronization methods based on other mtd device drivers.
spi-nor mtd pm resume() calls newly implemented spi_nor_init() function
that sets up the spi-nor flash to its pre-suspend state. This is needed
on platfroms that turn off power to the spi-nor flash on pm suspend. 
The code has been rebased to git://github.com/spi-nor/linux.git next
branch.

Kamal Dasu (3):
  mtd: spi-nor: Add spi-nor init function
  mtd: spi-nor: Add spi-nor flash device synchronization between flash
    states
  mtd: spi-nor: Add spi-nor mtd suspend and resume handlers

 drivers/mtd/spi-nor/spi-nor.c | 170 +++++++++++++++++++++++++++++++++++-------
 include/linux/mtd/spi-nor.h   |  22 +++++-
 2 files changed, 164 insertions(+), 28 deletions(-)

-- 
1.9.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
