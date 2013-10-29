From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: add Intel MID SSP SPI maintainers
Date: Tue, 29 Oct 2013 11:20:43 -0700
Message-ID: <1383070843.12439.14.camel@joe-AO722>
References: <1383069950-27754-1-git-send-email-david.a.cohen@linux.intel.com>
	 <1383069950-27754-2-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, ning.li@intel.com,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: David Cohen <david.a.cohen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383069950-27754-2-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 2013-10-29 at 11:05 -0700, David Cohen wrote:
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -1916,6 +1916,14 @@ L:	linux-gpio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/gpio/gpio-intel-mid.c

Please insert this section in alphabetic order.
 
> +INTEL-MID SSP SPI DRIVER
> +M:	Ning Li <ning.li@intel.com>
> +M:	David Cohen <david.a.cohen@linux.intel.com>
> +L:	linux-spi@vger.kernel.org
> +S:	Maintained

Supported?

> +F:	drivers/spi/spi-intel-mid-ssp.c
> +F:	include/linux/spi/intel_mid_ssp_spi.h
> +
>  BTRFS FILE SYSTEM
>  M:	Chris Mason <chris.mason@fusionio.com>
>  L:	linux-btrfs@vger.kernel.org
