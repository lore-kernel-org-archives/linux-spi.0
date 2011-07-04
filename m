From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/5] remove spi-s3c24xx-gpio driver
Date: Mon, 4 Jul 2011 10:48:28 -0600
Message-ID: <20110704164828.GE28042@ponder.secretlab.ca>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, kgene.kim@samsung.com,
	linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 28, 2011 at 02:49:12PM +0200, Peter Korsgaard wrote:
> The spi-s3c24xx-gpio driver is functionally equivalent to the spi-gpio
> driver (but precedes it). The driver has seen very little development 
> since it got added back in 2006, and there's only 2 in-tree users of it.
> 
> This patch series moves the remaining users to the spi-gpio driver and
> then finally removes the driver.
> 
> Compile tested only as I don't have access to the hardware.
> 
>  arch/arm/mach-s3c2410/include/mach/spi-gpio.h |   28 ----
>  arch/arm/mach-s3c2410/mach-qt2410.c           |   34 +----
>  arch/arm/mach-s3c2412/mach-jive.c             |   41 ++----
>  arch/arm/mach-s3c2440/mach-gta02.c            |    1 -
>  drivers/spi/Kconfig                           |   10 --
>  drivers/spi/Makefile                          |    1 -
>  drivers/spi/spi-s3c24xx-gpio.c                |  200 -------------------------

I'm tempted to merge this, just because I like the diffstat.  Kgene,
what say you?

g.
