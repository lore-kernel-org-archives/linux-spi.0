From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
Date: Wed, 3 Oct 2018 10:46:24 -0700
Message-ID: <CAD=FV=WqO7tpvX59DuvFi2AUnnAL+=BnV5MtgNbNVKUZfvh7TQ@mail.gmail.com>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org> <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
To: alokc@codeaurora.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Wed, Oct 3, 2018 at 6:45 AM Alok Chauhan <alokc@codeaurora.org> wrote:
> +static irqreturn_t geni_spi_isr(int irq, void *data)
> +{
> +       struct spi_master *spi = data;
> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
> +       struct geni_se *se = &mas->se;
> +       u32 m_irq;
> +       unsigned long flags;
> +       irqreturn_t ret = IRQ_HANDLED;
> +
> +       if (mas->cur_mcmd == CMD_NONE)
> +               return IRQ_NONE;
> +
> +       spin_lock_irqsave(&mas->lock, flags);
> +       m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
> +
> +       if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
> +               geni_spi_handle_rx(mas);
> +
> +       if (m_irq & M_TX_FIFO_WATERMARK_EN)
> +               geni_spi_handle_tx(mas);
> +
> +       if (m_irq & M_CMD_DONE_EN) {
> +               if (mas->cur_mcmd == CMD_XFER)
> +                       spi_finalize_current_transfer(spi);
> +               else if (mas->cur_mcmd == CMD_CS)
> +                       complete(&mas->xfer_done);
> +               mas->cur_mcmd = CMD_NONE;
> +               /*
> +                * If this happens, then a CMD_DONE came before all the Tx
> +                * buffer bytes were sent out. This is unusual, log this
> +                * condition and disable the WM interrupt to prevent the
> +                * system from stalling due an interrupt storm.
> +                * If this happens when all Rx bytes haven't been received, log
> +                * the condition.
> +                * The only known time this can happen is if bits_per_word != 8
> +                * and some registers that expect xfer lengths in num spi_words
> +                * weren't written correctly.
> +                */
> +               if (mas->tx_rem_bytes) {
> +                       writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +                       dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
> +                               mas->tx_rem_bytes, mas->cur_bits_per_word);
> +               }
> +               if (mas->rx_rem_bytes)
> +                       dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
> +                               mas->rx_rem_bytes, mas->cur_bits_per_word);
> +       }
> +
> +       if ((m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN)) {
> +               mas->cur_mcmd = CMD_NONE;
> +               complete(&mas->xfer_done);
> +       }
> +
> +       writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
> +       spin_unlock_irqrestore(&mas->lock, flags);
> +       return ret;

nit: you no longer need the "ret" variable.  Just return IRQ_HANDLED
here and remove the "ret" local variable from this function.  It'd be
nice if you put a blank line before the return too.


I'm not convinced it's worth spinning the patch to fix that one nit,
but if you spin it for some other reason please fix it.  I believe
this fixes all outstanding feedback that I'm aware of.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
