From: Ryan Case <ryandcase@chromium.org>
Subject: Re: [PATCH v2 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date: Thu, 20 Sep 2018 16:47:59 -0700
Message-ID: <CACjz--kKjm4PnXR8Zfe2BvDYDu4KQ=3nNWfXAPwz3o_JAOw5Vg@mail.gmail.com>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <20180920224055.164856-2-ryandcase@chromium.org> <3b7c090f-42ef-1b5d-0708-0b3b52d49302@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: rdunlap@infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b7c090f-42ef-1b5d-0708-0b3b52d49302@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 20, 2018 at 3:46 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/20/18 3:40 PM, Ryan Case wrote:
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index de03d67bcd2b..36922e12c3b0 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -549,6 +549,12 @@ config SPI_RSPI
> >       help
> >         SPI driver for Renesas RSPI and QSPI blocks.
> >
> > +config SPI_QCOM_QSPI
> > +     tristate "QTI QPSPI controller"
>
>         Is that       QPSPI correct?
>         This is the only place that QPSPI or PSPI is used in this patch.
>

Thanks Randy, that is a typo. I'll fix this in the next revision in a
day or two pending further feedback.
