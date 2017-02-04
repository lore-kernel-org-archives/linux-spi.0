From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 3/5] spi: Added way to check for pm support for flash devices
Date: Sat, 4 Feb 2017 15:47:48 -0500
Message-ID: <CAC=U0a0o21taio6jYzTCx1ix85aFNtikXHs=O99OW1pChbG4TA@mail.gmail.com>
References: <1486164676-12912-1-git-send-email-kdasu.kdev@gmail.com>
 <1486164676-12912-4-git-send-email-kdasu.kdev@gmail.com> <20170204112555.p77votp5m7klygbe@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170204112555.p77votp5m7klygbe-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Feb 4, 2017 at 6:25 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Feb 03, 2017 at 06:31:14PM -0500, Kamal Dasu wrote:
>
>> Device drivers can check if the master controller driver has to support
>> flash pm. The controller driver indicates this using flash_pm_supported()
>> spi master interface.
>
> What is "flash pm" and how would a client use it given that no API for
> actually managing power is being added here?  Someone looking at the API
> needs to be able to figure these things out and right now I can't see
> how they'd do that...o

The flash_pm function just indicates if  m25p80 resume op that does a
spi_nor_pm_rescan() is needed, and by default will do nothing for
other platforms. So the basic idea of the patches was to execute the
only necessary spi_nor_pm_rescan() on resume when flash parts are
reset on suspend. So from controller perspective there is no
additional pm activity to be done. Patches 1/5-2/5 is what is needed
actually. And Patches 3/3 - 5/5 only add a check if m25p80 resume
should call spi_nor_pm_rescan(). And the controller driver shall
implement the flash_pm function and return true if it does need a
rescan to be done on resume.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
