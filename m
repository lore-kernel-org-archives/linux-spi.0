From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 7/7] [POWERPC][SPI]
	spi_mpc83xx:	allow use on MPC85xx
Date: Tue, 25 Sep 2007 09:58:45 -0700
Message-ID: <20070925165845.40B0E2397FB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
	<16E78F0E-B57B-4084-887E-5D2F9C1D0331@kernel.crashing.org>
	<20070925151819.GA6757@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070925151819.GA6757-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> >> -	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
> >> +	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
> >
> > Should that really be just PPC_83xx || QUICC_ENGINE?
>
> Well, I thought about that. By now I'm unsure if every QE
> implementation will be compatible with further ones.

How many other QE implementations exist?  Is that sort of
gratuitous breakage something Freescale makes a habit of?


>	So far
> I've tested this driver on MPC8323 and MPC8568. If we'll see
> more and more compatible QE SPI controllers, of course we
> may just do || QUICC_ENGINE.
>
> PPC_83xx || PPC_85xx
> PPC_83xx || QUICC_ENGINE
>
> Today first option saves us four bytes. ;-)

It'd be good if someone would look at the relevant docs.

I'll wait for a PPC signoff before I forward this for
merge with SPI stuff...

_ Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
