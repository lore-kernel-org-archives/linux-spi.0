From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v2 0/3] spi: dw: fixes, and manages resources migration
Date: Mon, 30 Dec 2013 20:30:43 +0200
Message-ID: <cover.1388427564.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series migration the spi-dw driver and its mmio wrapper to manges
resources, and adds a few small fixes. I have a few more patches in the queue
for adding device tree support, gpio chip selects, and generic spi queue, but
I'm waiting with time until I get a chance to test them properly.

v2:
    Address the comments of Mark Brown as detailed in the patches

    Drop the last v1 series patch as it has already been applied

Baruch Siach (3):
  spi: dw: use managed resources
  spi: dw-mmio: prepare the clock before enabling
  spi: dw: fix memory leak on error path

 drivers/spi/spi-dw-mmio.c | 74 ++++++++++++++---------------------------------
 drivers/spi/spi-dw-pci.c  | 40 +++++++------------------
 drivers/spi/spi-dw.c      | 25 ++++++----------
 drivers/spi/spi-dw.h      |  4 +--
 4 files changed, 42 insertions(+), 101 deletions(-)

-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
