From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Move eeprom drivers to drivers/misc/eeprom
Date: Tue, 20 Jan 2009 11:22:58 +0100
Message-ID: <1232446982-7842-1-git-send-email-w.sang@pengutronix.de>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	rt2400-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

As the directory drivers/i2c/chips is going away, we needed a new place
for the I2C eeprom drivers. After some discussion, the idea of putting
them into a directory drivers/misc/eeprom was favoured. David Brownell
added that his SPI eeprom driver could go there as well.

This patch series carries out the proposal and while at it, moves an
eeprom driver which was already in drivers/misc to the new location.

No code inside the drivers was changed and everything was
succesfully compile-tested.

Kind regards,

   Wolfram
