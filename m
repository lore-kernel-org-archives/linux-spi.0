From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
Date: Tue, 14 May 2019 07:42:38 -0700
Message-ID: <CAD=FV=UXhQg2CuNsTCkSe1BuEvkGMj6qeUB2iF=Qfj=Z0fLiWw@mail.gmail.com>
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-2-dianders@chromium.org>
 <20190512073301.GC21483@sirena.org.uk> <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
 <20190514093038.GB8665@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190514093038.GB8665@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Tue, May 14, 2019 at 2:30 AM Mark Brown <broonie@kernel.org> wrote:

> On Mon, May 13, 2019 at 01:24:57PM -0700, Doug Anderson wrote:
> > On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:
>
> > In my case performance is 2nd place to a transfer not getting
> > interrupted once started (so we don't break the 8ms rule of the EC).
>
> That's great but other users do care very much about performance and are
> also interested in both priority control and avoiding context thrashing.
>
> > My solution in v2 of my series is to take out the forcing in the case
> > that the controller wanted "rt" priority and then to add "force" to
> > the parameter name.  If someone wants rt priority for the thread but
> > doesn't want to force all transfers to the thread we can later add a
> > different parameter for that?
>
> I think that's going to be the common case for this.  Forcing context
> thrashing is really not something anyone else is asking for.

OK, that's fair.  Even if nobody else is asking for it, the solution
I've coded up for v2 still allows cros_ec to use the SPI core's thread
in a pretty clean way and saves a bunch of code in cros_ec.  It
shouldn't penalize any other SPI users.

...but I guess you're saying that you don't want to guarantee that the
SPI core will happen to have this thread sitting around in the future
so you'd rather add the extra complexity to cros_ec so the core can
evolve more freely?

-Doug
