From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH RFC] spi: add flow controll support
Date: Mon, 29 Feb 2016 14:11:51 +0100
Message-ID: <667217D5-C576-46CE-A8B3-BD2CF49C5A81@sperl.org>
References: <1456747459-8559-1-git-send-email-linux@rempel-privat.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456747459-8559-1-git-send-email-linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> 
> On 29.02.2016, at 13:04, Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org> wrote:
> 
> Different HW implement different variants of SPI based flow control (FC).
> To flexible FC implementation a spited it to fallowing common parts:
> Flow control: Request Sequence
> Master CS   |-------2\_____________________|
> Slave  FC   |-----1\_______________________|
> DATA        |-----------3\_________________|
> 
> Flow control: Ready Sequence
> Master CS   |-----1\_______________________|
> Slave  FC   |--------2\____________________|
> DATA        |-----------3\_________________|
> 
> Flow control: ACK End of Data
> Master CS   |______________________/2------|
> Slave  FC   |________________________/3----|
> DATA        |__________________/1----------|
> 
> Flow control: Pause
> Master CS   |_______________________/------|
> Slave  FC   |_______1/-----\3______/-------|
> DATA        |________2/------\4___/--------|

The MAX187/189 SPI-ADC implements a different kind of
flow control that is signaling inline on DATA/MISO:

Master CS   |-----1\_______________________|
MISO/DATA   |------2\____3/----------------|
CONV START  |       ^                      |
DATA READY  |             ^                |

So when CS get asserted (1) 
MISO/DATA becomes dominant low (2) and the ADC conversion starts
  (within 100ns of (1))
When MISO/DATA goes dominant high (3) then the conversion has finished
and the transfer may start.

A flow-control interface should also cover similar cases - or
at least get designed so that such a case can also get handled
by the framework in the future as well.

> +
> +/* spi_fc_probe should be called by spi_device driver. */
> +int spi_fc_probe(struct spi_device *spi)
> ...
> +}
> +EXPORT_SYMBOL_GPL(spi_fc_probe);

Please add kernel doc to the exported methods

Please put per driver changes into a separate patch.

Also missing from the patch(set) is the dt-bindings documentation - 
see Documentation/devicetree/bindings/spi/spi-bus.txt.

Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
