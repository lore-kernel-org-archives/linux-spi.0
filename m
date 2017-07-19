From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 2/2] spi: imx: document use of native chip-selects in devicetree
Date: Tue, 18 Jul 2017 21:42:18 -0300
Message-ID: <CAOMZO5B55NzBpZscqQECt=2nUQatnU7s2Oc8YLkxFa-dbaB=bA@mail.gmail.com>
References: <1499746932-14850-1-git-send-email-gerg@linux-m68k.org>
 <1499746932-14850-3-git-send-email-gerg@linux-m68k.org> <CAOMZO5A6CZAQUh3mBpH3AdEtcTH-=tdMdqL-SV+4=zcstVQEaQ@mail.gmail.com>
 <42e1aad1-ca53-ba70-2922-25e2b083d971@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <42e1aad1-ca53-ba70-2922-25e2b083d971-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Vladimir,

On Tue, Jul 18, 2017 at 9:39 PM, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org> wrote:

> FWIW I tested on DT-only i.MX31, the change works acceptable.

MX31 has an issue with native chip select as far as I remember. Please
check DSPhl22960 from the chip errata:
http://www.nxp.com/docs/en/errata/MCIMX31CE.pdf
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
