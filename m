From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 3/5] spi: Added way to check for pm support for flash devices
Date: Mon, 6 Feb 2017 14:32:54 -0500
Message-ID: <CAC=U0a34UmSpH-QScJmc7Q62vq1r-5j+qtJMkuyKNtNL1_WT2g@mail.gmail.com>
References: <1486164676-12912-1-git-send-email-kdasu.kdev@gmail.com>
 <1486164676-12912-4-git-send-email-kdasu.kdev@gmail.com> <20170204112555.p77votp5m7klygbe@sirena.org.uk>
 <CAC=U0a0o21taio6jYzTCx1ix85aFNtikXHs=O99OW1pChbG4TA@mail.gmail.com>
 <11cfd6da-c537-eca9-5c50-7789d5b672dd@atmel.com> <20170206164634.awi4oe5e4o4w2kmj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170206164634.awi4oe5e4o4w2kmj-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Patches 3-5 are not needed. I will refactor patch 1-2 and send a v2 version=
.

Thanks
Kamal

On Mon, Feb 6, 2017 at 11:46 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Feb 06, 2017 at 11:44:09AM +0100, Cyrille Pitchen wrote:
>> Le 04/02/2017 =C3=A0 21:47, Kamal Dasu a =C3=A9crit :
>
>> >> What is "flash pm" and how would a client use it given that no API fo=
r
>> >> actually managing power is being added here?  Someone looking at the =
API
>> >> needs to be able to figure these things out and right now I can't see
>> >> how they'd do that...o
>
>> > The flash_pm function just indicates if  m25p80 resume op that does a
>> > spi_nor_pm_rescan() is needed, and by default will do nothing for
>> > other platforms. So the basic idea of the patches was to execute the
>> > only necessary spi_nor_pm_rescan() on resume when flash parts are
>> > reset on suspend. So from controller perspective there is no
>
> I can't tell what this means, sorry, and writing this e-mail does not
> address the incomprehensibility of the API.  Why would the controller
> driver have anything to do with whatever this spi_nor_pm_rescan()
> operation does?
>
>> I don't understand why we extend in the SPI framework API to add power
>> management features but only for SPI flashes. I guess concerning the pow=
er
>> management, there is nothing special about SPI flashes: they are just SP=
I
>> devices like others. So why not extend the SPI framework, if needed, wit=
h
>> something working for all SPI devices, not just for SPI flashes.
>
> It's already possible for SPI devices to do runtime PM.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
