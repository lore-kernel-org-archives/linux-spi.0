From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Applied "spi: sh-msiof: Fix timeout failures for TX-only DMA
 transfers" to the spi tree
Date: Thu, 4 Jan 2018 08:05:13 +0100
Message-ID: <ff4bca03-24aa-e77b-23ad-63ea01b98a2b@de.bosch.com>
References: <E1eWn56-0005rw-N5@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <E1eWn56-0005rw-N5@debutante>
Content-Language: de-DE
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 03.01.2018 18:44, Mark Brown wrote:
> The patch
> 
>     spi: sh-msiof: Fix timeout failures for TX-only DMA transfers
> 
> has been applied to the spi tree at
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git


Would it make sense to forward this to -stable, too?


Best regards

Dirk


> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
>>From 89434c3c35081439627baa2225622d5bd12242fe Mon Sep 17 00:00:00 2001
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Date: Wed, 3 Jan 2018 18:11:14 +0100
> Subject: [PATCH] spi: sh-msiof: Fix timeout failures for TX-only DMA transfers
> 
> When using RX (with or without TX), the DMA interrupt triggers
> completion when the RX FIFO has been emptied, i.e. after the full
> transfer has finished.
> 
> However, when using TX without RX, the DMA interrupt triggers completion
> as soon as the DMA engine has filled the TX FIFO, i.e. before the full
> transfer has finished.  Then sh_msiof_modify_ctr_wait() will spin until
> the transfer has really finished and the TFSE bit is cleared, for at
> most 1 ms.  For slow speeds and/or large transfers, this may cause
> timeouts and transfer failures:
> 
>      spi_sh_msiof e6e10000.spi: failed to shut down hardware
>      74x164 spi2.0: SPI transfer failed: -110
>      spi_master spi2: failed to transfer one message from queue
>      74x164 spi2.0: Failed writing: -110
> 
> Fix this by waiting explicitly until the TX FIFO has been emptied.
> 
> Based on a patch in the BSP by Hiromitsu Yamasaki.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/spi/spi-sh-msiof.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index fcd261f98b9f..06bc4b170c47 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -784,11 +784,21 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
>   		goto stop_dma;
>   	}
>   
> -	/* wait for tx fifo to be emptied / rx fifo to be filled */
> +	/* wait for tx/rx DMA completion */
>   	ret = sh_msiof_wait_for_completion(p);
>   	if (ret)
>   		goto stop_reset;
>   
> +	if (!rx) {
> +		reinit_completion(&p->done);
> +		sh_msiof_write(p, IER, IER_TEOFE);
> +
> +		/* wait for tx fifo to be emptied */
> +		ret = sh_msiof_wait_for_completion(p);
> +		if (ret)
> +			goto stop_reset;
> +	}
> +
>   	/* clear status bits */
>   	sh_msiof_reset_str(p);
>   
