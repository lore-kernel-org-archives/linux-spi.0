From: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] Fix NULL pointer dereference
Date: Thu,  9 Apr 2015 17:03:41 +0200
Message-ID: <1428591822-24279-1-git-send-email-per.nilsson@xelmo.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

As I reported earlier, spi-altera driver is broken and causes a kernel
panic due to a NULL pointer dereference during first SPI
transaction. On a closer look, it turned out that the setup_transfer()
bitbang callback is mandatory when the txrx_bufs() callback is
present. It was therefore an error to remove it in commit
30af9b558a56. This patch simply adds back an empty implementation of
the callback.

Pelle Nilsson (1):
  spi: altera: Add empty implementation of setup_transfer callback

 drivers/spi/spi-altera.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
