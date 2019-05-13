From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
Date: Mon, 13 May 2019 13:24:57 -0700
Message-ID: <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-2-dianders@chromium.org>
 <20190512073301.GC21483@sirena.org.uk>
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
In-Reply-To: <20190512073301.GC21483@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:

> On Fri, May 10, 2019 at 03:34:34PM -0700, Douglas Anderson wrote:
> > If a controller specifies that it needs high priority for sending
> > messages we should always schedule our transfers on the thread.  If we
> > don't do this we'll do the transfer in the caller's context which
> > might not be very high priority.
>
> If performance is important you probably also want to avoid the context
> thrashing - executing in the calling context is generally a substantial
> performance boost.  I can see this causing problems further down the
> line when someone else turns up with a different requirement, perhaps in
> an application where the caller does actually have a raised priority
> themselves and just wanted to make sure that the thread wasn't lower
> than they are.  I guess it'd be nice if we could check what priority the
> calling thread has and make a decision based on that but there don't
> seem to be any facilities for doing that which I can see right now.

In my case performance is 2nd place to a transfer not getting
interrupted once started (so we don't break the 8ms rule of the EC).
My solution in v2 of my series is to take out the forcing in the case
that the controller wanted "rt" priority and then to add "force" to
the parameter name.  If someone wants rt priority for the thread but
doesn't want to force all transfers to the thread we can later add a
different parameter for that?

-Doug
