From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: Really keep pll clk enabled
Date: Mon, 2 Mar 2020 14:03:04 +0100
Message-ID: <CAOiHx=me0H6xjz__bJthvF0=MGJfTcRyxd8mM1SD0fwjXpVERw@mail.gmail.com>
References: <20200228213838.7124-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200228213838.7124-1-christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 28 Feb 2020 at 22:38, Christophe JAILLET
<christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
>
> The purpose of commit 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
> was to keep the pll clk enabled through the lifetime of the device.
>
> In order to do that, some 'clk_prepare_enable()'/'clk_disable_unprepare()'
> calls have been added in the error handling path of the probe function, in
> the remove function and in the suspend and resume functions.
>
> However, a 'clk_disable_unprepare()' call has been unfortunately left in
> the probe function. So the commit seems to be more or less a no-op.
>
> Axe it now, so that the pll clk is left enabled through the lifetime of
> the device, as described in the commit.

Good catch!

Acked-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>
> Fixes: 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
> Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
> ---
> To be honest, I don't see why we need to keep pll clk, or hsspi clk
> enabled during the lifetime of the driver. My understanding of the code is
> that it is only used to get the 'speed_hz' value in the probe function.
> This value is never refreshed afterwards.
> I don't see the point in enabling/disabling the clks. I think that they
> both could be disabled in the probe function, without the need to keep
> track in the bcm63xx_hsspi structure, neither during pm cycles or the
> remove fucntion.

The hsspi clock is actually gated, so it needs to stay on during use.
The pll clock is only used to convey the rate, but is not gate-able.
These used to be the same (that's why it checks for the rate of the
hsspi clock first), but were split to make it easier to move to common
clock framework (since we can just use the generic gated and
fixed-rate clock implementations).

Incidentally these are AFAIK also two inputs, so it even happens to
match the hardware more closely.

Since the pll clock isn't gated, we don't need to keep it enabled - we
don't even need to enable it in theory, but IIRC the common clock
system will complain if you try to get the rate of a non-enabled
clock. And if we do enable it, then we can also just keep it enabled
over the lifetime of the device.

Regards
Jonas
