From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH] spi: document broadcom qspi driver as broken
Date: Wed, 26 Jul 2017 15:43:03 -0400
Message-ID: <CAC=U0a19FVoEhvUJg3Hyiau0+C1J74GhAy7J0Bwozm1MXKuuyg@mail.gmail.com>
References: <20170721220142.3400093-1-arnd@arndb.de> <CAC=U0a3jaNxRbScy27L+BFCs872F0kLAH80ieZNc7Uq6LwOyEQ@mail.gmail.com>
 <CAK8P3a0AegjQW9bOw9G9F=za5RALgYEzETngH0U2i049oLpmbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0AegjQW9bOw9G9F=za5RALgYEzETngH0U2i049oLpmbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jul 26, 2017 at 3:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 25, 2017 at 11:39 PM, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>> Arnd, Cyrille,
>>
>> I am working on fixing spi-bcm-qspi.c as per Cyrill's suggestion as
>> mentioned here : https://patchwork.kernel.org/patch/9624585/.
>>  And remove the use of SPINOR_OP_READ* and there by remove need to
>> include spi-nor.h.
>
> Ok, thanks a lot!
>
> Do you think your fix will be applicable to stable backports, or should we
> add a simple dependency first for the stable kernels and remove that
> dependency again with the proper fix?
>

The  fix would be applicable to stable backport, we don't need to add
a dependency.

>        Arnd

Kamal
