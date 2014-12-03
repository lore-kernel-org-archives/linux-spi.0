From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] spi: fsl-(e)spi: migrate to generic master queueing
Date: Wed, 03 Dec 2014 07:56:10 +0100
Message-ID: <547EB40A.7070909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Patch 1/2

Migrates the fsl-(e)spi driver to use the generic master queuing.
Avoids the "master is unqueued, this is deprecated" warning.

Patch 2/2

Adds (un)prepare_transfer_hardware calls to (re)set SPMODE_ENABLE.
Reduces power consumption when SPI is idle.

I successfully tested the backported version of both patches on a
wireless router TP-Link TL-WDR4900 (P1014/mpc85xx-based: fsl-espi)
with openwrt and kernel 3.14.25 (newer kernels not yet supported).

Due to missing hw I wasn't able to test patch 1 with fsl-spi.

Heiner

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
