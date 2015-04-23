From: Jonatas Rech <jonatas.rech-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-espi: fix behaviour for full-duplex xfers
Date: Thu, 23 Apr 2015 15:06:22 -0300
Message-ID: <20150423180622.GC12637@datacom.ind.br>
References: <1429111398-21444-1-git-send-email-jonatas.rech@datacom.ind.br>
 <20150418125556.GR26185@sirena.org.uk>
 <363371145.339730.1429715343024.JavaMail.zimbra@datacom.ind.br>
 <20150422195746.GM22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150422195746.GM22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 22, 2015 at 08:57:46PM +0100, Mark Brown wrote:
> On Wed, Apr 22, 2015 at 12:09:03PM -0300, DATACOM - Jonatas.Rech wrote:
> 
> Don't top post (context is important for people to know what you are
> talking about) and please fix your mailer to word wrap within
> paragraphs so your mail can be read and replied to more readily.
> 

I'm sorry for that, thanks for the heads-up.

> > The m25p80 driver can send down a message that's bigger than the
> > amount the spi-fsl-espi driver can handle in a single espi_transfer
> > (64KiB), when the application wants to read the whole memory content,
> > for instance. In this case, the Freescale driver splits the message in
> > 64KiB chunks, adding a "Read the next 64KiB" command in the TX buffer
> > so the flash memory can output data from the expected offset. In the
> > end, the m25p80 driver sees all the data as one big rx_buf, as it
> > expected in the first place.
> 
> This is completely broken.
> 
> > Unfortunately, I don't know how many protocol drivers currently rely
> > on this, or even how other controller drivers deal with this expected
> > behavior.
> 
> This is not expected behaviour for anything and should be fixed
> urgently.

I agree, but please note that this came up while I was trying to fix the
full-duplex functionality, and it's a different problem. Fixing this would
impact protocol drivers, as stated earlier. It would take some time for me to
study other drivers and come up with the best solution for this driver plus
(at least) the m25p80, which supports the hardware I currently have access to.

I know this must be fixed, but wouldn't it be subject to a different patch?
Thanks in advance for the advice.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
