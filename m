From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/2] atmel/spi: fix missing probe
Date: Thu, 3 Nov 2011 18:56:20 +0100
Message-ID: <20111103175620.GM7136@game.jcrosoft.org>
References: <1320342082-18573-1-git-send-email-plagnioj@jcrosoft.com>
	<4EB2D467.7050901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4EB2D467.7050901@gmail.com>
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

On 18:50 Thu 03 Nov     , Daniel Mack wrote:
> On 11/03/2011 06:41 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >Commit 940ab889 "drivercore: Add helper macro for platform_driver boilerplate"
> >converted this driver to use module_platform_driver, but due to the use
> >of platform_driver_probe(), this resulted in the call to atmel_spi_probe being
> >lost. Place the call to this function into the driver structure.
> >
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> >Cc: Greg Kroah-Hartman<gregkh@suse.de>
> >Cc: Grant Likely<grant.likely@secretlab.ca>
> >Cc: Russell King - ARM Linux<linux@arm.linux.org.uk>
> >---
> >v3:
> >
> >	update commit message
> >  drivers/spi/spi-atmel.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> >diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> >index 79665e2..3cd4f49 100644
> >--- a/drivers/spi/spi-atmel.c
> >+++ b/drivers/spi/spi-atmel.c
> >@@ -1072,6 +1072,7 @@ static struct platform_driver atmel_spi_driver = {
> >  	},
> >  	.suspend	= atmel_spi_suspend,
> >  	.resume		= atmel_spi_resume,
> >+	.prove		= atmel_spi_probe,
>          ^^^^^
> 
> This is certainly a typo. Didn't you even compile-test this?
I did I make the typo when editing the commit message before sending the
patch
Dame

Best Regards,
J.
