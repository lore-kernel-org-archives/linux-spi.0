From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/3] spi: tegra: use u32 for 32-bit register values
Date: Sun,  8 Dec 2013 16:35:08 +0100
Message-ID: <1386516911-26388-1-git-send-email-mina86@mina86.com>
References: <1385745164-10534-1-git-send-email-mpn@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385745164-10534-1-git-send-email-mpn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series has only been compile-tested, but it does not introduce any
behaviour changes.

Michal Nazarewicz (3):
  spi: tegra114: use u32 for 32-bit register values
  spi: tegra20-slink: use u32 for 32-bit register values
  spi: tegra20-sflash: use u32 for 32-bit register values

 drivers/spi/spi-tegra114.c       | 98 ++++++++++++++--------------------------
 drivers/spi/spi-tegra20-sflash.c | 22 ++++-----
 drivers/spi/spi-tegra20-slink.c  | 97 ++++++++++++++++-----------------------
 3 files changed, 84 insertions(+), 133 deletions(-)

-- 
1.8.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
