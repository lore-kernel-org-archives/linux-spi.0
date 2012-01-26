From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] spi: spi-sh: add IORESOURCE_MEM_TYPE_MASK decoding for access size
Date: Thu, 26 Jan 2012 19:22:21 +0900
Message-ID: <20120126102220.GE26283@linux-sh.org>
References: <4F21124D.6030601@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	SH-Linux <linux-sh@vger.kernel.org>
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F21124D.6030601@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 26, 2012 at 05:43:57PM +0900, Shimoda, Yoshihiro wrote:
> This SPI controller's access size is 32, or 8-bit. The previous driver
> supported 32-bit only. So, this patch adds IORESOURCE_MEM_TYPE_MASK
> decoding, an then, the driver can handle the SPI controller of 8-bit.
> This patch also changes the readl/writel to ioread*/iowrite*.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/spi/spi-sh.c |   25 +++++++++++++++++++++++--
>  1 files changed, 23 insertions(+), 2 deletions(-)
> 
..
>  static void spi_sh_set_bit(struct spi_sh_data *ss, unsigned long val,
> @@ -464,6 +473,18 @@ static int __devinit spi_sh_probe(struct platform_device *pdev)
>  	ss = spi_master_get_devdata(master);
>  	dev_set_drvdata(&pdev->dev, ss);
> 
> +	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
> +	case IORESOURCE_MEM_8BIT:
> +		ss->width = 8;
> +		break;
> +	case IORESOURCE_MEM_32BIT:
> +		ss->width = 32;
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "No support width\n");
> +		ret = -ENODEV;
> +		goto error1;

If the default up to this point has been 32-bit only then it makes sense
for 32 to still remain the default. The 8-bit user is presumably a new
one and therefore has no existing platform data configuration to worry
about, while this change would require existing users to be updated for
the new 32-bit flag to behave the same way they have up until now. 

If you wish to do this incrementally then you can of course convert all
of the existing platforms to the new mechanism for 32-bit as well and
then simply error out as above for the undefined width case, but I still
think it makes more sense to have a usable default.
