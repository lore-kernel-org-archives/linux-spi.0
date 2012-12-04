From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/2] sparc: Enable OF functionality for sparc for i2c and spi
Date: Tue,  4 Dec 2012 15:09:36 +0100
Message-ID: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org,
	sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
To: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This series removes the dependency on !SPARC for OF_I2C and removes the
depencency of !defined(CONFIG_SPARC) for the function
of_register_spi_devices. I find no reason for these to be unavailable
for sparc.

I am not sure if these should go through the sparc tree or the
corresponding subsystem trees.

Andreas Larsson (2):
  of_i2c: sparc: Allow OF_I2C for sparc
  spi: sparc: Allow of_register_spi_devices for sparc

 drivers/of/Kconfig |    2 +-
 drivers/spi/spi.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
