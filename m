From: masonccyang@mxic.com.tw
Subject: Re: [PATCH v3 1/4]  mfd: Add Macronix MX25F0A MFD controller driver
Date: Wed, 15 May 2019 14:46:07 +0800
Message-ID: <OF4F52243F.0954FF8C-ON482583FB.0023B249-482583FB.00252E6F@mxic.com.tw>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw> <1555320234-15802-2-git-send-email-masonccyang@mxic.com.tw> <20190512142835.4caddc8e@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        geert@linux-m68k.org, juliensu@mxic.com.tw, lee.jones@linaro.org,
        liang.yang@amlogic.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, paul.burton@mips.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, zhengxunli@mxic.com.tw
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190512142835.4caddc8e@xps13>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Miquel,

 
> > Add a driver for Macronix MX25F0A multifunction device controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  drivers/mfd/Kconfig              |   9 ++
> >  drivers/mfd/Makefile             |   1 +
> >  drivers/mfd/mxic-mx25f0a.c       |  84 +++++++++++++++++++
> >  include/linux/mfd/mxic-mx25f0a.h | 175 
+++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 269 insertions(+)
> >  create mode 100644 drivers/mfd/mxic-mx25f0a.c
> >  create mode 100644 include/linux/mfd/mxic-mx25f0a.h
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 26ad646..7e99e93 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -823,6 +823,15 @@ config MFD_MAX8998
> >       additional drivers must be enabled in order to use the 
functionality
> >       of the device.
> > 
> > +config MFD_MXIC_MX25F0A
> > +   tristate "Macronix mx25f0a multifunction device support"
> > +   select MFD_CORE
> > +   help
> > +     This supports for Macronix mx25f0a multifunction device 
controller
> > +     for raw nand or spi. You have to select individual components 
like
> 
> Please use upper case for acronyms in plain English: NAND, SPI

okay, will fix.

And I also would like to remove "mx25f0a" char.

patch to:
------------------------------------------------------------------------
config MFD_MXIC_FMC
   tristate "Macronix Flash Memory Controller support"
   select MFD_CORE
   help
     This supports Macronix Flash Memory Controller for raw NAND and SPI.
     You have to select individual components like raw NAND controller
     or SPI host controller under the corresponding  menus.
-------------------------------------------------------------------------

thanks for your review.

best regards,
Mason




CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================
