From: Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>
Subject: [PATCH RFC 0/1] Convert mcp23s08 to DT usage
Date: Thu, 31 Jan 2013 16:58:22 +0100
Message-ID: <1359647903-15801-1-git-send-email-larsi@wh2.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

From: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>

I wanted to use mcp23s08 driver with a device that boots using device tree.
Therefore I had to modify the driver to be able to take it's platform_data
from the device tree.
I am using a mcp23017 (I2C) device successfully with the patch booted over
device tree. I am not sure if I did this right and I am not able to test the
SPI part of the driver, so I am requesting for comments.

Thank you,
Lars

Lars Poeschel (1):
  gpio: mcp23s08: convert driver to DT

 .../devicetree/bindings/gpio/gpio-mcp23s08.txt     |   27 ++++++
 drivers/gpio/gpio-mcp23s08.c                       |   93 +++++++++++++++++++-
 include/linux/spi/mcp23s08.h                       |    1 +
 3 files changed, 117 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mcp23s08.txt

-- 
1.7.10.4


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
