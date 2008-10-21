From: "Magnus Damm" <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2.6.27-git] spi_gpio driver
Date: Tue, 21 Oct 2008 21:40:41 +0900
Message-ID: <aec7e5c30810210540p6b50562ax50b0cdd9af9e12e7@mail.gmail.com>
References: <200807202146.12759.mb@bu3sch.de>
	<200810181354.23955.david-b@pacbell.net>
	<aec7e5c30810191944u4c125943h895099b3f1eaa813@mail.gmail.com>
	<200810192124.36402.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200810192124.36402.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 20, 2008 at 1:24 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>
> Generalize the old at91rm9200 "bootstrap" bitbanging SPI master driver
> as "spi_gpio", so it works with arbitrary GPIOs and can be configured
> through platform_data.  Such SPI masters support:
>
>  - any number of bus instances (bus_num is the platform_device.id)
>  - any number of chipselects (one GPIO per spi_device)
>  - all four SPI_MODE values, and SPI_CS_HIGH
>  - i/o word sizes from 1 to 32 bits;
>  - devices configured as with any other spi_master controller
>
> When configured using platform_data, this provides relatively low clock
> rates.  On platforms that support inlined GPIO calls, significantly
> improved transfer speeds are also possible with a semi-custom driver.
> (It's still painful when accessing flash memory, but less so.)
>
> Sanity checked by using this version to replace both native controllers
> on a board with six different SPI slaves, relying on three different
> SPI_MODE_* values and both SPI_CS_HIGH settings for correct operation.
>
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Works fine on SuperH together with the mmc_spi driver. Thanks!

Acked-by: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
