From: "Tomoya MORINAGA" <morinaga526@dsn.okisemi.com>
Subject: spi_topcliff_pch: reload issue
Date: Tue, 22 Feb 2011 10:22:11 +0900
Message-ID: <7FC6F7C4A6284C0FBD95D71D76B7528D@hacdom.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <qi.wang@intel.com>, <yong.y.wang@intel.com>,
	<joel.clark@intel.com>, <kok.howg.ewe@intel.com>,
	"Toshiharu Okada" <toshiharu-linux@dsn.okisemi.com>
To: "'David Brownell'" <dbrownell@users.sourceforge.net>,
	"'Grant Likely'" <grant.likely@secretlab.ca>,
	<spi-devel-general@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

issue: after reload the spi module, it can't do SPI communication.

We have faced issue when execute the following command.
insmod xxx.ko(Then, /dev/spidev0.0 is created with success)
rmmod xxx.ko (Then, /dev/spidev0.0 is deleted with success)
insmod xxx.ko(Then, /dev/spidev0.0 is created, however, below error message is showed)

  0000:02:0c.1: registered master spi0
  0000:02:0c.1: chipselect 0 already in use
  0000:02:0c.1: can't create new device for spidev

Do you have any information about the above ?

kernel=2.6.37 on FC14

With Best Regards,
-----------------------------------------
Tomoya MORINAGA
OKI SEMICONDUCTOR CO., LTD.
