From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
Date: Fri, 10 May 2019 17:24:02 -0700
Message-ID: <CABXOdTfaei3A8VN_-v_BvOKJD7=GPfO7pPCMY+2duOxH4FoZvA@mail.gmail.com>
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-2-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510223437.84368-2-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>
Date: Fri, May 10, 2019 at 3:35 PM
To: Mark Brown, Benson Leung, Enric Balletbo i Serra
Cc: <linux-rockchip@lists.infradead.org>, <drinkcat@chromium.org>,
Guenter Roeck, <briannorris@chromium.org>, <mka@chromium.org>, Douglas
Anderson, <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>

> If a controller specifies that it needs high priority for sending
> messages we should always schedule our transfers on the thread.  If we
> don't do this we'll do the transfer in the caller's context which
> might not be very high priority.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/spi/spi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 8eb7460dd744..0597f7086de3 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1230,8 +1230,11 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
>                 return;
>         }
>
> -       /* If another context is idling the device then defer */
> -       if (ctlr->idling) {
> +       /*
> +        * If another context is idling the device then defer.
> +        * If we are high priority then the thread should do the transfer.
> +        */
> +       if (ctlr->idling || (ctlr->rt && !in_kthread)) {
>                 kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);
>                 spin_unlock_irqrestore(&ctlr->queue_lock, flags);
>                 return;
> --
> 2.21.0.1020.gf2820cf01a-goog
>
