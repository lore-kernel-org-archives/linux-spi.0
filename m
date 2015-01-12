From: Ken Wilson <ken.wilson-xg7Pnmy8KxlWk0Htik3J/w@public.gmane.org>
Subject: [PATCHv2 0/2] spi: orion: Add multiple chip select support to spi-orion
Date: Mon, 12 Jan 2015 13:13:58 +1000
Message-ID: <1421032440-15335-1-git-send-email-ken.wilson@opengear.com>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
	gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ken Wilson <ken.wilson-xg7Pnmy8KxlWk0Htik3J/w@public.gmane.org>
To: thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,      

This patch series adds multiple chip select support for the spi-orion driver.
The first patch moves spi-orion to use the spi setup/set_cs/transfer_one         
function pointers, which reduces duplicated code, and simplifies the chip 
select support implementation.

The second patch adds support for multiple chip selects. Currently
there is no additional support for gpio chip selects, as I do not 
have a board to test that with. 

These patches have been tested on an Armada 375 with 2 SPI-NOR chips.

Thanks,
Ken

Ken Wilson (2):
  spi: orion: Change spi-orion to use transfer_one() semantics for SPI
    transfers
  spi: orion: Add multiple chip select support to spi-orion

 .../devicetree/bindings/spi/spi-orion.txt          |  3 +
 drivers/spi/spi-orion.c                            | 90 +++++++++-------------
 2 files changed, 41 insertions(+), 52 deletions(-)

-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
