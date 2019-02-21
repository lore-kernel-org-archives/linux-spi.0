From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: [BUG] vf610-zii-dev-rev-b SPI fails at boot
Date: Thu, 21 Feb 2019 15:24:59 +0000
Message-ID: <20190221152459.axrjce7yqkjmedgl@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

While booting 4.20 on the ZII development revision B board, I notice 
this in the kernel logs:

spi spi0.1: setup: unsupported mode bits 4
spi_gpio spi0: can't setup spi0.1, status -22
spi_master spi0: spi_device register error /spi0/at93c46d@1
spi_master spi0: Failed to create SPI device for /spi0/at93c46d@1

This is for the at93c46d@1 device attached to spi-gpio (see
arch/arm/boot/dts/vf610-zii-dev-rev-b.dts around line 330).  This
is declared with "spi-cs-high;" in DT.  It appears to be complaining
about the SPI_CS_HIGH flag.

It appears this warning comes from drivers/spi/spi.c around lines
2828-2847 due to:

	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);

and it looks like spi-gpio sets:

	master->mode_bits = SPI_3WIRE | SPI_CPHA | SPI_CPOL;

but then goes on to set:

	spi_gpio->bitbang.flags = SPI_CS_HIGH;

However, this is ignored by bitbang if master->mode_bits has already
been set:

	if (!master->mode_bits)
		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;

It looks like this commit introduced for v4.19 broke the driver:

commit 4b859db2c60692560afbfef1b030d0ddef57b7ee
Author: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat Jul 28 10:19:14 2018 +0200

by setting master->mode_bits - prior to this, bitbang would have set
the mode bits itself.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
