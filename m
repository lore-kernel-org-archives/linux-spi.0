From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 17/28] spi: fsl-espi: avoid processing uninitalized data
 on error
Date: Mon, 24 Oct 2016 20:36:37 +0200
Message-ID: <f364c025-91c0-6625-e2a3-d00baf17d71c@gmail.com>
References: <20161017220342.1627073-1-arnd@arndb.de>
 <20161017221355.1861551-5-arnd@arndb.de>
 <20161024172713.GI17252@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
        Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Heiner Kallweit <heiner.kallweit-S0/GAf8tV78@public.gmane.org>,
        Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161024172713.GI17252-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 24.10.2016 um 19:27 schrieb Mark Brown:
> On Tue, Oct 18, 2016 at 12:13:38AM +0200, Arnd Bergmann wrote:
>> When we get a spurious interrupt in fsl_espi_irq, we end up
>> processing four uninitalized bytes of data, as shown in this
>> warning message:
> 
> This doesn't apply against current code, please check and resend.
> 
The not yet reviewed part of my patch series from Oct 2nd,
namely "[PATCH 07/11] spi: fsl-espi: fix and improve reading
from RX FIFO" replaces the code in question.
There's more to fix like removing polling from the ISR.
If you prefer to apply Arnd's fix first I'd rebase the open part
of the patch series and resend it.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
