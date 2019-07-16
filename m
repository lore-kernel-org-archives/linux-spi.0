From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Revert "gpio/spi: Fix spi-gpio regression on active high CS"
Date: Tue, 16 Jul 2019 10:56:40 +0200
Message-ID: <CACRpkdaLQzax2XPJ4j1a9gNw3r=ZizVSgsbLFGAycCLd2TzD0g@mail.gmail.com>
References: <20190715204529.9539-1-linus.walleij@linaro.org> <20190716012712.BC9F22173C@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        stable <stable@vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190716012712.BC9F22173C@mail.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 16, 2019 at 3:27 AM Sasha Levin <sashal@kernel.org> wrote:

> v5.2.1: Build OK!
> v5.1.18: Failed to apply! Possible dependencies:
(...)
> How should we proceed with this patch?

Only apply it to 5.2.y once upstream.

Thanks!
Linus Walleij
