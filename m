From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [spi:topic/lantiq-ssc 11/12] drivers/spi/spi-lantiq-ssc.c:973:3-8:
 No need to set .owner here. The core will do it.
Date: Mon, 20 Feb 2017 01:33:10 +0800
Message-ID: <201702200104.ay31O32d%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git topic/lantiq-ssc
head:   30fb27239f987c53429f24297f5d46e28d0e16ed
commit: 582c97f6868cf70720a17d2421d317333f3ad597 [11/12] spi: lantiq-ssc: activate under COMPILE_TEST


coccinelle warnings: (new ones prefixed by >>)

>> drivers/spi/spi-lantiq-ssc.c:973:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
