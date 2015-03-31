From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v4] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Tue, 31 Mar 2015 20:41:20 +0200
Message-ID: <CAOiHx=krTV-NKPD-C1jMhyjmz8qWuLmBWQVwSYGqmaFyq96QWg@mail.gmail.com>
References: <1427819134-29128-1-git-send-email-bert@biot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427819134-29128-1-git-send-email-bert-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Tue, Mar 31, 2015 at 6:25 PM, Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org> wrote:
> This driver mediates access between the connected CPLD and other devices
> on the bus.
>
> The m25p80-compatible boot flash and (some models) MMC use regular SPI,
> bitbanged as required by the SoC. However the SPI-connected CPLD has
> a "fast write" mode, in which two bits are transferred by SPI clock
> cycle. The second bit is transmitted with the SoC's CS2 pin.
>
> Protocol drivers using this fast write facility signal this by setting
> the cs_change flag on transfers.
>
> Signed-off-by: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
> ---
>  drivers/spi/Kconfig     |   6 ++
>  drivers/spi/Makefile    |   1 +
>  drivers/spi/spi-rb4xx.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 drivers/spi/spi-rb4xx.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ab8dfbe..aa76ce5 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -429,6 +429,12 @@ config SPI_ROCKCHIP
>           The main usecase of this controller is to use spi flash as boot
>           device.
>
> +config SPI_RB4XX
> +       tristate "Mikrotik RB4XX SPI master"
> +       depends on SPI_MASTER && ATH79_MACH_RB4XX

There is no ATH79_MACH_RB4XX in upstream. I suggest depending on just
ATH79, allowing maintainers/patch submitters to at least test build
any future modifications on it.


Regards
Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
