From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Move eeprom drivers to drivers/misc/eeprom
Date: Wed, 21 Jan 2009 10:56:05 +0100
Message-ID: <20090121105605.018f10d4@hyperion.delvare>
References: <1232446982-7842-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	rt2400-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1232446982-7842-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Wolfram,

On Tue, 20 Jan 2009 11:22:58 +0100, Wolfram Sang wrote:
> As the directory drivers/i2c/chips is going away, we needed a new place
> for the I2C eeprom drivers. After some discussion, the idea of putting
> them into a directory drivers/misc/eeprom was favoured. David Brownell
> added that his SPI eeprom driver could go there as well.
> 
> This patch series carries out the proposal and while at it, moves an
> eeprom driver which was already in drivers/misc to the new location.
> 
> No code inside the drivers was changed and everything was
> succesfully compile-tested.

Thanks a lot for doing this. I've applied all 4 patches.

Things which I think need to be improved on top of your patches:

* Dependencies. The at24 and eeprom drivers should depend on I2C and the
at25 driver should depend on SPI. They did beforehand, thanks to
menu-level dependencies, there's no reason to change this. Should
probably be merged into your patches so that there is no regression.

This might be a good rationale to move the "Misc devices" entry at the
end of the menu, so that users can select the dependencies first.

* Symbol names. At the moment we have:

CONFIG_AT24
CONFIG_SPI_AT25
CONFIG_SENSORS_EEPROM
CONFIG_EEPROM_93CX6

I want to get rid of "SENSORS", at least. But maybe it is the right
time to make the symbol names more consistent? For example:

CONFIG_EEPROM_AT24
CONFIG_EEPROM_AT25
CONFIG_EEPROM_LEGACY
CONFIG_EEPROM_93CX6

This gives some more work on "make oldconfig" but I think it's worth
it. Are there any objections to this change?

Thanks,
-- 
Jean Delvare
