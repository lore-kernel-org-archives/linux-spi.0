From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 11/18] spi/xilinx: Remove rx_fn and tx_fn pointer
Date: Tue, 27 Jan 2015 11:00:51 +0100
Message-ID: <CAPybu_3gF1BXhq4j5Z3DfM8_PxuK72Pshm6_5qVKH-ZyYTpgig@mail.gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-12-git-send-email-ricardo.ribalda@gmail.com> <20150127000903.GM21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"moderated list:ARM/S5P EXYNOS AR..."
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Andy Whitcroft <apw-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>,
	Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150127000903.GM21293-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark


> Perhaps I'm missing something here but we only seem to be incrementing
> rx_ptr for the 32 bit case here...

The unified diff is a bit confusing this time.

This is how the function looks after the patch.
All the modes are handled in a generic way.

Which I believe it is right:

static void xilinx_spi_rx(struct xilinx_spi *xspi)
{
u32 data = xspi->read_fn(xspi->regs + XSPI_RXD_OFFSET);

if (!xspi->rx_ptr)
    return;

switch (xspi->bits_per_word) {
case 8:
    *(u8 *)(xspi->rx_ptr) = data;
break;
case 16:
    *(u16 *)(xspi->rx_ptr) = data;
break;
case 32:
    *(u32 *)(xspi->rx_ptr) = data;
break;
}

xspi->rx_ptr += xspi->bits_per_word/8;
}



>
>> +     xspi->rx_ptr += xspi->bits_per_word/8;
>
> ...which looks to duplicate this which handles all cases.  Also there's
> a coding style thing - spaces around the / please.

I am fixing this on the next version. (and  xspi->tx_ptr +=
xspi->bits_per_word/8;)

I am also cc: the maintainers of checkpatch, because for whatever
reason, this was not found by the script

ricardo@neopili:~/curro/qtec/linux-upstream$ scripts/checkpatch.pl
xilinx-spi2/0011-spi-xilinx-Remove-rx_fn-and-tx_fn-pointer.patch
total: 0 errors, 0 warnings, 109 lines checked

xilinx-spi2/0011-spi-xilinx-Remove-rx_fn-and-tx_fn-pointer.patch has
no obvious style problems and is ready for submission.

Thanks!


-- 
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
