From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in spi_unregister_master
Date: Thu, 16 May 2019 10:25:11 +0200
Message-ID: <CAMuHMdUMBg9HL8PQvkHvppP+qJ6fWjs0ZbFTX=8x0A1_AVUJqw@mail.gmail.com>
References: <20190516075656.25880-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Axel Lin <axel.lin@ingics.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, albeu@free.fr,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516075656.25880-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 16, 2019 at 9:57 AM YueHaibing <yuehaibing@huawei.com> wrote:
> If spi_register_master fails in spi_bitbang_start
> because device_add failure, We should return the
> error code other than 0, otherwise calling
> spi_bitbang_stop may trigger NULL pointer dereference
> like this:
>
> BUG: KASAN: null-ptr-deref in __list_del_entry_valid+0x45/0xd0
> Read of size 8 at addr 0000000000000000 by task syz-executor.0/3661

[...]

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 702a4879ec33 ("spi: bitbang: Let spi_bitbang_start() take a reference to master")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
