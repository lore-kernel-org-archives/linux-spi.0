From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: changing module from single to multi-file
	build
Date: Tue, 13 Oct 2009 20:39:24 +0200
Message-ID: <20091013183924.GA5249@merkur.ravnborg.org>
References: <20091013082427.GC7793@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091013082427.GC7793-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Oct 13, 2009 at 09:24:27AM +0100, Ben Dooks wrote:
> I have a driver, drivers/spi/spi_s3c24xx.c in this case that I have
> written an FIQ handler for which requires some assembly code. My attempts
> at trying to change it so that I can build a single module with both the
> C and ASM code linked together have not yet been a success.
> 
> The original makefile bit from drivers/spi/Makefile was:
> 
>  obj-$(CONFIG_SPI_S3C24XX)              += spi_s3c24xx.o
> 
> This allows it to work as a kernel builtin:
> 
>  obj-$(CONFIG_SPI_S3C24XX)              += spi_s3c24xx.o
>  obj-$(CONFIG_SPI_S3C24XX_FIQ)          += spi_s3c24xx_fiq.o
> 
> I tried adding the following to the file, but this does not make
> the FIQ code, I assume as there is still drivers/spi/spi_s3c24xx.c.
> 
>  obj-spi_s3c24xx-y                      := spi_s3c24xx.o
>  obj-spi_s3c24xx-$(CONFIG_SPI_S3C24XX_FIQ) += spi_s3c24xx_fiq.o

A multi-file module cannot have a .c file with a name
equal to the modulename.
So going from a single-file module to a multi-file
module rwquire you to rename the .c file if you want
to keep the old module name.

	Sam

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
