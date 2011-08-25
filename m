From: Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH/RFC 0/2] Add power supply switch in platform data
Date: Thu, 25 Aug 2011 16:29:10 +0300
Message-ID: <cover.1314278151.git.svarbanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: grant.likely@secretlab.ca, Stanimir Varbanov <svarbanov@mm-sol.com>,
	artem.bityutskiy@intel.com, dwmw2@infradead.org
To: spi-devel-general@lists.sourceforge.net,
	linux-mtd@lists.infradead.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi,

Here are two patches that add a power method in flash platform data
for chips power control. The first patch adding this function and
the second use it in m25p driver.

Comments are welcome !

Stanimir Varbanov (2):
  spi: flash: Add power method into flash platform data
  mtd: m25p80: Call a platform power method in the driver

 drivers/mtd/devices/m25p80.c |   41 +++++++++++++++++++++++++++++++++++++----
 include/linux/spi/flash.h    |    4 ++++
 2 files changed, 41 insertions(+), 4 deletions(-)

-- 
1.7.4.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
