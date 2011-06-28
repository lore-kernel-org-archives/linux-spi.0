From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH 0/5] remove spi-s3c24xx-gpio driver
Date: Tue, 28 Jun 2011 14:49:12 +0200
Message-ID: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ben-linux@fluff.org, grant.likely@secretlab.ca,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The spi-s3c24xx-gpio driver is functionally equivalent to the spi-gpio
driver (but precedes it). The driver has seen very little development 
since it got added back in 2006, and there's only 2 in-tree users of it.

This patch series moves the remaining users to the spi-gpio driver and
then finally removes the driver.

Compile tested only as I don't have access to the hardware.

 arch/arm/mach-s3c2410/include/mach/spi-gpio.h |   28 ----
 arch/arm/mach-s3c2410/mach-qt2410.c           |   34 +----
 arch/arm/mach-s3c2412/mach-jive.c             |   41 ++----
 arch/arm/mach-s3c2440/mach-gta02.c            |    1 -
 drivers/spi/Kconfig                           |   10 --
 drivers/spi/Makefile                          |    1 -
 drivers/spi/spi-s3c24xx-gpio.c                |  200 -------------------------
 7 files changed, 22 insertions(+), 293 deletions(-)

--
Bye, Peter Korsgaard
