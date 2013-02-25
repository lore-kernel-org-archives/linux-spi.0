From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] Enable SPI flash support on da850-evm DT kernel
Date: Mon, 25 Feb 2013 16:14:06 +0530
Message-ID: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, "Manjunathappa,
	Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>, hs-ynQEQJNshbs@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Patch enables support for m25p80 SPI flash support on
da850-EVM.

Testing information:
da850-evm comes with partitions specified in DT blob.
Able to mount/umount and create/delete files on filesystem partition.

Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
"spi/davinci: add OF support for the spi controller"

Applies on top of below patch under community review:
http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org/msg25184.html

Manjunathappa, Prakash (4):
  spi/davinci: fix module build error
  ARM: davinci: da850: add SPI1 DT node
  ARM: davinci: da850: override SPI DT node device name
  ARM: davinci: da850-evm: add SPI flash support

 arch/arm/boot/dts/da850-evm.dts  |   40 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     |   18 +++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |    1 +
 drivers/spi/spi-davinci.c        |    2 +-
 4 files changed, 60 insertions(+), 1 deletions(-)

-- 
1.7.4.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
