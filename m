From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi: spidev: Add 32 bit compat ioctl()
Date: Wed, 2 Feb 2011 13:18:15 +0100
Message-ID: <201102021318.16191.arnd@arndb.de>
References: <1296646296-31843-1-git-send-email-walle@corscience.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net, grant.likely@secretlab.ca,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
To: Bernhard Walle <walle@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296646296-31843-1-git-send-email-walle@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 02 February 2011, Bernhard Walle wrote:
> Add the compat_ioctl for operations on /dev/spi* so that 32 bit
> userspace applications can access SPI. As far as I can see all data
> structure are already prepared for that, so no additional conversion has
> to be done.
> 
> My use case is MIPS with N32 userspace ABI and toolchain, and that was
> also the platform where I tested it successfully (Cavium Octeon).
> 
> Signed-off-by: Bernhard Walle <walle@corscience.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
