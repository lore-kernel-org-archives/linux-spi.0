From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 0/2] spi: dts: sun4i: Add support for wait
 time between word transmissions
Date: Thu, 17 Dec 2015 12:40:25 +0100
Message-ID: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDFO74UEV4IRBZN6ZKZQKGQEWJJYY2A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi all,

This patch set adds a new property "spi-word-wait-ns" to the spi-bus
binding that allows SPI slave devices to set a wait time between the
transmission of words. Modifies the spi_device struct and slave device
probing to read and store the new property.

Also modifies the sun4i SPI master driver to make use of the new property.
This specific SPI controller needs 3 clock cycles to set up the delay,
which makes the minimum non-zero wait time on this hardware 4 clock cycles.

Changes from v1:
 * renamed the property for more clarity
 * wait time is set in nanoseconds instead of number of clock cycles
 * transparently handle the 3 setup clock cycles

 Changes from v2:
 * fixed typo in comment
 * moved parameter to spi-bus binding, dropping the vendor prefix
 * changed commit summary and description to reflect the changes

 Changes from v3:
 * remove reference to "hardware" in comments and description, as the wait
   time could also be implemented in software
 * read and set property value in spi core

 Changes from v4:
 * log with dev_dbg instead of dev_info
 * split patch into two separate ones for SPI-core and sun4i parts


Marcus Weseloh (2):
  spi: dts: Add new device property to specifcy a wait time between word
    transmissions
  spi: sun4i: Add support for wait time between word transmissions

 Documentation/devicetree/bindings/spi/spi-bus.txt |  2 ++
 drivers/spi/spi-sun4i.c                           | 22 ++++++++++++++++++++++
 drivers/spi/spi.c                                 |  2 ++
 include/linux/spi/spi.h                           |  2 ++
 4 files changed, 28 insertions(+)

-- 
1.9.1
