From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 5/5] ARM: dts: ls1021a-tsn: Use the DSPI controller in
 poll mode
Date: Wed, 11 Sep 2019 14:33:51 +0800
Message-ID: <20190911063350.GB17142@dragon>
References: <20190822211514.19288-1-olteanv@gmail.com>
 <20190822211514.19288-6-olteanv@gmail.com>
 <CA+h21hqWGDCfTg813W1WaXFnRsMdE30WnaXw5TJvpkSp0-w5JA@mail.gmail.com>
 <20190827180502.GF23391@sirena.co.uk>
 <CA+h21hr3qmTG1LyWsEp+hZZW2NJFtg9Dh1k6SXVDd+A_YSQjjw@mail.gmail.com>
 <20190827181318.GG23391@sirena.co.uk>
 <CA+h21hqMVdsUjBdtiHKtKGpyvuaOf25tc4h-GdDEBQqa3EB7tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, Rob Herring <robh@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hqMVdsUjBdtiHKtKGpyvuaOf25tc4h-GdDEBQqa3EB7tw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 27, 2019 at 09:16:39PM +0300, Vladimir Oltean wrote:
> On Tue, 27 Aug 2019 at 21:13, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Tue, Aug 27, 2019 at 09:06:14PM +0300, Vladimir Oltean wrote:
> > > On Tue, 27 Aug 2019 at 21:05, Mark Brown <broonie@kernel.org> wrote:
> > > > On Mon, Aug 26, 2019 at 04:10:51PM +0300, Vladimir Oltean wrote:
> >
> > > > > I noticed you skipped applying this patch, and I'm not sure that Shawn
> > > > > will review it/take it.
> > > > > Do you have a better suggestion how I can achieve putting the DSPI
> > > > > driver in poll mode for this board? A Kconfig option maybe?
> >
> > > > DT changes go through the relevant platform trees, not the
> > > > subsystem trees, so it's not something I'd expect to apply.
> >
> > > But at least is it something that you expect to see done through a
> > > device tree change?
> >
> > Well, it's not ideal - if it performs better all the time the
> > driver should probably just do it unconditionally.  If there's
> > some threashold where it tends to perform better then the driver
> > should check for that but IIRC it sounds like the interrupt just
> > isn't at all helpful here.
> 
> I can't seem to find any situation where it performs worse. Hence my
> question on whether it's a better idea to condition this behavior on a
> Kconfig option rather than a DT blob which may or may not be in sync.

DT is a description of hardware not condition for software behavior,
where module parameter is usually used for.

Shawn
