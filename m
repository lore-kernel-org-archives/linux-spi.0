From: Harini Katakam <harini.katakam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] SPI: Add driver for Cadence SPI controller
Date: Tue, 18 Mar 2014 12:13:45 +0000
Message-ID: <d7cf691a-c9cb-4a8a-bf5c-eae952a5d729@VA3EHSMHS045.ehs.local>
References: <1395057936-8643-1-git-send-email-harinik@xilinx.com>
 <20140317173017.GW11706@sirena.org.uk>
 <255edf4f-05a8-4d9a-b32d-1a4a8ddaffb5@CH1EHSMHS004.ehs.local>
 <20140318110401.GH11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	"grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140318110401.GH11706-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Tuesday, March 18, 2014 4:34 PM
> To: Harini Katakam
> Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pawel.moll-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
> ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org;
> grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Michal Simek
> Subject: Re: [PATCH] SPI: Add driver for Cadence SPI controller
>
> On Tue, Mar 18, 2014 at 05:16:26AM +0000, Harini Katakam wrote:
>
> Please fix your mailer to word wrap within paragraphs, this will make
> your mail much more legible.
>
> > > > +       if (bits_per_word != 8) {
> > > > +               dev_err(&spi->dev, "%s, unsupported bits per word %x\n",
> > > > +                       __func__, spi->bits_per_word);
> > > > +               return -EINVAL;
> > > > +       }
>
> > > The core will check this for you.
>
> > I dint find that the core does this.
>
> bpw_mask.
>

OK. Will set master->bits_per_word_mask.

> > > It's not clear to me why this has been split into a separate function and
> the
> > > function will write to the hardware which you're not allowed to do in
> > > setup() if it might affect an ongoing transfer.
>
> > Are you saying  that there's a chance cdns_spi_setup() will be called
> > when there's an ongoing transfer?  In that case I have to remove the
> > cdns_setup_transfer() call from here but then there's nothing left to
> > do in setup.
>
> yes.
>

I'm going to remove the bits_per_word check anyway.
But the clock configuration still needs to be done.
Where should it be done spi_setup() or transfer?

Can you please comment on this?

"The function was split into two because cdns_spi_setup_transfer() is called internally by transfer_one_message() everytime.
Is it always possible that the spi_transfer paramters will remain the same?
In that case this call is probably not necessary in transfer_one_message."

> > > I see from further up the file that there are error interrupt states which
> > > might be flagged but these are just being ignored.
>
> > I'm not sure I understand what you are referring to -
> > The only interrupts enabled (See CNDS_IXR_DEFAULT_MASK) are TXOW
> and MODF.
>
> The code had:
>
> > +#define CDNS_SPI_IXR_TXOW_MASK 0x00000004 /* SPI TX FIFO
> Overwater */
> > +#define CDNS_SPI_IXR_MODF_MASK 0x00000002 /* SPI Mode Fault */
> > +#define CDNS_SPI_IXR_RXNEMTY_MASK 0x00000010 /* SPI RX FIFO Not
> Empty */
>
> > +#define CDNS_SPI_IXR_TXFULL_MASK       0x00000008 /* SPI TX Full */
>
> and defined:
>
> > +#define CDNS_SPI_IXR_ALL_MASK  0x0000007F /* SPI all interrupts */
>
> > > > +       return IRQ_HANDLED;
>
> > > This should only be returned if an interrupt was actually handled - if the
> line
> > > is shared in some system this will break.
>
> > In this case both possible interrupt conditions are handled.
>
> Are you sure that's the case, and even if you are that's still not
> handling the case where the device isn't flagging an interrupt at all.
>

The IXR_ALL mask is only used to disable all the interrupts in the beginning.
These two are the only interrupts enabled.
And RXNEMPTY status is just polled. That interrupt is not enabled either

Regards,
Harini


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
