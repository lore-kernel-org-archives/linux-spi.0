From: Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] spi: imx: only do necessary changes to ECSPIx_CONFIGREG
Date: Thu, 17 Mar 2016 16:00:30 +0100
Message-ID: <56EAC68E.4040103@de.bosch.com>
References: <1458048276-31884-1-git-send-email-dirk.behme@de.bosch.com> <20160317075911.GV30994@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160317075911.GV30994-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 03/17/2016 um 08:59 AM schrieb Sascha Hauer:
> On Tue, Mar 15, 2016 at 02:24:36PM +0100, Dirk Behme wrote:
>> > From: Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
>> > 
>> > If the SPI chip select (CS) for a dedicated channel is done manually by
>> > the used higher device driver, the CS may be active while writing to
>> > ECSPIx_CONFIGREG. To prevent unwanted clock edges when selecting
>> > the clock mode,  only do the necessary changes to the i.MX SPI
>> > configuration register and leave not selected channels untouched.
>> > 
>> > To prevent unwanted clock edges on first use, an empty dummy
>> > transmission shall be done by the initialization procedure of the device
>> > driver of this channel. This will set the clock mode to the correct state.
> The patch does the right thing, so:
> 
> Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Only the above sentence is not clear to me. By device driver you mean
> the SPI slave driver (flash, PMIC), right? Isn't this what
> bitbang->setup_transfer(spi, NULL), called from spi_bitbang_setup() already
> does? spi_bitbang_setup should be called while adding a new SPI slave
> device and the setup_transfer with an empty message should setup the
> config register correctly without involing the slave device driver.
> 
> Sascha
> 
"Higher device driver" is a "historical" protocol stack to unify our
data transfer via several physical interfaces, here SPI. This driver
requires own control to the CS signal to start data transfer only if CS
is acknowledged by the external SPI slave device via GPIO/IRQ. Therefore
we can not rely on iMX6 SPI controller IP or kernel driver CS/RDY
functionality. The CS signal is active before the SPI driver is involved
and if the SPI driver changes the clock polarity, the unwanted clock
edge is destroying the data transfer.

Thanks and regards

Knut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
