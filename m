From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Memory-mapped Dwsignware SPI driver
Date: Tue, 19 Jan 2010 11:26:14 +0800
Message-ID: <20100119112614.35a8289e@feng-desktop>
References: <20100118164921.23527.74770.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100118164921.23527.74770.stgit-PR71IgaHmJalNznWqnLNUK6RkeBMCJyt@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


You may need modify the code a little, I just submit some code change :)
mainly about a dw_spi_remove_host() and fifo_len setting

Thanks,
Feng

On Tue, 19 Jan 2010 00:50:01 +0800
Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> wrote:

> Adds a memory-mapped I/O dw_spi platform device.
> 
> Signed-off-by: Jean-Hugues Deschenes
> <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> ---
>  drivers/spi/Kconfig       |   16 ++++
>  drivers/spi/Makefile      |    1 
>  drivers/spi/dw_spi_mmio.c |  164
> +++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 178
> insertions(+), 3 deletions(-) create mode 100644
> drivers/spi/dw_spi_mmio.c
> 

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
