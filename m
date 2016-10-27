From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-espi: avoid processing uninitalized data on
 error
Date: Thu, 27 Oct 2016 20:11:35 +0200
Message-ID: <7456def3-64e4-e679-b38a-2edc4b4072b0@gmail.com>
References: <b5d3b5f3-034e-28c4-e616-69de4bf7cb8f@gmail.com>
 <20161027101417.GG25322@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161027101417.GG25322-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 27.10.2016 um 12:14 schrieb Mark Brown:
> On Thu, Oct 27, 2016 at 07:55:30AM +0200, Heiner Kallweit wrote:
>> When we get a spurious interrupt in fsl_espi_irq, we end up
>> processing four uninitalized bytes of data, as shown in this
>> warning message:
> 
> This doesn't apply against current code, please check and resend.
> 
OK, I'll provide an updated one. I thought it was intended to
replace Arnd's patch for next.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
