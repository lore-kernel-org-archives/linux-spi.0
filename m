From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH 0/3] spi: documentation improvements
Date: Fri, 24 Jan 2014 08:28:03 +0200
Message-ID: <cover.1390544495.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series improves spi documentation as follows:

   * Add explicit note that transfer_one and transfer_one_message are mtually 
     exclusive

   * Add transfer_one documentation to spi-summary

   * s/transfer/message/ in the transfer_one_message description

Baruch Siach (3):
  spi: spi.h: clarify the documentation of transfer_one
  Doc: spi: document the transfer_one spi_master callback
  spi: correct the transfer_one_message documentation wording

 Documentation/spi/spi-summary | 12 +++++++++++-
 include/linux/spi/spi.h       |  6 ++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
