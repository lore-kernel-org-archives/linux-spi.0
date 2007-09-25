From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx:
	allow use on MPC85xx
Date: Tue, 25 Sep 2007 16:48:00 +0200
Message-ID: <874phiol7j.fsf@macbook.be.48ers.dk>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070925143531.GG5323-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org> (Anton Vorontsov's
	message of "Tue\, 25 Sep 2007 18\:35\:31 +0400")
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

>>>>> "Anton" == Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org> writes:

Hi,
 
 Anton>  config SPI_MPC83xx
 Anton>  	tristate "Freescale MPC83xx SPI controller"
 Anton> -	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
 Anton> +	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
 Anton>  	select SPI_BITBANG
 Anton>  	help
 Anton>  	  This enables using the Freescale MPC83xx SPI controller in master

Please also update the help text.

-- 
Bye, Peter Korsgaard

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
