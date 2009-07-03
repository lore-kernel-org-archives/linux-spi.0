From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH -mm v4][POWERPC] mpc8xxx : allow SPI
	without cs.
Date: Thu, 2 Jul 2009 18:38:03 -0700
Message-ID: <200907021838.03375.david-b@pacbell.net>
References: <4A39DC80.7030906@arvoo.nl>
	<20090619134558.GA18872@oksana.dev.rtsoft.ru>
	<4A3B9E38.9060004@arvoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
To: spi-devel-general@lists.sourceforge.net,
 Rini van Zetten <rini@arvoo.nl>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <4A3B9E38.9060004@arvoo.nl>
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

On Friday 19 June 2009, Rini van Zetten wrote:
> This patch adds the possibility to have a spi device without a cs.

Note that there's now the SPI_NO_CS bit in spi_device.mode
to describe this situation ... so no "-EEXIST" hackery should
ever tempt anyone again.
