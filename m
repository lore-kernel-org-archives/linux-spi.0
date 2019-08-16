From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [RFC PATCH net-next 04/11] spi: spi-fsl-dspi: Cosmetic cleanup
Date: Fri, 16 Aug 2019 15:37:46 +0300
Message-ID: <CA+h21hoP3t6j2mTd2BLwizqbFap+9Z2vdxQ4ahHS3-7Vr31Lxw@mail.gmail.com>
References: <20190816004449.10100-1-olteanv@gmail.com> <20190816004449.10100-5-olteanv@gmail.com>
 <20190816122103.GE4039@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190816122103.GE4039@sirena.co.uk>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, 16 Aug 2019 at 15:21, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 16, 2019 at 03:44:42AM +0300, Vladimir Oltean wrote:
> > This patch addresses some cosmetic issues:
> > - Alignment
> > - Typos
> > - (Non-)use of BIT() and GENMASK() macros
> > - Unused definitions
> > - Unused includes
> > - Abuse of ternary operator in detriment of readability
> > - Reduce indentation level
>
> This is difficult to review since there's a bunch of largely unrelated
> changes all munged into one patch.  It'd be better to split this up so
> each change makes one kind of fix, and better to do this separately to
> the rest of the series.  In particular having alignment changes along
> with other changes hurts reviewability as it's less immediately clear
> what's a like for liken substitution.

Yes, the diff of this patch looks relatively bad. But I don't know if
splitting it in more patches isn't in fact going to pollute the git
history, so I can just as well drop it.

Regards,
-Vladimir
