From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [RFC PATCH net-next 04/11] spi: spi-fsl-dspi: Cosmetic cleanup
Date: Sat, 17 Aug 2019 13:44:14 +0300
Message-ID: <CA+h21hr=fZ2XX3BF=YSCS86zfy9rGZDaji-VjFDVWhdcA8ppqw@mail.gmail.com>
References: <20190816004449.10100-1-olteanv@gmail.com> <20190816004449.10100-5-olteanv@gmail.com>
 <20190816122103.GE4039@sirena.co.uk> <CA+h21hoP3t6j2mTd2BLwizqbFap+9Z2vdxQ4ahHS3-7Vr31Lxw@mail.gmail.com>
 <20190816125942.GG4039@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
To: Mark Brown <broonie@kernel.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190816125942.GG4039@sirena.co.uk>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 16 Aug 2019 at 15:59, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 16, 2019 at 03:37:46PM +0300, Vladimir Oltean wrote:
> > On Fri, 16 Aug 2019 at 15:21, Mark Brown <broonie@kernel.org> wrote:
>
> > > This is difficult to review since there's a bunch of largely unrelated
> > > changes all munged into one patch.  It'd be better to split this up so
> > > each change makes one kind of fix, and better to do this separately to
> > > the rest of the series.  In particular having alignment changes along
> > > with other changes hurts reviewability as it's less immediately clear
> > > what's a like for liken substitution.
>
> > Yes, the diff of this patch looks relatively bad. But I don't know if
> > splitting it in more patches isn't in fact going to pollute the git
> > history, so I can just as well drop it.
>
> No problem with lots of patches in git history if you want to split it
> up (and probably split it out of the series).  Like I say it's mainly
> the alignment changes that it'd be better to pull out, the others really
> should be but it's easier to cope there.

Yes, normally it would make sense to pull these out of the patchset.
But basically all the future patches I plan to send to net-next for
this release somehow depend on this dspi driver rework.
My plan was that once the patchset reaches a stage where you accept
it, to ask Dave M. to temporarily pull the series into net-next as
well, so that the tree compiles and I can continue to work on other
sja1105 stuff. He can then drop it during the merge window. From that
perspective, even if the entire series takes more time to get accepted
rather than individual bits, at least there would be 1 single patchset
for Dave to pull.
Let me know if there's a better way to handle this.

Thanks,
-Vladimir
