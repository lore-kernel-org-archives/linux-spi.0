From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 0/3] spi/bcm63xx-hsspi: various fixes
Date: Tue, 17 Dec 2013 21:44:45 +0100
Message-ID: <1387313088-22493-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

these are some of the fixes you requested for the driver.
The devm_clk_get() was already taken care of by Jingoo Han, so I based
this patchset on his patch(es).

I intentionally did not fix/implement RUNTIME_PM support since I did not
get around to proper testing it (to ensure I don't try to disable disabled
clocks etc).

Regards
Jonas

Jonas Gorski (3):
  spi/bcm63xx-hsspi: check result of clk_prepare_enable
  spi/bcm63xx-hsspi: use devm_register_master()
  spi/bcm63xx-hsspi: fix pm sleep support

 drivers/spi/spi-bcm63xx-hsspi.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

-- 
1.8.5.1
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
