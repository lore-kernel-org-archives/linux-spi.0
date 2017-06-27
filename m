From: Aravind Thokala <aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/ath79: Fix checkpatch warnings
Date: Tue, 27 Jun 2017 21:51:30 +0530
Message-ID: <CAAUiYHe3p-D_-2MLW+a0LsfmOZYyjNunvSi8W2KzmvZpgPDXPw@mail.gmail.com>
References: <1498579857-10236-1-git-send-email-aravind.thk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Aravind Thokala <aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498579857-10236-1-git-send-email-aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Kindly ignore this patch: Mistakenly the patch subject contains [PATCH 2/2].

I will resend the patch.

On 27 June 2017 at 21:40, Aravind Thokala <aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This patch fixes the checkpatch.pl warnings on the driver
> file.
>
> Signed-off-by: Aravind Thokala <aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-ath79.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
> index b89cee1..0719bd4 100644
> --- a/drivers/spi/spi-ath79.c
> +++ b/drivers/spi/spi-ath79.c
> @@ -39,15 +39,15 @@ struct ath79_spi {
>         u32                     reg_ctrl;
>         void __iomem            *base;
>         struct clk              *clk;
> -       unsigned                rrw_delay;
> +       unsigned int            rrw_delay;
>  };
>
> -static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned int reg)
>  {
>         return ioread32(sp->base + reg);
>  }
>
> -static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg, u32 val)
> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned int reg, u32 val)
>  {
>         iowrite32(val, sp->base + reg);
>  }
> @@ -57,7 +57,7 @@ static inline struct ath79_spi *ath79_spidev_to_sp(struct spi_device *spi)
>         return spi_master_get_devdata(spi->master);
>  }
>
> -static inline void ath79_spi_delay(struct ath79_spi *sp, unsigned nsecs)
> +static inline void ath79_spi_delay(struct ath79_spi *sp, unsigned int nsecs)
>  {
>         if (nsecs > sp->rrw_delay)
>                 ndelay(nsecs - sp->rrw_delay);
> @@ -148,9 +148,8 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
>
>  static void ath79_spi_cleanup_cs(struct spi_device *spi)
>  {
> -       if (gpio_is_valid(spi->cs_gpio)) {
> +       if (gpio_is_valid(spi->cs_gpio))
>                 gpio_free(spi->cs_gpio);
> -       }
>  }
>
>  static int ath79_spi_setup(struct spi_device *spi)
> @@ -176,7 +175,7 @@ static void ath79_spi_cleanup(struct spi_device *spi)
>         spi_bitbang_cleanup(spi);
>  }
>
> -static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned nsecs,
> +static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned int nsecs,
>                                u32 word, u8 bits)
>  {
>         struct ath79_spi *sp = ath79_spidev_to_sp(spi);
> --
> 2.7.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
