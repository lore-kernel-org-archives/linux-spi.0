From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: Add binding for Broadcom MSPI driver.
Date: Tue, 12 May 2015 11:38:57 -0700
Message-ID: <555248C1.2010203@gmail.com>
References: <1431452293-16697-1-git-send-email-jonathar@broadcom.com> <1431452293-16697-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431452293-16697-2-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/05/15 10:38, Jonathan Richardson wrote:
> 
> Signed-off-by: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/brcm,mspi-spi.txt      |   39 ++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt b/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
> new file mode 100644
> index 0000000..e86a7a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
> @@ -0,0 +1,39 @@
> +Broadcom MSPI controller
> +
> +The Broadcom MSPI controller is a SPI controller found on various chips such
> +as Cygnus.
> +
> +Required properties:
> +- compatible: Must be "brcm,mspi-v0".
> +
> +- reg:  The first register is the physical base address of the MSPI controller.
> +  The second register is the address of the MSPI interrupt control registers. It
> +  is only required for chips that have a separate register set for extended
> +  interrupt control. This is required for Cygnus.

In which case we would want to mandate the use of a "reg-names"
property, because there could be other kinds of controllers, such as the
one found on BCM7xxx where we have the 3 "reg" units, the first one is
the MSPI controller register range, while the two others are used for
the Boot SPI portion of the controller to accelerate flash reads, so
completely unrelated here.

Right now, using your driver on this Device Tree/configuration makes
bcm_mspi request the second register range and mistakenly assuming this
is the extended interrupt control register.

You could argue that the BSPI portion should be a separate node, but
even so, better be safe than sorry.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
