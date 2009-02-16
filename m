From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH 0/3] Add dma_alignment field to
	spi_master
Date: Mon, 16 Feb 2009 11:05:12 +0200
Message-ID: <49992C48.4000802@compulab.co.il>
References: <cover.1234167048.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	andrey-W/OLz77bvjtBDgjK7y7TUQ@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <cover.1234167048.git.mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David,
Any comments?

Mike Rapoport wrote:
> Some SPI controllers have restrictions on DMAable buffers alignemt.
> Currently if the buffer supplied by protocol driver is not properly
> aligned, the controller silently performs transfer in PIO mode.
> Addition of dma_alignment field to spi_master allows protocol drivers to
> perform proper alignment.
> 
> Mike Rapoport (3):
>   SPI: add dma_alignment field to spi_master
>   pxa2xx_spi: set spi_master.dma_alignment = 8
>   spi_imx: set spi_master.dma_alignment = 4
> 
>  drivers/spi/pxa2xx_spi.c |    2 ++
>  drivers/spi/spi_imx.c    |    2 ++
>  include/linux/spi/spi.h  |    6 ++++++
>  3 files changed, 10 insertions(+), 0 deletions(-)
> 

-- 
Sincerely yours,
Mike.


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
