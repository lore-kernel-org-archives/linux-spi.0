From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [RFC PATCH] spi: tle620x: remove stale driver
Date: Fri, 2 Aug 2019 17:42:29 +0900
Message-ID: <CAK7LNASq-WB5zJ+3uFHtzxtc2Vhmv5SKRXA2JwwFGrR5q9uMnw@mail.gmail.com>
References: <20190728161304.32022-1-yamada.masahiro@socionext.com> <20190729105125.GA4787@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729105125.GA4787@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 29, 2019 at 7:51 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 29, 2019 at 01:13:04AM +0900, Masahiro Yamada wrote:
> > This driver seems obsolte because this driver needs platform data
> > but no one in upstream passes it.
>
> I've not noticed this driver getting in the way of anything?


I just happened to take a look at include/linux/spi/tle62x0.h
when I was working on my header-test feature of Kbuild.

Then, I asked this in ML, and Arnd was positive
for deleting this.

https://lkml.org/lkml/2019/7/21/19


IMHO, stale code should be cleaned away periodically.

Yet, if you are happy with keeping this driver,
that is fine.

If we could get comments from Ben Books,
that would be helpful.




-- 
Best Regards
Masahiro Yamada
