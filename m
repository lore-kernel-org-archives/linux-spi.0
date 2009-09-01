From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 0/2] add ad714x captouch sensor input driver
Date: Tue, 1 Sep 2009 11:55:28 +0800
Message-ID: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: spi-devel-general@lists.sourceforge.net,
	linux-input@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Barry Song <21cnbao@gmail.com>
To: dbrownell@users.sourceforge.net, dmitry.torokhov@gmail.com,
	dtor@mail.ru
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dmitry/David,
The following two patches add the analog devices captouch sensor ad714x(AD7142/AD7147)
driver.

AD7142 and AD7147 are integrated capacitance-to-digital converters (CDCs) with on-chip 
environmental calibration for use in systems requiring a novel user input method. 
The AD7142 and AD7147 can interface to external capacitance sensors implementing 
functions such as capacitive buttons, scrollwheels, sliders, touchpads and so on.

David,
The patch[1/2] adds a file with platform_data definition for AD714x in include/linux/spi,
which describes the components layout on special target boards and need be filled in 
arch/mach.

Dmitry,
The patch[2/2] adds a file in drivers/input/misc and changes Kconfig&Makefile, fulfilling
the algorithms and state machines for the related buttons/sliders/scrollwheels/touchpads
defined in platform_data. So the driver becomes be independent of special target boards.

The patch[2/2] depends on patch[1/2] for compiling and work.

Thanks
Barry
