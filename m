From: Hector Palacios <hector.palacios-i7dp0qKlBMg@public.gmane.org>
Subject: Re: [PATCH linux-next v5 1/1] spi: imx: Add support for SPI Slave
 mode
Date: Fri, 11 Aug 2017 13:49:55 +0200
Message-ID: <ee87ddf5-7e7d-f935-f933-a05dc2150321@digi.com>
References: <20170718044048.29736-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
        "Palacios, Hector" <Hector.Palacios-i7dp0qKlBMg@public.gmane.org>
To: <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170718044048.29736-1-jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jiada,

On 07/18/2017 06:40 AM, Jiada Wang wrote:
> Previously i.MX SPI controller only works in Master mode.
> This patch adds support to i.MX51, i.MX53 and i.MX6 ECSPI
> controller to work also in Slave mode.
> 
> Currently SPI Slave mode support patch has the following limitations:
> 1. The stale data in RXFIFO will be dropped when the Slave does any new
>    transfer.
> 2. One transfer can be finished only after all transfer->len data been
>    transferred to master device
> 3. Slave device only accepts transfer->len data. Any data longer than this
>    from master device will be dropped. Any data shorter than this from
>    master will cause SPI to stuck due to mentioned HW limitation 2.
> 4. Only PIO transfer is supported in Slave mode.

Does DMA not work in slave mode?

I have tried your patch with some modifications to use DMA but got weird results when
working with 8 bits per word. For example, when I prepare the slave to send 4 bytes:
 - BURST_LENGTH is set to 0x1F (32 bits)
 - RX_DMA_LENGTH, RX_THRESHOLD, TX_THRESHOLD in DMA Control Register are all set to 4
bytes

which looks correct but then, when I send 4 bytes from the master I see the following:
 - the TX FIFO of the slave seems to be filled in with each byte on a 32-bit word of
its own.
 - the master must send four transfers of four bytes each, for the DMA RX to trigger
on the slave.
 - The RX buffer is filled with the last byte of the master repeated four times


Graphically:
- Slave is prepared to send 4 bytes:  53 4C 41 56 ("SLAV")

	 spidev_test -D /dev/spidev0.0 -p "SLAV" -v

- Master sends 4d 41 53 54 ("MAST")
			Slave is waiting (DMA RX does not trigger)
- Master receives 00 00 00 53 (first byte of slave in a 32-bit word)

If I repeat the sending from the master three times more:
- Master sends 4d 41 53 54 ("MAST")

			Slave is waiting (DMA RX does not trigger)

- Master receives 00 00 00 4C (second byte of slave in a 32-bit word)
- Master sends 4d 41 53 54 ("MAST")

			Slave is waiting (DMA RX does not trigger)

- Master receives 00 00 00 41 (third byte of slave in a 32-bit word)
- Master sends 4d 41 53 54 ("MAST")

			DMA RX finally triggers on slave

- Master receives 00 00 00 56 (fourth byte of slave in a 32-bit word)
- Slave receives 54 54 54 54 ("TTTT", last byte sent by master, repeated)


If I use 32 bits per word, then it all works in one message:

~# spidev_test -D /dev/spidev0.0 -p "SLAV" -v -b 32
Master receives 56 41 4C 53 ("VALS")
Slave receives 54 53 41 4D ("TSAM)

Is it a known problem that DMA doesn't work properly with 8 bits per word when SPI is
configured as slave?

Thanks
--
Hector Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
