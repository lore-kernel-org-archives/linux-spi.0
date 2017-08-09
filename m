From: "Langer, Thomas" <thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
Date: Wed, 9 Aug 2017 14:02:16 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1EA0A385@IRSMSX101.ger.corp.intel.com>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-4-hauke@hauke-m.de>
 <20170809114421.oo2bunardgw3p4tk@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org"
        <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
        "john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org" <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "Mehrtens, Hauke" <hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "kishon-l0cyMroinI0@public.gmane.org" <kishon-l0cyMroinI0@public.gmane.org>,
        "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170809114421.oo2bunardgw3p4tk-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> -----Original Message-----
> From: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-spi-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Mark Brown
> Sent: Wednesday, August 9, 2017 1:44 PM
> To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
> Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; linux-
> mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org;
> john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mehrtens, Hauke
> <hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; kishon-l0cyMroinI0@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org
> Subject: Re: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
> 
> On Wed, Aug 09, 2017 at 12:52:34AM +0200, Hauke Mehrtens wrote:
> 
> > Do not check which flash type the SoC was booted from before
> > using this driver. Assume that the device tree is correct and use this
> > driver when it was added to device tree. This also removes a build
> > dependency to the SoC code.
> 
> Why?  Is this assumption reliably true?

Yes. We only have one type of flash interface in the device tree, as they 
are connected to the shared EBU (External Bus Unit).

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
