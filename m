From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH 00/15] Unify SPI delays into an `struct spi_delay`
Date: Sun, 15 Sep 2019 11:22:05 +0100
Message-ID: <20190915112205.0007d62d@archlinux>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>, <broonie@kernel.org>,
        <f.fainelli@gmail.com>, <linus.walleij@linaro.org>,
        <orsonzhai@gmail.com>, <baolin.wang@linaro.org>,
        <zhang.lyra@gmail.com>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 13 Sep 2019 14:45:35 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Initially, I started this patchset thinking: "we need a new delay for
> something-something" (in case someone is curios, we need a CS-hold-time for
> the first transfer, because the CS wakes a chip from sleep-mode).
> 
> Then I added the delay, and felt a bit dirty-inside about adding a new one
> (just like that), and decided to look at maybe cleaning things up a bit,
> and a few days later, I got here.
> 
> Full disclaimer: this patchset is not complete. It's an RFC.
> It's based on top of Jonathan's `iio/togreg` branch which also includes the
> ADIS driver library changes and also includes `cs_change_delay`.
> 
> I'll send a V2 patchset, which just the first 4 patches, since I feel that
> those are a bit more complete.
> 
> I thought about just sending the first 4 patches on-their-own, but I
> figured that the whole series (even if not complete) serves as a better
> explanation about the whole "why?".
> 
> Hopefully, this can sort-of-explain things.
> I'll reference this RFC on the next series.

General approach looks sensible to me. Over to SPI specialists on
whether this is a sensible bit of unification to do.

Jonathan

> 
> Thanks
> 
> Alexandru Ardelean (15):
>   spi: move `cs_change_delay` backwards compat logic outside switch
>   spi: introduce spi_delay struct as "value + unit" &  spi_delay_exec()
>   spi: make `cs_change_delay` the first user of the `spi_delay` logic
>   iio: imu: adis: convert cs_change_delay to spi_delay struct
>   spi: sprd: convert transfer word delay to spi_delay struct
>   spi: orion: use new `word_delay` field for SPI transfers
>   spi: spidev: use new `word_delay` field for spi transfers
>   spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for
>     spi_device
>   spi: introduce `delay` field for `spi_transfer` + spi_transfer_exec()
>   spi: use new `spi_transfer_delay` helper where straightforward
>   spi: tegra114: use `spi_transfer_delay` helper
>   spi: spi-loopback-test: use new `delay` field
>   spi: spidev: use new `delay` field for spi transfers
>   spi: tegra114: change format for `spi_set_cs_timing()` function
>   spi: implement SW control for CS times
> 
>  drivers/iio/imu/adis.c           |  24 ++---
>  drivers/spi/spi-atmel.c          |  29 +++++-
>  drivers/spi/spi-bcm63xx-hsspi.c  |   3 +-
>  drivers/spi/spi-cavium.c         |   3 +-
>  drivers/spi/spi-fsl-dspi.c       |   3 +-
>  drivers/spi/spi-fsl-espi.c       |   3 +-
>  drivers/spi/spi-fsl-spi.c        |   3 +-
>  drivers/spi/spi-loopback-test.c  |  12 ++-
>  drivers/spi/spi-mpc512x-psc.c    |   3 +-
>  drivers/spi/spi-mpc52xx-psc.c    |   3 +-
>  drivers/spi/spi-omap-100k.c      |   3 +-
>  drivers/spi/spi-orion.c          |   6 +-
>  drivers/spi/spi-pl022.c          |  25 +++--
>  drivers/spi/spi-sc18is602.c      |   3 +-
>  drivers/spi/spi-sh-hspi.c        |   3 +-
>  drivers/spi/spi-sprd.c           |  11 ++-
>  drivers/spi/spi-tegra114.c       |  39 +++++---
>  drivers/spi/spi-tegra20-sflash.c |   2 +-
>  drivers/spi/spi-topcliff-pch.c   |   7 +-
>  drivers/spi/spi-txx9.c           |   3 +-
>  drivers/spi/spi-xcomm.c          |   3 +-
>  drivers/spi/spi.c                | 162 +++++++++++++++++++++++++------
>  drivers/spi/spidev.c             |   6 +-
>  include/linux/spi/spi.h          |  65 ++++++++++---
>  24 files changed, 293 insertions(+), 131 deletions(-)
> 
