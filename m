From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [RFC PATCH net-next 03/11] spi: Add a PTP system timestamp to the
 transfer structure
Date: Fri, 16 Aug 2019 15:35:30 +0300
Message-ID: <CA+h21hqatTeS2shV9QSiPzkjSeNj2Z4SOTrycffDjRHj=9s=nQ@mail.gmail.com>
References: <20190816004449.10100-1-olteanv@gmail.com> <20190816004449.10100-4-olteanv@gmail.com>
 <20190816121837.GD4039@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190816121837.GD4039@sirena.co.uk>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, 16 Aug 2019 at 15:18, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 16, 2019 at 03:44:41AM +0300, Vladimir Oltean wrote:
>
> > @@ -842,6 +843,9 @@ struct spi_transfer {
> >
> >       u32             effective_speed_hz;
> >
> > +     struct ptp_system_timestamp *ptp_sts;
> > +     unsigned int    ptp_sts_word_offset;
> > +
>
> You've not documented these fields at all so it's not clear what the
> intended usage is.

Thanks for looking into this.
Indeed I didn't document them as the patch is part of a RFC and I
thought the purpose was more clear from the context (cover letter
etc).
If I do ever send a patchset for submission I will document the newly
introduced fields properly.
So let me clarify:
The SPI slave device driver is populating these fields to indicate to
the controller driver that it wants word number @ptp_sts_word_offset
from the tx buffer snapshotted. The controller driver is supposed to
put the snapshot into the @ptp_sts field, which is a pointer to a
memory location under the control of the SPI slave device driver.
It is ok if the ptp_sts pointer is NULL (no need to check), because
the API for taking snapshots already checks for that.
At the moment there is yet no proposed mechanism for the SPI slave
driver to ensure that the controller will really act upon this
request. That would be really nice to have, since some SPI slave
devices are time-sensitive and warning early is a good way to prevent
unnecessary troubleshooting.

Regards,
-Vladimir
