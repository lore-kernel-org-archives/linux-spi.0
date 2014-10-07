From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
Date: Mon, 6 Oct 2014 19:24:10 -0500
Message-ID: <1412641450.13320.509.camel@snotra.buserror.net>
References: <20141003164917.397871AB276@localhost.localdomain>
	 <1412365908.13320.429.camel@snotra.buserror.net> <542FC6CC.4000507@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: christophe leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <542FC6CC.4000507-GgN8y9CXRhA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, 2014-10-04 at 12:07 +0200, christophe leroy wrote:
> The bindings for that driver are described in 
> Documentation/devicetree/bindings/spi/fsl-spi.txt. But it seems that it 
> doesn't describe anything related to those compatibles. The driver has a 
> match on "fsl,fsl-spi" only,

I think you mean "fsl,spi", and that's a terrible compatible name.

>  and for using it with CPM you have to add 
> "fsl,cpm1-spi" or "fsl,cpm2-spi" to tell the driver that it is CPM 
> (existing code below).

fsl-spi.txt doesn't describe CPM1/2 at all, but rather QE (CPM3) and
non-CPM.

-Scott


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
