From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: dw: Make debugfs name unique between instances
Date: Sun, 1 Jan 2017 17:46:48 +0200
Message-ID: <CAHp75Ve9GOwUr8npvjrvvuvfE_jqzOy3hr_42wp8VvCh4OQ-eQ@mail.gmail.com>
References: <1482398292-46946-1-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org,
        Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1482398292-46946-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Dec 22, 2016 at 11:18 AM, Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org> wrote:
> Some system have multiple dw devices. Currently the driver uses a
> fixed name for the debugfs dir. Append dev name to the debugfs dir
> name to make it unique.


> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -107,7 +107,10 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
>
>  static int dw_spi_debugfs_init(struct dw_spi *dws)
>  {
> -       dws->debugfs = debugfs_create_dir("dw_spi", NULL);
> +       char name[128];
> +
> +       snprintf(name, 128, "dw_spi-%s", dev_name(&dws->master->dev));

128 is too much.
Perhaps something like 32 and use bus number instead of dev_name().

> +       dws->debugfs = debugfs_create_dir(name, NULL);
>         if (!dws->debugfs)
>                 return -ENOMEM;


-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
