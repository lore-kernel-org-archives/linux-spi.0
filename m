From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4] [SPI] [POWERPC] spi_mpc83xx: handles Freescale
	MPC8610 as well
Date: Fri, 16 May 2008 14:04:38 -0500
Message-ID: <20080516190438.GA2758@loki.buserror.net>
References: <20080516165052.GA24196@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net, Timur Tabi <timur@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20080516165052.GA24196@polina.dev.rtsoft.ru>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 16, 2008 at 08:50:52PM +0400, Anton Vorontsov wrote:
>  config SPI_MPC83xx
>  	tristate "Freescale MPC83xx/QUICC Engine SPI controller"
> -	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE) && EXPERIMENTAL
> +	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE || PPC_86xx) && EXPERIMENTAL

How about "depends on SPI_MASTER && FSL_SOC && EXPERIMENTAL"?

Plus, we should change the option text to something like "MPC8xxx SPI
controller".

-Scott
