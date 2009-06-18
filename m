From: Andrea Paterniani <a.paterniani@swapp-eng.it>
Subject: Re: i.MX SPI driver
Date: Thu, 18 Jun 2009 08:46:23 +0200
Message-ID: <4A39E2BF.8060104@swapp-eng.it>
References: <1245235220-23816-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b@pacbell.net>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	spi-devel-general@lists.sourceforge.net,
	VISCOUNT - Zinato Carlo <c.zinato@viscount.it>,
	VISCOUNT - Larcher Alessandro <a.larcher@viscount.it>,
	VISCOUNT - Gabrielli Sandro <s.gabrielli@viscount.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1245235220-23816-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

Hi Sascha,

Sorry for late replay!
The current driver support DMA transfers.
Surely for our design this feature is mandatory since we need to sustain 
heavy SPI traffic.
I suggest to not remove the driver even if it only supports iMX1 device 
and not the entire family.
Is it possible to have both current and new drivers?

Regards,
Andrea


Sascha Hauer ha scritto:
> Hi David,
>
> The new i.MX SPI driver has been posted twice on the list, I received no
> objections from anyone, so please consider pulling the following branch
>
> Thanks,
>   Sascha
>
>
> The following changes since commit 65795efbd380a832ae508b04dba8f8e53f0b84d9:
>   Linus Torvalds (1):
>         Merge branch 'next-i2c' of git://aeryn.fluff.org.uk/bjdooks/linux
>
> are available in the git repository at:
>
>   git://git.pengutronix.de/git/sha/linux-2.6.git for-david
>
> Sascha Hauer (2):
>       remove i.MX SPI driver
>       SPI: Add SPI driver for most known i.MX SoCs
>
>  arch/arm/plat-mxc/include/mach/spi.h |   27 +
>  drivers/spi/Kconfig                  |    7 +-
>  drivers/spi/Makefile                 |    2 +-
>  drivers/spi/mxc_spi.c                |  685 +++++++++++++
>  drivers/spi/spi_imx.c                | 1779 ----------------------------------
>  5 files changed, 717 insertions(+), 1783 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/spi.h
>  create mode 100644 drivers/spi/mxc_spi.c
>  delete mode 100644 drivers/spi/spi_imx.c
>
>
>
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>
>   

-- 


 

------------------------------------------------------------------------

*Ing. Andrea Paterniani*

*SWAPP* - Studio Professionale
Via degli Abeti, 312 - 61100 Pesaro
Tel 0721 24256
Fax 178 220 8730
 
a.paterniani@swapp-eng.it
www.swapp-eng.it 
<mailto:%0d%0aa.paterniani@swapp-eng.it%0d%0awww.swapp-eng.it>

------------------------------------------------------------------------

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
