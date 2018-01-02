From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5] Rewrite GPIO SPI to use descriptors
Date: Tue, 2 Jan 2018 09:15:43 +0100
Message-ID: <CACRpkdY4iFdHbFizEGZqJ=jt9ScZCwU23Z6PfVd5v2_9Duf+iA@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101133749.29567-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jan 1, 2018 at 2:37 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> Just as it says, this rewrites the GPIO bit-banged SPI driver to
> just use GPIO descriptors and pushes the configuration of the GPIO
> lines down into devices trees and board files.

I pulled this into my Gemini tree where I have a bit-banged SPI device
based on device tree, and everything works smoothly. So all DT-based
users of GPIO SPI should be working fine after this series.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
