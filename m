From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH spi for-5.4 2/5] spi: Add a PTP system timestamp to the
 transfer structure
Date: Sat, 24 Aug 2019 15:38:16 +0300
Message-ID: <CA+h21hrwJi1ftJn56RrfobdkcCpsKZGy1VV1+ANWpxoKxwRmwA@mail.gmail.com>
References: <20190818182600.3047-1-olteanv@gmail.com> <20190818182600.3047-3-olteanv@gmail.com>
 <20190822171137.GB23391@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Hubert Feurstein <h.feurstein@gmail.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190822171137.GB23391@sirena.co.uk>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 22 Aug 2019 at 21:19, Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Aug 18, 2019 at 09:25:57PM +0300, Vladimir Oltean wrote:
>
> > @@ -1391,6 +1402,13 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
> >               goto out;
> >       }
> >
> > +     if (!ctlr->ptp_sts_supported) {
> > +             list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
> > +                     xfer->ptp_sts_word_pre = 0;
> > +                     ptp_read_system_prets(xfer->ptp_sts);
> > +             }
> > +     }
> > +
>
> We can do better than this for controllers which use transfer_one().
>

You mean I should guard this "if", and the one below, with "&&
!ctlr->transfer_one"?

> > +const void *spi_xfer_ptp_sts_word(struct spi_transfer *xfer, bool pre)
> > +{
>
> xfer can be const here too.
>
> > + * @ptp_sts_supported: If the driver sets this to true, it must provide a
> > + *   time snapshot in @spi_transfer->ptp_sts as close as possible to the
> > + *   moment in time when @spi_transfer->ptp_sts_word_pre and
> > + *   @spi_transfer->ptp_sts_word_post were transmitted.
> > + *   If the driver does not set this, the SPI core takes the snapshot as
> > + *   close to the driver hand-over as possible.
>
> A couple of issues here.  The big one is that for PIO transfers
> this is going to either complicate the code or introduce overhead
> in individual drivers for an extremely niche use case.  I guess
> most drivers won't implement it which makes this a bit moot but
> then this is a concern that pushes back against the idea of
> implementing the feature.
>

The concern is the overhead in terms of code, or runtime performance?
Arguably the applications that require deterministic latency are
actually going to push for overall less overhead at runtime, even if
that comes at a cost in terms of code size. The spi-fsl-dspi driver
does not perform worse by any metric after this rework.

> The other is that it's not 100% clear what you're looking to
> timestamp here - is it when the data goes on the wire, is it when
> the data goes on the FIFO (which could be relatively large)?  I'm
> guessing you're looking for the physical transfer here, if that's
> the case should there be some effort to compensate for the delays
> in the controller?

The goal is to timestamp the moment when the SPI slave sees word N of
the data. Luckily the DSPI driver raises the TCF (Transfer Complete
Flag) once that word has been transmitted, which I used to my
advantage. The EOQ mode behaves similarly, but has a granularity of 4
words. The controller delays are hence implicitly included in the
software timestamp.
But the question is valid and I expect that such compensation might be
needed for some hardware, provided that it can be measured and
guaranteed. In fact Hubert did add such logic to the v3 of his MDIO
patch: https://lkml.org/lkml/2019/8/20/195 There were some objections
mainly related to the certainty of those offset corrections. I don't
want to "future-proof" the API now with features I have no use of, but
such compensation logic might come in the future.

Regards,
-Vladimir
