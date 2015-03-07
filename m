From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC/PATCHv2 1/3] spi: dw-spi: Single Register read to clear IRQs
Date: Sat, 7 Mar 2015 21:46:32 +0200
Message-ID: <CAHp75Vedevi1E9UHLMT7iOGPY9VB=twmH_JPWGfYC8-tJsMStg@mail.gmail.com>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>
	<1425685594-26595-2-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Jiri Kosina <jkosina@suse.cz>, Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	ijc+devicetree@hellion.org.uk, dinguyen@opensource.altera.com,
	Linux Documentation List <linux-doc@vger.kernel.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	tthayer.linux@gmail.com, Axel Lin <axel.lin@ingics.com>,
	baruch@tkos.co.il,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kumar Gala <galak@codeaurora.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
To: tthayer@opensource.altera.com
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1425685594-26595-2-git-send-email-tthayer@opensource.altera.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Mar 7, 2015 at 1:46 AM,  <tthayer@opensource.altera.com> wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
>
> Instead of clearing the RxU, RxO, and TxO IRQs individually with
> 3 register reads, a single read of the ICR register will do the
> same thing.
>
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Rather Suggested-by: =E2=80=A6

Otherwise,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
>  drivers/spi/spi-dw.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 950bc50..c5fa2be 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -258,9 +258,7 @@ static irqreturn_t interrupt_transfer(struct dw_s=
pi *dws)
>
>         /* Error handling */
>         if (irq_status & (SPI_INT_TXOI | SPI_INT_RXOI | SPI_INT_RXUI)=
) {
> -               dw_readw(dws, DW_SPI_TXOICR);
> -               dw_readw(dws, DW_SPI_RXOICR);
> -               dw_readw(dws, DW_SPI_RXUICR);
> +               dw_readw(dws, DW_SPI_ICR);
>                 int_error_stop(dws, "interrupt_transfer: fifo overrun=
/underrun");
>                 return IRQ_HANDLED;
>         }
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
With Best Regards,
Andy Shevchenko
