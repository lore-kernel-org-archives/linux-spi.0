From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is created
Date: Sun, 23 Jul 2017 01:07:10 +0300
Message-ID: <CAHp75Ve5yrURc3HGHz3nPR1K_+hYdH1mUuBhm_FuFCt8q=DnQQ@mail.gmail.com>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
To: Jan Kiszka <jan.kiszka@web.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka@web.de> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Avoid hogging chip select GPIOs just because they are listed for the
> master. They might be mulitplexed and, if no slave device is attached,
> used for different purposes. Moreover, this strategy avoids having to
> allocate a cs_gpiods structure.
>
> Tested on the IOT2000 where the second SPI bus is connected to an
> Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
> usage.

Sorry for late reply, this patch makes impossible to use GPIO
descriptors. Now it's broken in two ways as I can see.
I fixed one, and is right now hunting another problem.

P.S. Perhaps no need to revert, just heads up.

(That's why would be better to have GPIO descriptors everywhere in
this driver and tested)

-- 
With Best Regards,
Andy Shevchenko
