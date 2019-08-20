From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH spi for-5.4 1/5] spi: Use an abbreviated pointer to
 ctlr->cur_msg in __spi_pump_messages
Date: Tue, 20 Aug 2019 22:36:43 +0300
Message-ID: <CA+h21hpgi7-dJ-QoRBEQorcRyEuhqhKixpFK5fGxOnZxTHi-4g@mail.gmail.com>
References: <20190818182600.3047-1-olteanv@gmail.com> <20190818182600.3047-2-olteanv@gmail.com>
 <20190820182128.GH4738@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190820182128.GH4738@sirena.co.uk>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Tue, 20 Aug 2019 at 21:21, Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Aug 18, 2019 at 09:25:56PM +0300, Vladimir Oltean wrote:
>
> >       /* Extract head of queue */
> > -     ctlr->cur_msg =
> > -             list_first_entry(&ctlr->queue, struct spi_message, queue);
> > +     mesg = list_first_entry(&ctlr->queue, struct spi_message, queue);
> > +     ctlr->cur_msg = mesg;
>
> Why mesg when the existing code uses msg as an abbreviation here?

Does it matter? I took from spi_finalize_current_message which also uses mesg.
