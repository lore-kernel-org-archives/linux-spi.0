From: Mark Bishop <mark@bish.net>
Subject: Questions in spi_mpc83xx.c
Date: Thu, 09 Jul 2009 14:16:48 -0400
Message-ID: <20090709141648.ws3ak25ewwogwsc0@www.bish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

I haven't seen this before - the '##' in the function name.  This is ANCII C?

#define MPC83XX_SPI_TX_BUF(type)				\
u32 mpc83xx_spi_tx_buf_##type(struct mpc83xx_spi *mpc83xx_spi)	\
{								\
	u32 data;						\
....


Also, I have a SPI chip here that will drive MISO high when it is  
ready to accept more data.  It acts like a hardware handshake.  I was  
thinking about making changes to the controller source (spi_mpc83xx.c,  
in my case) to support this.

This is the only SPI chip contained on this system so I am not worried  
about affecting other SPI devices hooked to the controller.

What are people's opinion on this as far as right place to implement,  
and I could use a push as to where in the controller to make mods if  
appropriate.

And if it isn't obvious already I am still learning a bit as to how  
the SPI sub-system is organized.   I have taken apart the  
documentation in the kernel Documentation/spi directory and am reading  
all the code in drivers/spi.
