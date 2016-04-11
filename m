From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] spi: let SPI masters ignore their children for PM
Date: Mon, 11 Apr 2016 14:58:13 +0200
Message-ID: <CAPDyKFr9Oxcw1tdQinDeDy-y51Mcim8kZni2QtNKp3dmR-OL7w@mail.gmail.com>
References: <1460375463-15557-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1460375463-15557-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11 April 2016 at 13:51, Linus Walleij <linus.walleij@linaro.org> wrote:
> Let all SPI masters ignore their children: when it comes
> to power management: SPI children have no business doing
> keeping their parents awake: they are completely autonomous
> devices that just use their parent to talk, and the latter
> usecase must be power managed by the host itself on a
> per-message basis.
>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> ChangeLog v1->v2:
> - Change subject from
>   "let SPI masters inherit suspend child ignorance"
>   to
>   "let SPI masters ignore their PM children"
> -  Use the big hammer and do the sensible thing:
>    mark all SPI masters as ignoring their children
>    when it comes to power management.
> ---
>  drivers/spi/spi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index de2f2f90d799..6c4c050e6b65 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1764,6 +1764,7 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
>         master->num_chipselect = 1;
>         master->dev.class = &spi_master_class;
>         master->dev.parent = dev;
> +       pm_suspend_ignore_children(&master->dev, true);
>         spi_master_set_devdata(master, &master[1]);
>
>         return master;
> --
> 2.4.3
>
