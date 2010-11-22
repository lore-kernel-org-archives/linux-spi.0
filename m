From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Renaming 'struct flash_platform_data' into 'struct
	spi_flash_platform_data' in include/linux/spi/flash.h
Date: Mon, 22 Nov 2010 05:59:29 -0800
Message-ID: <1290434369.2529.38.camel@helium>
References: <20101117160514.GA5308@n2100.arm.linux.org.uk>
	<4CE6B27D.2000909@bvs-tech.com> <20101121044720.GA6088@tarshish>
	<4CEA3EAE.4080700@bvs-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>
To: Alexis RODET <alexis.rodet@bvs-tech.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <4CEA3EAE.4080700@bvs-tech.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2010-11-22 at 10:58 +0100, Alexis RODET wrote:
> Hello,
> 
>  there is a problem with the double
> definition of 'struct flash_platform_data' that are incompatible:
> 
> in arch/arm/include/asm/mach/flash.h:
> in include/linux/spi/flash.h:

> 
> 
> Both headers are included in a number of machines or driver.

And this patch doesn't touch machine or driver code, so it's incomplete.

ISTR the last time this issue was raised, a similar incomplete patch was
proposed.

How about a patch that does the full rename??

- Dave



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
