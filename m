From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] spi: rspi: Use platform_get_irq_byname_optional() for optional irqs
Date: Wed, 16 Oct 2019 16:25:57 -0700
Message-ID: <5da7a706.1c69fb81.7818.0cfe@mx.google.com>
References: <20191016143101.28738-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191016143101.28738-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Geert Uytterhoeven (2019-10-16 07:31:01)
> As platform_get_irq_byname() now prints an error when the interrupt
> does not exist, scary warnings may be printed for optional interrupts:
>=20
>     renesas_spi e6b10000.spi: IRQ rx not found
>     renesas_spi e6b10000.spi: IRQ mux not found
>=20
> Fix this by calling platform_get_irq_byname_optional() instead.
> Remove the no longer needed printing of platform_get_irq errors, as the
> remaining calls to platform_get_irq() and platform_get_irq_byname() take
> care of that.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
