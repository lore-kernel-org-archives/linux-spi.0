From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 0/4] dma map single page multiple times in sg_list
Date: Mon, 25 May 2015 12:44:22 +0000
Message-ID: <1432557867-2427-1-git-send-email-kernel@martin.sperl.org>
References: <2B971A09-33E3-42BC-B13D-49B6DD3D2E7A@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2B971A09-33E3-42BC-B13D-49B6DD3D2E7A-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This patch series implements mapping a single page multiple times
in the sg_list when rx/tx_buf == NULL.

The 1st patch makes this apply to all spi_transfers for which
can_dma returns true, but this means it applies to all spi-masters
with DMA support.

To avoid this there is an api extension in the 3rd patch that allows
drivers to state the requirement in spi_master.flags.

spi-bcm2835 is converted to the new api in patches 2 and 4.

Patch 3 and 4 are optional and reduce impact on drivers that do
not need this feature by extending the API.

All patches apply against for-next, but note that there will be a conflict
if the patch "spi: add missing cleanup in spi_map_msg on error" is
applied already.

Martin Sperl (4):
  spi: dma map a single page multiple times in sg_list for rx/tx_buf ==
    NULL
  spi: bcm2835: no longer requires SPI_MASTER_MUST_RX/TX
  spi: add SPI_MASTER_MUST_*_SG to avoid unnecessary mapping of null
    pages in sg_lists for masters that do not need it
  spi: bcm2835: set SPI_MASTER_MUST_RX_SG/TX_SG flags

 drivers/spi/spi-bcm2835.c |    4 ++--
 drivers/spi/spi.c         |   40 +++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h   |    6 ++++++
 3 files changed, 41 insertions(+), 9 deletions(-)

-- 
1.7.10.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
