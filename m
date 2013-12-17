From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 0/4] spi/bcm63xx: fixes and cleanups
Date: Tue, 17 Dec 2013 21:42:06 +0100
Message-ID: <1387312930-22436-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

These four patches aim to improve the bcm63xx spi driver and fix
various small issues.

The first two are actually a resend. I accidentially took an old
(not working anymore) email address from you, I suspect they went under
the radar. They are the same except that I added Florian's Acks.

These might be stable/3.13 material.

The latter two just do some smallish cleanups, and don't necessarily
need backporting I think.

Patch 3 depends on Jingoo Han's devm_clk_get() patch, because that one
makes sense and I wanted to do the same anyway (actually did, but he was
faster ;-).

Regards
Jonas

Jonas Gorski (4):
  spi/bcm63xx: don't substract prepend length from total length
  spi/bcm63xx: don't reject reads >= 256 bytes
  spi/bcm63xx: check return value of clk_prepare_enable
  spi/bcm63xx: fix pm sleep support

 drivers/spi/spi-bcm63xx.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

-- 
1.8.5.1
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
