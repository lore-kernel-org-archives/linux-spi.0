From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 0/7] OpenFirmware support for the
	spi_mpc83xx driver
Date: Tue, 6 Jan 2009 22:28:10 -0600
Message-ID: <6DC0606C-1CDA-4549-8A63-E3F86010291B@kernel.crashing.org>
References: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20081205200936.GA19137-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Dec 5, 2008, at 2:09 PM, Anton Vorontsov wrote:

> Hi all,
>
> The patch series are used to support SPI via the OF SPI subsystem
> (driver/of/of_spi.c). Now the driver is able to manage its own
> chip selects, and doesn't need any auxiliary support from the
> board files or fsl_soc constructors.
>
> The series also contains PowerPC portions of the MMC SPI support.
>
> Since the series touches spi and powerpc trees, I think it would
> be most convenient to pass it via one of these trees. The patches
> doesn't touch any SPI functionality, only some probe routines, so
> I believe powerpc.git is the best candidate...
>
> The other reason for powerpc tree is that the patches depends on
> other patches as found in paulus/powerpc.git + of_gpio_count()
> as found here:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-December/065917.html
>
> David, if you're OK with the patches, may I ask you to sign off on
> the ones that touch drivers/spi so that we could pass it via Kumar's
> powerpc.git?
>
> The queue:
>
> [1/7] powerpc: Implement get_brgfreq() and get_baudrate() stubs
> [2/7] spi_mpc83xx: Fix sparse warnings
> [3/7] spi_mpc83xx: Rework chip selects handling
> [4/7] spi_mpc83xx: Add OF platform driver bindings
> [5/7] powerpc/fsl_soc: Isolate legacy fsl_spi support to mpc832x_rdb  
> boards
> [6/7] powerpc: Add mmc-spi-slot bindings
> [7/7] powerpc/83xx: Add mmc-spi support via the device tree for  
> MPC8323E-RDB
>
> Thanks,
>
> -- 
> Anton Vorontsov
> email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> irc://irc.freenode.net/bd2

David,

Any status on these patches?

- k

------------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It is the best place to buy or sell services for
just about anything Open Source.
http://p.sf.net/sfu/Xq1LFB
