From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 0/5] Patch enables support for m25p64 SPI flash support on
	da850-EVM.
Date: Wed, 3 Apr 2013 19:39:05 +0530
Message-ID: <1364998150-5980-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
        <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, <hs-ynQEQJNshbs@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Testing information:
da850-evm comes with partitions specified in DT blob.
Able to mount/umount and create/delete files on filesystem partition.

Applies on top of linux_davinci/master tree:
git://gitorious.org/linux-davinci/linux-davinci.git

Since v4:
Separate out chip_select pinmuxing so as to allow boards choose
accordingly.

Since v3:
Minor nit, fix tabs and commit message of 2/5.

Since v2:
Fix compatible property DT naming convention.

Since v1:
Look for m25p64 instead of m25p80 flash chip and correct partition information.
Dropped below accepted patch:
"spi/davinci: fix module build error"
Considered below missed out patch:
spi/davinci: add DT binding documentation

Manjunathappa, Prakash (4):
  spi/davinci: no wildcards in DT compatible property
  ARM: davinci: da850: add SPI1 DT node
  ARM: davinci: da850: override SPI DT node device name
  ARM: davinci: da850-evm: add SPI flash support

Murali Karicheri (1):
  spi/davinci: add DT binding documentation

 .../devicetree/bindings/spi/spi-davinci.txt        |   51 ++++++++++++++++++++
 arch/arm/boot/dts/da850-evm.dts                    |   40 +++++++++++++++
 arch/arm/boot/dts/da850.dtsi                       |   22 ++++++++
 arch/arm/mach-davinci/da8xx-dt.c                   |    1 +
 drivers/spi/spi-davinci.c                          |    4 +-
 5 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt

-- 
1.7.4.1
