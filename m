From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Applied "spi: sh-msiof: Add compatible strings for r8a774[35]" to
 the spi tree
Date: Mon, 25 Sep 2017 19:48:44 +0200
Message-ID: <CAMuHMdVsRwW+10ERyTJAa8XhhkPMn4ruymUwPKot+kmczBwbcA@mail.gmail.com>
References: <1506329660-4064-2-git-send-email-fabrizio.castro@bp.renesas.com> <20170925161637.D7471440058@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170925161637.D7471440058@finisterre.ee.mobilebroadband>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Mon, Sep 25, 2017 at 6:16 PM, Mark Brown <broonie@kernel.org> wrote:
> The patch
>
>    spi: sh-msiof: Add compatible strings for r8a774[35]
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

Please drop this patch, as there's no need to add explicit matching for these
compatible values. The family-specific compatible values (which the driver
already matches against) are sufficient.

Thanks!

> From bdacfc7b6216dd30d07c10732fd4c0a660c62853 Mon Sep 17 00:00:00 2001
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Date: Mon, 25 Sep 2017 09:54:19 +0100
> Subject: [PATCH] spi: sh-msiof: Add compatible strings for r8a774[35]
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi-sh-msiof.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 0eb1e9583485..00808448cf35 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -1021,6 +1021,8 @@ static const struct sh_msiof_chipdata rcar_gen3_data = {
>
>  static const struct of_device_id sh_msiof_match[] = {
>         { .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
> +       { .compatible = "renesas,msiof-r8a7743",   .data = &rcar_gen2_data },
> +       { .compatible = "renesas,msiof-r8a7745",   .data = &rcar_gen2_data },
>         { .compatible = "renesas,msiof-r8a7790",   .data = &rcar_gen2_data },
>         { .compatible = "renesas,msiof-r8a7791",   .data = &rcar_gen2_data },
>         { .compatible = "renesas,msiof-r8a7792",   .data = &rcar_gen2_data },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
