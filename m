From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/36] ARM: s3c: move regs-spi.h into spi driver
Date: Wed, 23 Oct 2019 15:21:27 +0200
Message-ID: <CAK8P3a2LnsqfFf4X2XrBMHBuBKZOHYQtwv4_Hj7RFC1wkPAwqQ@mail.gmail.com>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-13-arnd@arndb.de> <20191023123200.GC11048@pi3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-spi <linux-spi@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191023123200.GC11048@pi3>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Wed, Oct 23, 2019 at 2:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:29:57PM +0200, Arnd Bergmann wrote:

> > diff --git a/arch/arm/plat-samsung/include/plat/regs-spi.h b/drivers/spi/spi-s3c24xx-regs.h
> > similarity index 95%
> > rename from arch/arm/plat-samsung/include/plat/regs-spi.h
> > rename to drivers/spi/spi-s3c24xx-regs.h
> > index 607844311566..37b93ff7c7fe 100644
> > --- a/arch/arm/plat-samsung/include/plat/regs-spi.h
> > +++ b/drivers/spi/spi-s3c24xx-regs.h
> > @@ -8,9 +8,6 @@
> >  #ifndef __ASM_ARCH_REGS_SPI_H
> >  #define __ASM_ARCH_REGS_SPI_H
>
> Can you also update the guard name?

Ok, changed to __SPI_S3C2410_H, this seems to be the most common format
in spi drivers.

       Arnd
