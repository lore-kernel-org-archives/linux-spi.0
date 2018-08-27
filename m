From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Date: Mon, 27 Aug 2018 11:13:49 -0300
Message-ID: <CAOMZO5B43Cm+xtAMc5tLHAMzoVO0JJR+T+G0MPtC9oGAmjrP2w@mail.gmail.com>
References: <20180821095303.27664-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Kirill Kapranov <kirill.kapranov@compulab.co.il>,
        linux-spi@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180821095303.27664-1-geert+renesas@glider.be>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On Tue, Aug 21, 2018 at 6:53 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> If the SPI bus number is provided by a DT alias, idr_alloc() is called
> twice, leading to:
>
>     WARNING: CPU: 1 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x11c/0x5d8
>     couldn't get idr
>
> Fix this by moving the handling of fixed SPI bus numbers up, before the
> DT handling code fills in ctlr->bus_num.
>
> Fixes: 1a4327fbf4554d5b ("spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This fixes SPI on imx51-babbage, thanks.

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
