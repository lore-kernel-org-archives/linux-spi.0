From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Merge problem: Re: Applied "spi: fsl-espi: avoid processing
 uninitalized data on error" to the spi tree
Date: Wed, 26 Oct 2016 20:11:28 +0200
Message-ID: <4b1c5f78-d754-fdc8-0f15-17f88ed224b7@gmail.com>
References: <E1bzLFV-0004Wz-Ut@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nobuteru Hayashi <hayashi.nbb@ncos.nec.co.jp>,
        linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E1bzLFV-0004Wz-Ut@debutante>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 26.10.2016 um 12:15 schrieb Mark Brown:
> The patch
> 
>    spi: fsl-espi: avoid processing uninitalized data on error
> 
> has been applied to the spi tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 
> 
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
>>From 5c0ba57744b1422d528f19430dd66d6803cea86f Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 25 Oct 2016 22:57:10 +0200
> Subject: [PATCH] spi: fsl-espi: avoid processing uninitalized data on error
> 
> When we get a spurious interrupt in fsl_espi_irq, we end up
> processing four uninitalized bytes of data, as shown in this
> warning message:
> 
>    drivers/spi/spi-fsl-espi.c: In function 'fsl_espi_irq':
>    drivers/spi/spi-fsl-espi.c:462:4: warning: 'rx_data' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This adds another check so we skip the data in this case.
> 
> Fixes: 6319a68011b8 ("spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/spi/spi-fsl-espi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
> index 7451585a080e..2c175b9495f7 100644
> --- a/drivers/spi/spi-fsl-espi.c
> +++ b/drivers/spi/spi-fsl-espi.c
> @@ -458,7 +458,7 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
>  
>  		mspi->len -= rx_nr_bytes;
>  
> -		if (mspi->rx)
> +		if (rx_nr_bytes && mspi->rx)
>  			mspi->get_rx(rx_data, mspi);
>  	}
>  
> 
There seems to be a merge problem. Before the relevant code was:
(changed in recent commit "spi: fsl-espi: fix handling of word
sizes other than 8 bit")

if (mspi->rx) {
	*(u32 *)mspi->rx = rx_data;
	mspi->rx += 4;
}

Now it's:

if (rx_nr_bytes && mspi->rx) {
	mspi->get_rx(rx_data, mspi);
	mspi->rx += 4;
}

Instead it should be:

if (rx_nr_bytes && mspi->rx) {
	*(u32 *)mspi->rx = rx_data;
	mspi->rx += 4;
}
