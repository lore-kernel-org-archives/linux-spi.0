From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: randconfig build error with next-20150413, in drivers/spi/spi-bcm2835.c
Date: Mon, 13 Apr 2015 11:06:25 -0600
Message-ID: <552BF791.1040309@wwwdotorg.org>
References: <CA+r1ZhhhTu+X6bCeparH-BO=+Gs_BA4aPPF7A=E15x2QWUpYUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jim Davis <jim.epost@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next <linux-next@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	broonie <broonie@kernel.org>, lee@kernel.org,
	linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
To: Martin Sperl <kernel@martin.sperl.org>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CA+r1ZhhhTu+X6bCeparH-BO=+Gs_BA4aPPF7A=E15x2QWUpYUA@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/13/2015 10:52 AM, Jim Davis wrote:
> Building with the attached random configuration file,
>
> drivers/spi/spi-bcm2835.c: In function 'chip_match_name':
> drivers/spi/spi-bcm2835.c:356:21: error: dereferencing pointer to
> incomplete type
>    return !strcmp(chip->label, data);
>                       ^
> drivers/spi/spi-bcm2835.c: In function 'bcm2835_spi_setup':
> drivers/spi/spi-bcm2835.c:382:2: error: implicit declaration of
> function 'gpiochip_find' [-Werror=implicit-function-declaration]
>    chip = gpiochip_find("pinctrl-bcm2835", chip_match_name);
>    ^
> drivers/spi/spi-bcm2835.c:382:7: warning: assignment makes pointer
> from integer without a cast
>    chip = gpiochip_find("pinctrl-bcm2835", chip_match_name);
>         ^
> drivers/spi/spi-bcm2835.c:387:21: error: dereferencing pointer to
> incomplete type
>    spi->cs_gpio = chip->base + 8 - spi->chip_select;
>                       ^
> drivers/spi/spi-bcm2835.c: In function 'chip_match_name':
> drivers/spi/spi-bcm2835.c:357:1: warning: control reaches end of
> non-void function [-Wreturn-type]
>   }
>   ^

Martin,

I think you need to update spi-bcm2835's Kconfig to add a dependency on 
GPIO.
