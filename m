From: Hu Mingkai-B21284 <B21284@freescale.com>
Subject: RE: [PATCH v3 3/7] eSPI: add eSPI controller support
Date: Fri, 8 Oct 2010 14:35:50 +0800
Message-ID: <73839B4A0818E747864426270AC332C3057F626D@zmy16exm20.fsl.freescale.net>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
	<20101001112204.GA16783@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net
To: Anton Vorontsov <cbouatmailru@gmail.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20101001112204.GA16783@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Anton Vorontsov [mailto:cbouatmailru@gmail.com]
> Sent: Friday, October 01, 2010 7:22 PM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; spi-devel-general@lists.sourceforge.net; linux-
> mtd@lists.infradead.org; Gala Kumar-B11780
> Subject: Re: [PATCH v3 3/7] eSPI: add eSPI controller support
> 
> Hello Mingkai,
> 
> There are mostly cosmetic comments down below.
> 
> > +		/* spin until TX is done */
> > +		while (((events = mpc8xxx_spi_read_reg(&reg_base->event))
> > +					& SPIE_NF) == 0)
> > +			cpu_relax();
> 
> This is dangerous. There's a handy spin_event_timeout() in asm/delay.h.
> 

When timeout, can I use return in the interrupt function directly like this?

if (!(events & SPIE_NF)) {
        int ret;
        /* spin until TX is done */
        ret = spin_event_timeout(((events = mpc8xxx_spi_read_reg(
                        &reg_base->event)) & SPIE_NF) == 0, 1000, 0);
        if (!ret) {
                dev_err(mspi->dev, "tired waiting for SPIE_NF\n");
                return;
        }
}

> > +}
> > +
> > +static const struct of_device_id of_fsl_espi_match[] = {
> > +	{ .compatible = "fsl,mpc8536-espi" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, of_fsl_espi_match);
> > +
> > +static struct of_platform_driver fsl_espi_driver = {
> > +	.driver = {
> > +		.name = "fsl_espi",
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = of_fsl_espi_match,
> > +	},
> > +	.probe		= of_fsl_espi_probe,
> > +	.remove		= __devexit_p(of_fsl_espi_remove),
> > +};
> > +
> > +static int __init fsl_espi_init(void) {
> > +	return of_register_platform_driver(&fsl_espi_driver);
> > +}
> > +module_init(fsl_espi_init);
> > +
> > +static void __exit fsl_espi_exit(void) {
> > +	of_unregister_platform_driver(&fsl_espi_driver);
> > +}
> > +module_exit(fsl_espi_exit);
> > +
> > +MODULE_AUTHOR("Mingkai Hu");
> > +MODULE_DESCRIPTION("Enhanced Freescale SPI Driver");
> 
> This sounds like that this is an enhanced version of the Freescale SPI driver,
> which it is not. ;-)
> 

I quoted from the UM, maybe the enhancement is the controller takes over the
CS signal from the HW point view.

I changed all the other code according to your comments.

Thanks,
Mingkai
