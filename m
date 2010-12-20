From: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Subject: mc13xxx core support for i2c
Date: Mon, 20 Dec 2010 14:50:51 +1100
Message-ID: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

These patches add i2c support for the mc13xxx-core driver. This v3 improves the v2
(http://lists.arm.linux.org.uk/lurker/message/20101215.214755.b6bae366.en.html) by splitting
the driver up into core, spi and i2c files so that it can support one subsystem in the absence
of the other.
