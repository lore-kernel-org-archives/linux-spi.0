From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [bug report] spi: Add ADI driver for Spreadtrum platform
Date: Wed, 25 Oct 2017 11:57:23 +0300
Message-ID: <20171025085723.4z7rmwhtt265nyi5@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Baolin Wang,

The patch 7e2903cb91df: "spi: Add ADI driver for Spreadtrum platform"
from Sep 15, 2017, leads to the following static checker warning:

	drivers/spi/spi-sprd-adi.c:312 sprd_adi_hw_init()
	warn: 'chn_id - 32' is negative one

drivers/spi/spi-sprd-adi.c
   293          chn_cnt = size / 8;
   294          for (i = 0; i < chn_cnt; i++) {
   295                  u32 value;
   296                  u32 chn_id = be32_to_cpu(*list++);
                            ^^^^^^
Let's imagine chn_id == 31.


   297                  u32 chn_config = be32_to_cpu(*list++);
   298  
   299                  /* Channel 0 and 1 are software channels */
   300                  if (chn_id < 2)
   301                          continue;
   302  
   303                  writel_relaxed(chn_config, sadi->base +
   304                                 REG_ADI_CHN_ADDR(chn_id));
   305  
   306                  if (chn_id < 31) {
                            ^^^^^^^^^^^
This is false.

   307                          value = readl_relaxed(sadi->base + REG_ADI_CHN_EN);
   308                          value |= BIT(chn_id);
   309                          writel_relaxed(value, sadi->base + REG_ADI_CHN_EN);
   310                  } else if (chn_id < ADI_HW_CHNS) {
                                   ^^^^^^^^^^^^^^^^^^^^
This is true.

   311                          value = readl_relaxed(sadi->base + REG_ADI_CHN_EN1);
   312                          value |= BIT(chn_id - 32);
                                             ^^^^^^^^^^^
This is BIT(-1) which is undefined.

   313                          writel_relaxed(value, sadi->base + REG_ADI_CHN_EN1);
   314                  }
   315          }

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
