From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: M25P80 Regulator Question
Date: Fri, 1 Nov 2013 13:44:33 -0400
Message-ID: <5273E881.8080401@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I am looking at enabling support for W25Q32DW  SPI chip on a Tegra
platform. I found that the m25p80 driver already supports the chip, so
enabling it through devicetree is simple:


+       spi@7000da00 {
+               status = "okay";
+               spi-flash@0 {
+                       compatible = "winbond,w25q32dw";
+                       reg = <0>;
+                       spi-max-frequency = <20000000>;
+               };
+       };

However, it seems on our platform, we need to ensure a regulator is on
to be able to access the SPI chip. I was wondering if there is already
some binding defined for such a supply. I looked at the binding doc for
m25p80 and didn't see anything obvious, nor did I find anything else
obvious while looking.

Is there some mechanism for defining this dependency?

Thanks,
Rhyland

-- 
nvpublic
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
