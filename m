From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: pxa2xx: fix PCI dependency
Date: Wed, 17 Oct 2018 22:53:48 +0200
Message-ID: <CAMuHMdUHV_eeA7Va+MdkhnercM+1yop56wL8uyMhNSz8sh6dWg@mail.gmail.com>
References: <20181017185128.2634666-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017185128.2634666-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Arnd,

On Wed, Oct 17, 2018 at 8:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
> The code reorganization broke building without CONFIG_PCI:
>
> drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_init_pdata':
> drivers/spi/spi-pxa2xx.c:1457:15: error: implicit declaration of function 'pci_match_id'; did you mean 'pci_map_sg'? [-Werror=implicit-function-declaration]
>
> Add back an #ifdef around the code block that requires it.
>
> Fixes: 87ae1d2d7077 ("spi: pxa2xx: Add devicetree support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Already fixed in spi-next by commit 9c2120090586d7e5 ("PCI: Provide
pci_match_id() with CONFIG_PCI=n").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
