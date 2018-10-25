From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] spi: spi-geni-qcom: fix nitpicks
Date: Thu, 25 Oct 2018 13:00:53 -0700
Message-ID: <CAD=FV=X7Rhwhz2YH8EZ0mBRuC0rO-Wns=MOuy1-FCnwn0Z=wAg@mail.gmail.com>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org> <1540485629-5970-2-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
To: alokc@codeaurora.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540485629-5970-2-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,
On Thu, Oct 25, 2018 at 9:40 AM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> fixed the nitpicks.

I probably would have put more a proper sentence, like:

Fixed small nits that were pointed out on the mailing list.  No
functional change expected.

...but I guess it's up to Mark if he cares.


> @@ -533,7 +530,7 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>
>         writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
>         spin_unlock_irqrestore(&mas->lock, flags);
> -       return ret;
> +       return IRQ_HANDLED;

I probably would have put a blank line before the return while I was
at it, but it's not a big deal to me.

Thanks for following up.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
