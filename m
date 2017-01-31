From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Tue, 31 Jan 2017 22:18:30 +0100
Message-ID: <CAJZ5v0iaD9WtGubF5G9NpXNNKWWhn-CNvawWpT37qkguzXi_HA@mail.gmail.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1485187737-22414-1-git-send-email-dan@emutex.com> <1485187737-22414-4-git-send-email-dan@emutex.com>
 <CAJZ5v0hAoOQN+d4iBSgSkkYHBOy-Pt9HLrKG4SjcQUB6Ya1bgA@mail.gmail.com> <20170131201736.cmiyq2obzrhgdsck@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "Dan O'Donovan" <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>,
        ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170131201736.cmiyq2obzrhgdsck-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 31, 2017 at 9:17 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Jan 30, 2017 at 10:41:33AM +0100, Rafael J. Wysocki wrote:
>> On Mon, Jan 23, 2017 at 5:08 PM, Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org> wrote:
>
>> Mark, any objections here?
>
> I've not looked yet, please allow a reasonable time for review

Sure, no problem at all.

> (there still seemed to be ongoing discussion at the ACPI level).

Honestly, I'm not sure what you mean.

The first patch in the series (which is the ACPI level here) does not
seem to be controversial at all and the i2c one has been acked
already.

> I continue to be concerned about the amount of duplication and special casing that the
> various firmware paths seem to entail.

Well, this particular change is relatively straightforward and one can
argue that it fixes a bug.  It does address a problem for sure.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
