From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 12/12] Crypto: CESA: Add support for DT based
 instantiation.
Date: Tue, 3 Jul 2012 19:03:27 +0200
Message-ID: <20120703170327.GB1519@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-13-git-send-email-andrew@lunn.ch>
 <5684211.IOzGhLaAtq@flexo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5684211.IOzGhLaAtq@flexo>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 03, 2012 at 05:50:02PM +0200, Florian Fainelli wrote:
> Hello Andrew,
> 
> On Tuesday 03 July 2012 16:22:45 Andrew Lunn wrote:
> > Based on work by Michael Waller and Jason Cooper.
> > 
> > Added support for getting the interrupt number from DT.
> > 
> > Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> > ---
> >  .../devicetree/bindings/crypto/mv_cesa.txt         |   18 ++++++++++++
> >  drivers/crypto/mv_cesa.c                           |   31 
> +++++++++++++++++---
> >  2 files changed, 45 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/crypto/mv_cesa.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/crypto/mv_cesa.txt 
> b/Documentation/devicetree/bindings/crypto/mv_cesa.txt
> > new file mode 100644
> > index 0000000..f191122
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/crypto/mv_cesa.txt
> > @@ -0,0 +1,18 @@
> > +Marvell Cryptographic Engines And Security Accelerator
> > +
> > +Required properties:
> > +- compatible : should be "mrvl,orion-crypto"
> 
> You mention "mvrl" here, but the rest of your series uses "marvell", and this 
> is also what you use as a match table later in the driver, this looks like a 
> left-over from your previous submission.

Correct. I will fix this.

> 
> > +- reg : base physical address of the engine and length of memory mapped
> > +        region, followed by base physical address of sram and its memory
> > +               length
> > +- interrupts : interrupt number
> > +
> > +Examples:
> > +
> > +crypto@f1030000 {
> > +       compatible = "mrvl,orion-crypto";
> > +       reg = <0xf1030000 0x10000
> > +              0xf5000000 0x800>;    /* sram */
> > +       interrupts = <22>;
> > +};
> > +
> > diff --git a/drivers/crypto/mv_cesa.c b/drivers/crypto/mv_cesa.c
> > index 1cc6b3f..964c4c5 100644
> > --- a/drivers/crypto/mv_cesa.c
> > +++ b/drivers/crypto/mv_cesa.c
> > @@ -19,6 +19,9 @@
> >  #include <linux/clk.h>
> >  #include <crypto/internal/hash.h>
> >  #include <crypto/sha.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_irq.h>
> >  
> >  #include "mv_cesa.h"
> >  
> > @@ -1005,7 +1008,11 @@ static int mv_probe(struct platform_device *pdev)
> >  		return -EEXIST;
> >  	}
> >  
> > -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> > +	if (pdev->dev.of_node)
> > +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +						   "regs");
> > +	else
> > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
> If you add a reg-names property, which respects the ordering of the reg 
> property, you don't need this.

Ah, thanks for the tip.

    Andrew 
