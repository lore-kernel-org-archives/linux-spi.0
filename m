From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi/xilinx: Cast ioread32/iowrite32 function pointers
Date: Thu, 29 Jan 2015 17:04:03 +0100
Message-ID: <1597235.QjzCE74z4V@wuerfel>
References: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@xilinx.com>,
	=?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday 29 January 2015 15:51:13 Ricardo Ribalda Delgado wrote:
>          * Setup little endian helper functions first and try to use them
>          * and check if bit was correctly setup or not.
>          */
> -       xspi->read_fn = ioread32;
> -       xspi->write_fn = iowrite32;
> +       xspi->read_fn = (u32 (*)(void __iomem *)) ioread32;
> +       xspi->write_fn = (void (*)(u32, void __iomem *)) iowrite32;
>  
>         xspi->write_fn(XSPI_CR_LOOP, xspi->regs + XSPI_CR_OFFSET);
> 

Casting the type of a function you call seems rather dangerous. Why not
add an inline function in this driver as a wrapper?

	Arnd
