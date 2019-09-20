From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: spi-gpio: fix crash when num-chipselects is 0
Date: Fri, 20 Sep 2019 10:22:21 +0200
Message-ID: <CACRpkda30tm0cVHpZHnjQki86m_4ZfGiufg8e=6Rx-S+zFHF_g@mail.gmail.com>
References: <20190918155200.12614-1-dqfext@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi@vger.kernel.org>,
        stable <stable@vger.kernel.org>
To: DENG Qingfang <dqfext@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190918155200.12614-1-dqfext@gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 18, 2019 at 5:52 PM DENG Qingfang <dqfext@gmail.com> wrote:

> The cause is spi_gpio_setup() did not check if the spi-gpio has chipselect pins
> before setting their direction and results in derefing an invalid pointer.
>
> The bug is spotted in kernel 4.19.72 on OpenWrt, and does not occur in 4.14.
>
> There is a similar fix upstream 249e2632dcd0509b8f8f296f5aabf4d48dfd6da8.

So since this is fixed upstream I assume you mean that this should be for
stable v4.19?

I think the stable people want a special commit message structure,
see:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Yours,
Linus Walleij
