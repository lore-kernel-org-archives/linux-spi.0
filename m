From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] spi: atmel: adopt pinctrl support
Date: Wed, 5 Mar 2014 09:58:48 +0800
Message-ID: <1393984730-14828-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	<plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark, 

This patch is to adopt pinctrl support to optimize energy usage for the pins
both for the suspend/resume cycle.

The patch is based on the branch: for-next
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git

Best Regards,
Wenyou Yang

Wenyou Yang (2):
  spi: atmel: adopt pinctrl support
  ARM: dts: sama5d36ek: add spi pinctrl sleep state

 arch/arm/boot/dts/sama5d36ek.dts |   14 ++++++++++++++
 drivers/spi/spi-atmel.c          |    9 +++++++++
 2 files changed, 23 insertions(+)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
