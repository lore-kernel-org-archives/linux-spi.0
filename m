From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v3 0/3] spi: documentation improvements
Date: Sat, 25 Jan 2014 22:36:12 +0200
Message-ID: <cover.1390681463.git.baruch@tkos.co.il>
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

v3:
   * Add transfer_one return values to spi-summary (Geert Uytterhoe)

   * s/message/transfer/ in transfer_one description (Gerhard Sittig)

v2:
   * Rebase over Mark's fix/core branch (Geert Uytterhoe)

   * Correct the description of code behaviour when transfer_one and 
	 transfer_one_message are both implemented (Geert Uytterhoe)

Baruch Siach (3):
  spi: spi.h: clarify the documentation of transfer_one
  Doc: spi: document the transfer_one spi_master callback
  spi: correct the transfer_one_message documentation wording

 Documentation/spi/spi-summary | 17 ++++++++++++++++-
 include/linux/spi/spi.h       |  7 +++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
