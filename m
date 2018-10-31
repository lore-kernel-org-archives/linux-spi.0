From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v1 00/14] Rockchip SPI cleanup and use interrupts
Date: Wed, 31 Oct 2018 12:20:00 +0100
Message-ID: <4443653.p1DpZLIVTj@diego>
References: <20181031105711.19575-1-esmil@mailme.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: Emil Renner Berthing <esmil@mailme.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am Mittwoch, 31. Oktober 2018, 11:56:57 CET schrieb Emil Renner Berthing:
> Emil Renner Berthing (14):
>   spi: rockchip: make spi_enable_chip take bool
>   spi: rockchip: use designated init for dma config
>   spi: rockchip: always use SPI mode
>   spi: rockchip: use atomic_t state
>   spi: rockchip: disable spi on error
>   spi: rockchip: read transfer info directly
>   spi: rockchip: don't store dma channels twice
>   spi: rockchip: remove master pointer from dev data
>   spi: rockchip: simplify use_dma logic
>   spi: rockchip: set min/max speed
>   spi: rockchip: precompute rx sample delay
>   spi: rockchip: use irq rather than polling
>   spi: rockchip: support 4bit words
>   spi: rockchip: support lsb-first mode

The series, on rk3288 with cros-ec and spi-flash, rk3328 with a spi-flash, 
rk3399 with cros-ec and spi-flash:

Tested-by: Heiko Stuebner <heiko@sntech.de>
