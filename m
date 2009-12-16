From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [spi-devel-general] [PATCH 1/2] spi: new SPI bus lock/unlockfunctions
Date: Wed, 16 Dec 2009 17:49:41 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200ED81@mi8nycmail19.Mi8.com>
References: <1253224997-7422-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Yi Li" <yi.li@analog.com>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
To: "Mike Frysinger" <vapier@gentoo.org>,
	<spi-devel-general@lists.sourceforge.net>,
	"David Brownell" <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763090AbZLPWtr@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1253224997-7422-1-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday, September 17, 2009 3:03 PM, Mike Frysinger wrote:
>
> From: Yi Li <yi.li@analog.com>
>
> For some MMC cards over SPI bus, it needs to lock the SPI bus for its own
> use.  The SPI transfer must not be interrupted by other SPI devices that
> share the SPI bus with SPI MMC card.
> 
> This patch introduces 2 APIs for SPI bus locking operation.
> 
> Signed-off-by: Yi Li <yi.li@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Has any additional work be done on this patchset?

It would be nice to finally have a solution that lets the mmc_spi driver
work on a shared spi bus.

Regards,
Hartley
