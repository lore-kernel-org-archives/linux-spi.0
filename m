From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: spidev: Add 32 bit compat ioctl()
Date: Tue, 1 Feb 2011 21:39:44 -0700
Message-ID: <20110202043944.GG29148@angua.secretlab.ca>
References: <1296550966-4015-1-git-send-email-walle@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
To: Bernhard Walle <walle@corscience.de>, arnd@arndb.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1296550966-4015-1-git-send-email-walle@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 01, 2011 at 10:02:46AM +0100, Bernhard Walle wrote:
> Add the compat_ioctl for operations on /dev/spi* so that 32 bit
> userspace applications can access SPI. As far as I can see all data
> structure are already prepared for that, so no additional conversion has
> to be done.
> 
> My use case is MIPS with N32 userspace ABI and toolchain, and that was
> also the platform where I tested it successfully (Cavium Octeon).
> 
> Signed-off-by: Bernhard Walle <walle@corscience.de>

Arnd, can you please give your opinion on this one?  I haven't fully
got my head around the subtleties of 32/64 bit file_operations.

Thanks,
g.

> ---
>  drivers/spi/spidev.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 4e6245e..bb24ad8 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -543,6 +543,7 @@ static const struct file_operations spidev_fops = {
>  	.write =	spidev_write,
>  	.read =		spidev_read,
>  	.unlocked_ioctl = spidev_ioctl,
> +	.compat_ioctl = spidev_ioctl,
>  	.open =		spidev_open,
>  	.release =	spidev_release,
>  	.llseek =	no_llseek,
> -- 
> 1.7.1
> 
