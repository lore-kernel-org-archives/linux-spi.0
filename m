From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2] spi: make architecture specific hardware depend on the
 associated hardware
Date: Sun, 20 Nov 2016 19:13:18 +0100
Message-ID: <8c3ed8e2-9b91-d029-65e5-9965f1a097b7@metafoo.de>
References: <20161120175505.2910-1-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161120175505.2910-1-pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/20/2016 06:55 PM, Peter Robinson wrote:
>  config SPI_XILINX
>  	tristate "Xilinx SPI controller common module"
> -	depends on HAS_IOMEM
> +	depends on HAS_IOMEM && (ARCH_ZYNQ || ARCH_ZYNQMP || COMPILE_TEST)

I'm using this one on X86, or anything really that has PCIe support.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
