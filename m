From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date: Fri, 28 Sep 2018 17:18:47 -0700
Message-ID: <CAD=FV=VY_BvyQywUQMwTuRw=Niq0JMaaJQNrpsGiNF8kt_Wsww@mail.gmail.com>
References: <20180926205204.184898-1-ryandcase@chromium.org>
 <20180926205204.184898-2-ryandcase@chromium.org> <153803059441.119890.891880266219521584@swboyd.mtv.corp.google.com>
 <CACjz--=Qj8Jd9yCvox1MGh1PFkHAzpt1L0OwPkMhtV30_jCDWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Trent Piepho <tpiepho@impinj.com>, boris.brezillon@bootlin.com,
        Girish Mahadevan <girishm@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: ryandcase@chromium.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACjz--=Qj8Jd9yCvox1MGh1PFkHAzpt1L0OwPkMhtV30_jCDWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Fri, Sep 28, 2018 at 11:20 AM Ryan Case <ryandcase@chromium.org> wrote:
> > > +       master->max_speed_hz = 300000000;
> > > +       master->num_chipselect = QSPI_NUM_CS;
> > > +       master->bus_num = pdev->id;
> >
> > Can this come from DT aliases? I've never thought about qspi and
> > "regular" spi being in the same spi bus numbering system, but I suppose
> > that will happen now and we need to make sure that qspi numbers start
> > after the regular ones?
>
> I'm not sure. Can look into it.

In a previous response for the other Qualcomm SPI driver Mark said to
set this to -1.  Specifically the code was checking the alias and Mark
said:

> Don't do this, just set bus_num to -1 and let the core assign an ID.

[1] https://lkml.kernel.org/r/20180503233849.GF13402@sirena.org.uk

-Doug
