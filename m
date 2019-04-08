From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: spi-gpio: Remove spi->controller_data comment
Date: Mon, 8 Apr 2019 13:11:50 +0200
Message-ID: <CACRpkdb1AKiuQEsysmOse+qzv4GhJZ1nHQraJozNntORYE0XnA@mail.gmail.com>
References: <20190403144602.8098-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403144602.8098-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 3, 2019 at 4:46 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The conversion from GPIO numbers to GPIO descriptors removed the use of
> spi->controller_data, but forgot to update a comment referring to it.
>
> Fixes: 9b00bc7b901ff672 ("spi: spi-gpio: Rewrite to use GPIO descriptors")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
