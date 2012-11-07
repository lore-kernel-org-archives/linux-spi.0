From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH RESEND 0/4] spi: sh-msiof: Add DT support
Date: Wed,  7 Nov 2012 12:40:03 +0100
Message-ID: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Magnus Damm <magnus.damm@gmail.com>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Patch resend from 21st september, this time cover letter included. Added ARM-ML
and SH-ML as recipients too.

The first patch contains a minor cleanup that becomes possible due to older
changes in the SuperH code.

In the 2nd patch we add the SH-Mobile chips as possible architecture requirement
for the MSIOF driver.

Then we come to the core of the patchset: DeviceTree support for sh-msiof in
patch 3 and patch 4.

There are minimal changes to the first publication to the patchset like changing
a comment string, so I just resend it as v1 again as there are no comments to the
original patchset.

Bastian Hecht (4):
  spi: sh-msiof: Remove unneeded clock name
  spi: Add SH Mobile series as dependency to MSIOF controller
  spi: sh-msiof: Add device tree parsing to driver
  devicetree: Add Renesas SH Mobile MSIOF spi controller binding doc

 Documentation/devicetree/bindings/spi/sh-msiof.txt |   12 ++++
 drivers/spi/Kconfig                                |    4 +-
 drivers/spi/spi-sh-msiof.c                         |   60 ++++++++++++++++++--
 3 files changed, 69 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/sh-msiof.txt

-- 
1.7.5.4

