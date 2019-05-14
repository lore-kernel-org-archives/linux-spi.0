From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
Date: Tue, 14 May 2019 10:30:38 +0100
Message-ID: <20190514093038.GB8665@sirena.org.uk>
References: <20190510223437.84368-1-dianders@chromium.org>
 <20190510223437.84368-2-dianders@chromium.org>
 <20190512073301.GC21483@sirena.org.uk>
 <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Cc: Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Doug Anderson <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2019 at 01:24:57PM -0700, Doug Anderson wrote:
> On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:

> > If performance is important you probably also want to avoid the context
> > thrashing - executing in the calling context is generally a substantial
> > performance boost.  I can see this causing problems further down the
> > line when someone else turns up with a different requirement, perhaps in
> > an application where the caller does actually have a raised priority
> > themselves and just wanted to make sure that the thread wasn't lower
> > than they are.  I guess it'd be nice if we could check what priority the
> > calling thread has and make a decision based on that but there don't
> > seem to be any facilities for doing that which I can see right now.

> In my case performance is 2nd place to a transfer not getting
> interrupted once started (so we don't break the 8ms rule of the EC).

That's great but other users do care very much about performance and are
also interested in both priority control and avoiding context thrashing.

> My solution in v2 of my series is to take out the forcing in the case
> that the controller wanted "rt" priority and then to add "force" to
> the parameter name.  If someone wants rt priority for the thread but
> doesn't want to force all transfers to the thread we can later add a
> different parameter for that?

I think that's going to be the common case for this.  Forcing context
thrashing is really not something anyone else is asking for.

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzair4ACgkQJNaLcl1U
h9DoXAf/fzz5EFthAbXe19mb473HQldgqE56pd7CBSi1QQH5k+puSKto+29/CYoj
aZR8w3Cn56+X0xB3rPvvkQzvpr/Och2AYJ2EX4lbrX/YnLEPjlZwaYUbZWFh/mLi
5lgWO8TLgLafUNknlatJCG/fh3MTBOxKtKNi8awjM7ucNn+/h0COCeml9nPe6IGg
x+FlA7n4W4jrUbcndTHtUeW0JudK6IP4+eGImK6alhoz0YiIsmo1lWUPzDAtW2zC
iOMaS3WleNJRO4VS5wmQMAmmjjvg/fKLbeZLQRDcRir6eiHZbwCW5R/b3K7aMNh2
AXHNWcOHpgqSOu3CNcqik6IZyox8vw==
=ktFw
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
