From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 0/2] spi: pca2xx: Prepare for and enable MSI support
Date: Sat, 21 Jan 2017 10:06:37 +0100
Message-ID: <cover.1484989599.git.jan.kiszka@siemens.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Sascha Weisenberger <sascha.weisenberger-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This enhances the pca2xx driver's interrupt handler with support for
edge-triggered interrupts and makes use of that for PCI-hosted variants,
like the Intel Quark SoC.

Changes in v3:
- removed already applied patch "Factor out handle_bad_msg"
- avoid inner looping by making the hardware retrigger on "forgotten"
  IRQ sources
- added acked/reviewed tags

Changes in v2:
- factored out handle_bad_msg (Andy)
- reordered code in patch 3, avoiding unneeded pci_free_irq_vectors (Andy)

Jan

Jan Kiszka (2):
  spi: pxa2xx: Prepare for edge-triggered interrupts
  spi: pca2xx-pci: Allow MSI

 drivers/spi/spi-pxa2xx-pci.c | 8 +++++++-
 drivers/spi/spi-pxa2xx.c     | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
