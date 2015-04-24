From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] devicetree: add binding documentation for the AR7100
 SPI controller
Date: Fri, 24 Apr 2015 20:37:38 +0300
Message-ID: <553A7F62.80108@cogentembedded.com>
References: <1429885164-28501-1-git-send-email-albeu@free.fr> <1429885164-28501-2-git-send-email-albeu@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
To: Alban Bedel <albeu-GANU6spQydw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429885164-28501-2-git-send-email-albeu-GANU6spQydw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello.

On 04/24/2015 05:19 PM, Alban Bedel wrote:

> Signed-off-by: Alban Bedel <albeu-GANU6spQydw@public.gmane.org>
> ---
>   .../devicetree/bindings/spi/spi-ath79.txt          | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-ath79.txt

> diff --git a/Documentation/devicetree/bindings/spi/spi-ath79.txt b/Documentation/devicetree/bindings/spi/spi-ath79.txt
> new file mode 100644
> index 0000000..f1ad9c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-ath79.txt
> @@ -0,0 +1,24 @@
> +Binding for Qualcomm Atheros AR7xxx/AR9xxx SPI controller
> +
> +Required properties:
> +- compatible: has to be "qca,<soc-type>-spi", "qca,ar7100-spi" as fallback.
> +- reg: Base address and size of the controllers memory area
> +- clocks: phandle to the AHB clock.

    s/to/of/?

> +- clock-names: has to be "ahb".
> +- #address-cells: <1>, as required by generic SPI binding.
> +- #size-cells: <0>, also as required by generic SPI binding.
> +
> +Child nodes as per the generic SPI binding.
> +
> +Example:
> +
> +	spi@1F000000 {

    All lowercase, please.

> +		compatible = "qca,ar9132-spi", "qca,ar7100-spi";
> +		reg = <0x1F000000 0x10>;

    Likewise.

[...]

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
