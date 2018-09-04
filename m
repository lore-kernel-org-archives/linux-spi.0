From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
Date: Tue, 4 Sep 2018 14:46:27 +0200
Message-ID: <20180904144627.1de264b6@bbrezillon>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
        <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 3 Sep 2018 09:54:08 +0000
Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com> wrote:

> Dear Yogesh,
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-  
> > owner@vger.kernel.org> On Behalf Of Yogesh Gaur  
> > Sent: Friday, August 31, 2018 4:00 PM
> > To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> > marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org
> > Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> > arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org; Yogesh
> > Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI driver
> > 
> > Add binding file for NXP FlexSPI driver.
> > 
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> >  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42
> > ++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-
> > fspi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > new file mode 100644
> > index 0000000..9f07116
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > @@ -0,0 +1,42 @@
> > +* NXP Flex Serial Peripheral Interface (FSPI)
> > +
> > +Required properties:
> > +  - compatible : Should be "nxp,lx2160a-fspi"
> > +  - reg :        First contains the register location and length,
> > +                 Second contains the memory mapping address and length  
> 
> Why are we overriding reg property.  Is there any special requirement. 
> 
> Can we use "reg" and "ranges" property in device tree.
> Here "reg" represents controller registers and "ranges" represent the memory address of flash.

No, ranges is not used for that. It's used when you need to convert
from one address space to another, which is not what you're describing
here. Check section 2.38 of this document [1] for more details.

[1]https://elinux.org/images/c/cf/Power_ePAPR_APPROVED_v1.1.pdf
