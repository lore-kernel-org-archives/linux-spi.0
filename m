From: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Subject: mc13xxx: add I2C support
Date: Thu, 19 Jan 2012 12:01:31 +1100
Message-ID: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

This series (based on 3.2) adds I2C support for the mc13xxx family PMICs.
The patches are similar, but not identical to my previous patches for this [1], the
main difference being the way the config items are done in patch 2.

I don't have the hardware to retest on SPI hardware, I'd appreciate if someone could 
double check it still works.

I've also got a stack of patches for the mc13xxx to follow, but should get this in
first.

Cheers,
Marc

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/thread.html#36936
