From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Side effect of SPI GPIO descriptor usage
Date: Thu, 5 Dec 2019 08:27:23 +0100
Message-ID: <CAMuHMdW=eoOiuucv8-p7gs=u9QK_W_Onpu37fq57xU6f+0r0qg@mail.gmail.com>
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk>
 <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
 <20191203163521.GM1998@sirena.org.uk>
 <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA@mail.gmail.com>
 <CACRpkdaxXKMqL4Y8yFu+U7WhpXgq6Yr+hx4rYd3aDzc+-dLDFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CACRpkdaxXKMqL4Y8yFu+U7WhpXgq6Yr+hx4rYd3aDzc+-dLDFw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

On Thu, Dec 5, 2019 at 12:28 AM Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> drivers/rtc/rtc-rx6110.c
> Prints a warning if not flagged SPI_CS_HIGH, wil print
> that warning if used with a GPIO chip select from device
> tree. No regression, also no in-tree users.

So this warning will trigger if the board designer added an inverter, e.g.
to make it work with an SPI controller that doesn't support CS_HIGH...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
