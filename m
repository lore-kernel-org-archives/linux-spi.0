From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: Add missing error handling for CS GPIOs
Date: Mon, 8 Apr 2019 13:12:44 +0200
Message-ID: <CACRpkdaY=0hhNL0c+Gr7JnE-9UFVAqXUXGUWA3+KYm2sAwc=MA@mail.gmail.com>
References: <20190403144656.8257-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403144656.8257-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 3, 2019 at 4:46 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> While devm_gpiod_get_index_optional() returns NULL if the GPIO is not
> present (i.e. -ENOENT), it may still return other error codes, like
> -EPROBE_DEFER.  Currently these are not handled, leading to
> unrecoverable failures later in case of probe deferral:
>
>     gpiod_set_consumer_name: invalid GPIO (errorpointer)
>     gpiod_direction_output: invalid GPIO (errorpointer)
>     gpiod_set_value_cansleep: invalid GPIO (errorpointer)
>     gpiod_set_value_cansleep: invalid GPIO (errorpointer)
>     gpiod_set_value_cansleep: invalid GPIO (errorpointer)
>
> Detect and propagate errors to fix this.
>
> Fixes: f3186dd876697e69 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good catch! Sorry for my bugs...
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
