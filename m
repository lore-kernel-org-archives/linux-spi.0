From: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Subject: mc13xxx: add I2C support (now with regmap), V4
Date: Mon, 19 Mar 2012 15:03:54 +1100
Message-ID: <1332129838-7080-1-git-send-email-marc@cpdesign.com.au>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

This series (against mfd-2.6/for-next) changes the mc13xxx driver to use 
regmap and adds I2C support.
It has a compile dependency on regmap/for-next, as the spi driver uses the
recently added pad_bits config field.

Changes since V3:
- spi driver uses padded register format (reads should actually work now!)
- mc13873 removed from I2C driver
- fix memory leak on probe error

Cheers,
Marc

PS. Mark Brown added his "reviwed-by" (sic) for what is now 2/4. I've not 
included it here because 1. it changed (albeit very slightly) so I don't 
know if it's bad ettiquie to include it again, and 2. I'm ignorant of the
correct process/way to include it.
