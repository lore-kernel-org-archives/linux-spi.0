From: "DATACOM - Jonatas.Rech" <jonatas.rech-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-espi: fix behaviour for full-duplex xfers
Date: Wed, 22 Apr 2015 12:09:03 -0300 (BRT)
Message-ID: <363371145.339730.1429715343024.JavaMail.zimbra@datacom.ind.br>
References: <1429111398-21444-1-git-send-email-jonatas.rech@datacom.ind.br> <20150418125556.GR26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150418125556.GR26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

That's right.

The m25p80 driver can send down a message that's bigger than the amount the spi-fsl-espi driver can handle in a single espi_transfer (64KiB), when the application wants to read the whole memory content, for instance. In this case, the Freescale driver splits the message in 64KiB chunks, adding a "Read the next 64KiB" command in the TX buffer so the flash memory can output data from the expected offset. In the end, the m25p80 driver sees all the data as one big rx_buf, as it expected in the first place.

I don't think a controller driver should make this kind of assumption on how protocol (slave device) drivers intend to use it. Instead, I think this kind of intelligence (about fragmentation and replaying of TX commands) should be in the protocol drivers themselves, aware of the maximum message length the hardware can handle.

Unfortunately, I don't know how many protocol drivers currently rely on this, or even how other controller drivers deal with this expected behavior.


----- Original Message -----
From: "Mark Brown" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: "DATACOM" <jonatas.rech-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Sent: Saturday, April 18, 2015 9:55:56 AM
Subject: Re: [PATCH] spi: fsl-espi: fix behaviour for full-duplex xfers

On Wed, Apr 15, 2015 at 12:23:18PM -0300, Jonatas Rech wrote:

> Furthermore, this correction has exposed an inconsistency in the
> protocol driver <-> controller driver interaction. The spi-fsl-espi
> driver artificially inserts TX bytes when message fragmentation is
> necessary (due to SPCOM_TRANLEN_MAX) instead of informing the
> protocol driver of the hardware limitation. This was tested with the
> m25p80 NOR flash protocol driver. Since fixing this issue may cause
> other client drivers to malfunction, it was left as is.

Sorry, you're saying that the driver is sending more data than it's
being asked to in some situations?  That is a *very* serious bug in both
this driver and any other driver which relies on (as opposed to merely
tolerates) this behaviour.  If that is the case it really needs to be
fixed fairly urgently.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
