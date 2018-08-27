From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: -next: Traceback at at drivers/spi/spi.c:2179 spi_register_controller
Date: Mon, 27 Aug 2018 12:41:16 +0200
Message-ID: <CAMuHMdUugeKbUgfKpwYCXQrpMys8hrWUXr0FZWAW7ryeZoS1dg@mail.gmail.com>
References: <20180823200834.GA9368@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, kirill.kapranov@compulab.co.il,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823200834.GA9368@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Guenter,

On Thu, Aug 23, 2018 at 10:08 PM Guenter Roeck <linux@roeck-us.net> wrote:
> I see the attached warning when booting 'sabrelite' images in qemu,
> using imx_v6_v7_defconfig and imx6dl-sabrelite.dts.
>
> Context suggests that the warning is seen since commit 1a4327fbf4554 ("spi:
> fix IDR collision on systems with both fixed and dynamic SPI bus numbers").
>
> Guenter
>
> ---
> [    7.105230] ------------[ cut here ]------------
> [    7.105509] WARNING: CPU: 0 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x7dc/0x938
> [    7.105760] couldn't get idr

Correct, all SPI controllers instantiated from DT and using DT aliases
are broken.

https://lore.kernel.org/lkml/20180821095303.27664-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
